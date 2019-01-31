package com.upc.admin.applrcptrgst.controller;


import java.security.Principal;
import java.util.ArrayList;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.upc.admin.adminmypage.service.AdminMyPageServiceImpl;
import com.upc.admin.applrcptlist.vo.ApplRcptListVO;
import com.upc.admin.applrcptrgst.service.ApplRcptRgstServiceImpl;
import com.upc.admin.common.vo.AdminVO;
import com.upc.admin.wrtinfodetail.service.WrtInfoDetailService;
import com.upc.admin.wrtinfodetail.vo.CnfrmPrchReqVO;
import com.upc.common.file.vo.FileVO;
import com.upc.user.reqfrm.vo.ReqFrmVO;
import com.upc.user.usrinf.service.MemberInfoServiceImpl;
import com.upc.user.usrinf.vo.UsrInfVO;

/**
 * 발급신청 등록&상세 관련 컨트롤러
 * @author 강성효
 * @since 2018. 12. 26.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */
@Controller
@RequestMapping("/admin/applrcpt")
public class ApplRcptRgstController{
	
	Logger log = LoggerFactory.getLogger(ApplRcptRgstController.class);
	
	@Autowired
	private ApplRcptRgstServiceImpl	applRcptRgstServiceImpl;
	@Autowired
	private MemberInfoServiceImpl memberInfoServiceImpl;
	@Autowired
	private AdminMyPageServiceImpl adminMdfServiceImpl;
	@Resource(name = "wrtInfoDetailService")
	private WrtInfoDetailService wrtInfoDetailService;
	
	/** 
	 * 등록화면
	 * @param applRcptListVO
	 * @return 등록정보, 구매자정보, 입력정보, 첨부서류정보
	 * @author 강성효
	 * @since 2018. 12. 26.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * @throws Exception 
	 */
	@GetMapping("/prchCnfrmApplRegister.do")
	private ModelAndView recpListView(@ModelAttribute ApplRcptListVO applRcptListVO,Principal principal) throws Exception {
		log.info("request : 등록&수정 화면");
		
		ModelAndView mv = new ModelAndView();
		ApplRcptListVO applRcptOne = applRcptRgstServiceImpl.applRcptOne(applRcptListVO);
		AdminVO adminVO = adminMdfServiceImpl.getAdminInfo(principal.getName());
		UsrInfVO usrInfVO = memberInfoServiceImpl.selectUsrInf(applRcptListVO.getPrtNum());
		ArrayList<FileVO> fileList = applRcptRgstServiceImpl.fileInfoList(applRcptListVO);
		
		//등록정보
		mv.addObject("adminVO",adminVO);
		//구매자정보
		mv.addObject("usrInfVO",usrInfVO);
		//입력정보
		mv.addObject("applRcptOne",applRcptOne);
		//첨부서류
		mv.addObject("fileList",fileList);

		mv.setViewName("applrcpt/registerView");
		
		log.info("response : 등록&수정 화면");
		return mv;
	}
	
	
	/** 
	 * 등록 상세화면
	 * @param applRcptListVO
	 * @return 서류정보, 신청정보, 구매확인서정보
	 * @throws Exception
	 * @author 강성효
	 * @since 2019. 1. 4.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	@GetMapping("/prchCnfrmApplRgstDetail.do")
	private ModelAndView rgstDetailView(@ModelAttribute ApplRcptListVO applRcptListVO) throws Exception {
		log.info("request : 발급신청 상세화면");
		
		ModelAndView mv = new ModelAndView();
		
		//근거서류 가져옴
		ArrayList<FileVO> fileList = applRcptRgstServiceImpl.fileInfoList(applRcptListVO);
		mv.addObject("fileList",fileList);
		
		//신청 상세조회 정보 가져옴 
		CnfrmPrchReqVO cnfrmPrchReqVO = wrtInfoDetailService.selectCnfrmPrchReq(applRcptListVO.getApplNum());
		mv.addObject("cnfrmprchreq", cnfrmPrchReqVO);
		
		//구매확인서 원본 목록 가져옴
		if(cnfrmPrchReqVO.getIssuenum() != null) {
			mv.addObject("issueList", wrtInfoDetailService.selectCnfrmPrchIsue(cnfrmPrchReqVO));
		}
		mv.setViewName("applrcpt/detailView");
		log.info("response : 발급신청 상세화면");
		return mv;
	}
	
	/** 
	 * 고객정보 조회 
	 * @param prtNum
	 * @return 고객정보
	 * @author 강성효
	 * @since 2018. 12. 27.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * @throws Exception 
	 */
	@GetMapping("/usrInfo")
	@ResponseBody
	private UsrInfVO ajaxReqUsrInfo(@RequestParam String prtNum) throws Exception {
		log.info("request : 유저 상세정보");
		UsrInfVO usrInfVO = memberInfoServiceImpl.selectUsrInf(prtNum);
		log.info("response : 유저 상세정보 (UsrInfVO) ");
		return usrInfVO;
	}
	
	/** 
	 * 신청정보 조회
	 * @param applRcptListVO
	 * @return 신청정보
	 * @author 강성효
	 * @since 2018. 12. 30.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	@GetMapping("/applInfo")
	@ResponseBody
	private ApplRcptListVO ajaxAppInfo(@ModelAttribute ApplRcptListVO applRcptListVO){
		log.info("request : 발급신청 상세정보");
		ApplRcptListVO applRcptOne = applRcptRgstServiceImpl.applRcptOne(applRcptListVO);
		log.info("response : 발급신청 상세정보(applRcptOne)");
		return applRcptOne;
	}
	
	
	/** 
	 * 등록
	 * @param reqFrmVO
	 * @param fileVO
	 * @param tax
	 * @param sup
	 * @return 목록화면으로 Redirect
	 * @throws Exception
	 * @author 강성효
	 * @since 2019. 1. 2.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	@PostMapping("/register")
	private String applRgst(@ModelAttribute ReqFrmVO reqFrmVO, @ModelAttribute FileVO fileVO
			,MultipartFile tax[], MultipartFile sup[], String modTax[], String modSup[]) throws Exception {
		
		log.info("request : 발급신청 등록 & 수정");
			
		applRcptRgstServiceImpl.modApplRgst(reqFrmVO, fileVO, tax, sup,modTax,modSup);
		log.info("response : redirect 목록화면");
		return "redirect:/admin/applrcpt/prchCnfrmApplList.do";
	}
}
