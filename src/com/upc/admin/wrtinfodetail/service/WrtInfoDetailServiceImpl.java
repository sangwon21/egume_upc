package com.upc.admin.wrtinfodetail.service;

import java.util.List;
import java.util.Map;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.upc.admin.wrtinfodetail.dao.WrtInfoDetailDAO;
import com.upc.admin.wrtinfodetail.vo.ChrgHstyVO;
import com.upc.admin.wrtinfodetail.vo.CnfrmPrchIsueVO;
import com.upc.admin.wrtinfodetail.vo.CnfrmPrchReqVO;
import com.upc.common.alert.service.AlrtSmsService;
import com.upc.common.alert.vo.AlrtSmsVO;
import com.upc.common.file.service.MemberFileService;
import com.upc.common.file.vo.FileVO;
import com.upc.common.util.MessageUtils;

/**
 * 발급지원 작성 상세정보를 가져옴
 * @author 신혜영
 * @since 2018. 12. 26.
 * @version 1.3
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.1	2018.12.27		신혜영	견본 파일 업로드 기능 추가
 * 1.2	2018.12.28		신혜영	견본 확인, 원본 파일 등록 기능 추가
 * 1.3	2019.01.02		신혜영	상세정보, 수정요청사항 수정 기능 추가
 */
@Service("wrtInfoDetailService")
public class WrtInfoDetailServiceImpl implements WrtInfoDetailService {
	@Autowired
	private WrtInfoDetailDAO wrtInfoDetailDAO;

	@Autowired
	private MemberFileService fileService;
	
	@Autowired
	private AlrtSmsService alrtSmsService;

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(WrtInfoDetailServiceImpl.class);

	/**
	 * 발급신청 상세조회를 가져옴
	 * @param applnum
	 * @return CnfrmPrchReqVO
	 * @author 신혜영
	 * @since 2018. 12. 26.
	 * @version 1.1
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1	2019.01.17		신혜영	수정요청사항 개행문자 처리 추가
	 */
	@Override
	public CnfrmPrchReqVO selectCnfrmPrchReq(String applnum) {
		CnfrmPrchReqVO cnfrmPrchReqVO = wrtInfoDetailDAO.selectCnfrmPrchReq(applnum);
		
		if(cnfrmPrchReqVO.getSmplmdfreq() != null) {
			cnfrmPrchReqVO.setSmplmdfreq(cnfrmPrchReqVO.getSmplmdfreq().replaceAll("(\r\n|\r|\n|\n\r)", "  "));
		}
		
		if(cnfrmPrchReqVO.getIssuemdfreq() != null) {
			cnfrmPrchReqVO.setIssuemdfreq(cnfrmPrchReqVO.getIssuemdfreq().replaceAll("(\r\n|\r|\n|\n\r)", "  "));
		}
		
		logger.info("end select cnfrmprchreq logic: "+applnum);
		
		return cnfrmPrchReqVO;
	}

	/**
	 * 구매확인서 원본 목록을 가져옴
	 * @param issuenum
	 * @return List<CnfrmPrchIsueVO>
	 * @author 신혜영
	 * @since 2018. 12. 26.
	 * @version 1.0
	 */
	@Override
	public List<CnfrmPrchIsueVO> selectCnfrmPrchIsue(CnfrmPrchReqVO cnfrmPrchReqVO) {
		logger.info("end select cnfrmprchisue list logic");
		return wrtInfoDetailDAO.selectCnfrmPrchIsue(cnfrmPrchReqVO);
	}

	
	/**
	* 작성자 상세조회 화면에서 수정한 정보를 저장함
	* @param cnfrmPrchReqVO
	* @return void
	* @author 신혜영
	* @since 2019. 1. 2.
	* @version 1.0
	 * @throws Exception 
	*/
	@Override
	@Transactional
	public void updateCnfrmPrchReqInfo(CnfrmPrchReqVO cnfrmPrchReqVO, FileVO fileVO, MultipartFile tax[], MultipartFile sup[], String modTax[], String modSup[]) throws Exception {
		logger.info("update front cnfrmprchreq info with files logic");
		wrtInfoDetailDAO.updateCnfrmPrchReq(cnfrmPrchReqVO);
		
		fileVO.setApplnum(cnfrmPrchReqVO.getApplnum());
		
		for (int i = 0; i < 6; i++) {
			if (i <= 2) {
				if (!tax[i].isEmpty()) {
					if (!modTax[i].equals("")) {
						fileVO.setFileseq(modTax[i]);
						fileService.modifyFile(fileVO, tax[i]);
						logger.info("modTax: modify");
					} else {
						fileVO.setFormtype("세금계산서");
						fileService.insertFile(fileVO, tax[i]);
						logger.info("modTax: insert");
					}
				}
			} else {
				if (!sup[i - 3].isEmpty()) {
					if (!modSup[i - 3].equals("")) {
						fileVO.setFileseq(modSup[i - 3]);
						fileService.modifyFile(fileVO, sup[i - 3]);
						logger.info("modSup: modify");
					} else {
						fileVO.setFormtype("수출근거서류");
						fileService.insertFile(fileVO, sup[i - 3]);
						logger.info("modSup: insert");
					}
				}
			}
		}
		
		logger.info("update end cnfrmprchreq info with files logic");
		
		return;
	}
	
	/**
	 * 견본 파일 업로드 및 발급신청 견본 정보 업데이트
	 * @param file
	 * @return 
	 * @author 신혜영
	 * @since 2018. 12. 27.
	 * @version 1.2
	 * @throws Exception
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1	2018.12.28		신혜영	고객 잔여 건수 차감 추가
	 * 1.2	2018.12.31		신혜영	발급차감이력 조회, 등록 , 건수 차감 기능 추가/ 전송할 fileVO 객체로 변경
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertSmpFile(MultipartHttpServletRequest smpFileForm, String loginId) throws Exception {
		
		CnfrmPrchReqVO cnfrmPrchReqVO = new CnfrmPrchReqVO();
		cnfrmPrchReqVO.setPrtnum(smpFileForm.getParameter("prtnum"));
		cnfrmPrchReqVO.setApplnum(smpFileForm.getParameter("applnum"));
		cnfrmPrchReqVO.setRmncnt(Integer.parseInt(smpFileForm.getParameter("rmncnt")));
		cnfrmPrchReqVO.setApplditc(smpFileForm.getParameter("applditc"));
		cnfrmPrchReqVO.setSmpldocid(smpFileForm.getParameter("smpldocid"));
		
		//발급 차감 이력 조회
		//wrtInfoDetailDAO.selectChrg() : 0 일 경우, 견본 최초 등록
		//								: 0 아닐 경우, 견본 재등록
		if(wrtInfoDetailDAO.selectChrg(cnfrmPrchReqVO.getApplnum()) == 0) {
			//고객 잔여 건수 확인
			if(cnfrmPrchReqVO.getRmncnt() <= 0) {
				throw new Exception("invalid user rmncnt");
			}
			ChrgHstyVO chrgHstyVO = new ChrgHstyVO();
			
			chrgHstyVO.setPrtnum(cnfrmPrchReqVO.getPrtnum());
			chrgHstyVO.setApplnum(cnfrmPrchReqVO.getApplnum());
			chrgHstyVO.setChrgditc(cnfrmPrchReqVO.getApplditc());
			chrgHstyVO.setChrgcnt(1);
			chrgHstyVO.setRgstid(loginId);
			
			//발급 차감 이력 등록
			wrtInfoDetailDAO.insertChrg(chrgHstyVO);
			//고객 잔여 건수 차감
			if(wrtInfoDetailDAO.updateUsrRmncnt(cnfrmPrchReqVO.getPrtnum()) != 1) {
				logger.info("updating user rmncnt is failed: 고객 잔여 건수 차감 실패");
				throw new Exception("updating user rmncnt is failed");
			}
			logger.info("insert chrgHsty & minus user rmncnt");
		}

		FileVO fileVO = new FileVO();
		fileVO.setPrtnum(cnfrmPrchReqVO.getPrtnum());
		fileVO.setApplnum(cnfrmPrchReqVO.getApplnum());
		fileVO.setFormtype("견본");
		fileVO.setRgstid(loginId);
		
		//견본 파일 업로드
		String fileseq = fileService.insertFile(fileVO, smpFileForm.getFile("smpFile"));
	
		cnfrmPrchReqVO.setSmplfileid(fileseq);
		
		//발급신청 정보에 견본 정보 추가
		if(wrtInfoDetailDAO.updateSmpInfo(cnfrmPrchReqVO) != 1) {
			logger.info("updating cnfrmprchreq sample info is failed: 구매확인서 발급신청 견본 정보 업데이트 실패");
			throw new Exception("updating cnfrmprchreq sample info is failed");
		}

		//sms 등록 및 알림
		if (("Y").equals(smpFileForm.getParameter("smsyn"))) {
			AlrtSmsVO alrtSmsVO = new AlrtSmsVO();
			alrtSmsVO.setSm_RvMbNo(smpFileForm.getParameter("mgrphone"));
			alrtSmsVO.setSm_Msg(MessageUtils.getMessage("alrt.sms.msg.sample"));
			alrtSmsVO.setSm_code3(smpFileForm.getParameter("prtnum"));
			
			alrtSmsService.insertSms(alrtSmsVO);
		}
		logger.info("end upload sample file logic(file upload & update sample info & send sms)");
		
		return;
	}

	
	/**
	* 견본 확인 파일 업로드 및 발급신청 견본 확인 정보 업데이트
	* @param cnfrmPrchReqVO
	* @param file
	* @param loginId
	* @return void
	* @throws Exception 
	* @author 신혜영
	* @since 2018. 12. 28.
	* @version 1.0
	*/
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertSmpCnfrmFile(CnfrmPrchReqVO cnfrmPrchReqVO, MultipartFile file, String loginId) throws Exception {
		FileVO fileVO = new FileVO();
		fileVO.setPrtnum(cnfrmPrchReqVO.getPrtnum());
		fileVO.setApplnum(cnfrmPrchReqVO.getApplnum());
		fileVO.setFormtype("견본확인");
		fileVO.setRgstid(loginId);
		
		//견본 파일 업로드
		String fileseq = fileService.insertFile(fileVO, file);
		
		cnfrmPrchReqVO.setCnfrmfileid(fileseq);
		cnfrmPrchReqVO.setCnfrmid(loginId);
		
		//발급신청 정보에 견본 확인 정보 추가
		if (wrtInfoDetailDAO.updateSmpCnfrmInfo(cnfrmPrchReqVO) != 1) {
			logger.info("updating cnfrmprchreq sample confirm info is failed: 구매확인서 발급신청 견본 확인 정보 업데이트 실패");
			throw new Exception("updating cnfrmprchreq sample confirm info is failed");
		}
		
		//sms 등록 및 알림
		if (("Y").equals(cnfrmPrchReqVO.getSmsyn())) {
			AlrtSmsVO alrtSmsVO = new AlrtSmsVO();
			alrtSmsVO.setSm_RvMbNo(cnfrmPrchReqVO.getMgrphone());
			alrtSmsVO.setSm_Msg(MessageUtils.getMessage("alrt.sms.msg.sampleConfirm"));
			alrtSmsVO.setSm_code3(cnfrmPrchReqVO.getPrtnum());
			
			alrtSmsService.insertSms(alrtSmsVO);
		}
		logger.info("end upload sample confirm file logic");
		
		return;
	}

	/**
	* 원본 파일 업로드, 구매확인서발급 정보 저장, 구매확인서신청 정보 업데이트
	* @param cnfrmPrchIsueVO
	* @param file
	* @param loginId
	* @return void
	* @throws Exception
	* @author 신혜영
	* @since 2018. 12. 28.
	* @version 1.0
	*/
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertIssueFile(CnfrmPrchIsueVO cnfrmPrchIsueVO, MultipartFile file, String loginId) throws Exception {
		FileVO fileVO = new FileVO();
		fileVO.setPrtnum(cnfrmPrchIsueVO.getPrtnum());
		fileVO.setApplnum(cnfrmPrchIsueVO.getApplnum());
		fileVO.setFormtype("원본");
		fileVO.setRgstid(loginId);
		
		//원본 파일 업로드
		String fileseq = fileService.insertFile(fileVO, file);
		
		cnfrmPrchIsueVO.setIsuefileid(fileseq);
		cnfrmPrchIsueVO.setRgstid(loginId);
		
		//구매확인서발급 정보 추가
		if (wrtInfoDetailDAO.insertIssue(cnfrmPrchIsueVO) != 1) {
			logger.info("inserting cnfrmprchisue is failed: 구매확인서 발급 정보 저장 실패");
			throw new Exception("inserting cnfrmprchisue is failed");
		}
		
		//발급신청 정보에 구매확인서번호 업데이트
		if (wrtInfoDetailDAO.updateIssueInfo(cnfrmPrchIsueVO) != 1) {
			logger.info("updating cnfrmprchreq issue info is failed: 구매확인서 발급신청 구매확인서번호 업데이트 실패");
			throw new Exception("updating cnfrmprchreq issue info is failed");
		}
		
		//sms 등록 및 알림
		if (("Y").equals(cnfrmPrchIsueVO.getSmsyn())) {
			AlrtSmsVO alrtSmsVO = new AlrtSmsVO();
			alrtSmsVO.setSm_RvMbNo(cnfrmPrchIsueVO.getMgrphone());
			alrtSmsVO.setSm_Msg(MessageUtils.getMessage("alrt.sms.msg.issue"));
			alrtSmsVO.setSm_code3(cnfrmPrchIsueVO.getPrtnum());
			
			alrtSmsService.insertSms(alrtSmsVO);
		}
		logger.info("end upload issue file logic");
		
		return;
	}

	/**
	* 수정요청사항 저장
	* @param type
	* @param mdfReq
	* @return int
	* @author 신혜영
	* @since 2019. 1. 2.
	* @version 1.0
	*/
	@Override
	public int updateMdfReq(Map<String, Object> mdfReqMap) {
		logger.info("front save modify request logic");
		return wrtInfoDetailDAO.updateMdfReq(mdfReqMap);
	}

}