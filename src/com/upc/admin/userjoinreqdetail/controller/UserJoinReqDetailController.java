package com.upc.admin.userjoinreqdetail.controller;

import java.security.Principal;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.upc.admin.userjoinreqdetail.service.UserJoinReqDetailService;
import com.upc.admin.userjoinreqdetail.vo.UserJoinReqDetailVO;

/**
 * 고객 등록 신청서 상세 페이지를 담당하는 컨트롤러
 * @author 김진혁
 * @since 2019. 1. 2.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2019.1.2	김진혁		최초작성
 */
@Controller
@RequestMapping("/admin")
public class UserJoinReqDetailController {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(UserJoinReqDetailController.class);
	
	@Autowired
	private UserJoinReqDetailService userJoinReqDetailService;
	
	/**
	 * 고객 등록 신청서 상세 페이지 요청을 담당하는 메소드
	 * @param searchVO
	 * @param model
	 * @param prtnum
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2019. 1. 2.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2019.1.2	김진혁		최초작성
	 */
	@RequestMapping(value = "/userJoinReqDetail.do", method = RequestMethod.GET)
	public String getUserJoinReqDetailView(Model model, @RequestParam String prtnum) throws Exception{
		UserJoinReqDetailVO userJoinReqDetailVO = userJoinReqDetailService.getUserJoinReqInfo(prtnum);
		logger.info("userJoinReqDetailVO={}",userJoinReqDetailVO);
		model.addAttribute("userJoinReqDetailVO",userJoinReqDetailVO);
		return "admin/userJoinReqDetail";
	}   
	
	/**
	 * 고객 등록 신청서를 승인 요청을 담당하는 메소드
	 * @param userJoinReqDetailVO
	 * @param model
	 * @param principal
	 * @param bsnsFile
	 * @param checkFileChange
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2019. 1. 2.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2019.1.2	김진혁		최초작성
	 */
	@RequestMapping(value = "/userJoin", method = RequestMethod.POST)
	public String confirmUserJoinReq(@ModelAttribute UserJoinReqDetailVO userJoinReqDetailVO, Model model, Principal principal, @ModelAttribute MultipartFile bsnsFile, @RequestParam String checkFileChange) throws Exception{
		String admid=principal.getName();
		userJoinReqDetailVO.setMdfid(admid);
		userJoinReqDetailService.confirmUserJoin(userJoinReqDetailVO, bsnsFile, checkFileChange);
		return "redirect:userJoinReqList.do";
	}
}
