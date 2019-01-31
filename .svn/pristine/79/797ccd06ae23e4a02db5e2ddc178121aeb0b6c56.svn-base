package com.upc.common.rgstid.service;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.upc.common.file.service.MemberFileService;
import com.upc.common.file.vo.FileVO;
import com.upc.common.rgstid.dao.MemberRgstDAO;
import com.upc.common.rgstid.vo.UsrInfVO;


/**
 * 간편 사용자 등록 ServiceImpl
 * @author 이수빈
 * @Date 2018.12.13
 * @version 1.0
 * @see
 * 수정이력
 * 버전 	수정일 		수정자 	수정내용
 * 1.1	2018.12.26	이수빈	트랜잭션 처리
 * */
@Service("memberRgstService")
@Transactional
public class MemberRgstServiceImpl implements MemberRgstService {

	@Autowired
	private MemberRgstDAO dao;
	
	@Autowired
	private MemberFileService fileService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;


	/**
	 * 간편사용자등록 (직접입력/첨부파일) 등록
	 * @param usrInfVO
	 * @author 이수빈
	 * @since 2018.12.13
	 * @version 1.0
	 * @see 
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1		2018.12.26	이수빈		트랜잭션처리(파일 업로드 에러 시 가입정보 rollback)
	 * 1.2		2018.12.31	이수빈		insertMember input Parameter 변경 (fileVO로 변경)
	 * 1.3		2019.01.02	이수빈		회원정보조회 bsnsfileid/applfileid 값 변경
	 * */
	@Override
	@Transactional(rollbackFor=Exception.class)
	public void insertMember(UsrInfVO usrInfVO, FileVO fileVO, MultipartFile bsnsFile, MultipartFile applFile) throws Exception {
		// TODO Auto-generated method stub
		
		String pw = passwordEncoder.encode(usrInfVO.getPw());
		usrInfVO.setPw(pw);
		
		fileVO.setFormtype("사업자등록증");
		String bsnsfileid = fileService.insertFile(fileVO, bsnsFile);
		String applfileid = null;
		if(applFile != null) {
			//logger.info("applFileInfo : " + applFile.getOriginalFilename());
			fileVO.setFormtype("가입신청서");
			applfileid = fileService.insertFile(fileVO, applFile);
		}
		
		usrInfVO.setBsnsfileid(bsnsfileid);
		usrInfVO.setApplfileid(applfileid);
		
		dao.insertMember(usrInfVO);

	}

	/**
	 * 사업자등록번호(아이디) 중복 체크
	 * @param String(prtnum)
	 * @return
	 * @author 이수빈
	 * @since 2018.12.19
	 * @version 1.0
	 * @see 
	 * 
	 * */
	@Override
	public int checkId(String prtnum) throws Exception {
		return dao.checkId(prtnum);
	}

	
}
