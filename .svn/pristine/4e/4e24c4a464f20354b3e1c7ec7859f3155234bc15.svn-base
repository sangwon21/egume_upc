package com.upc.admin.usermdf.controller;

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

import com.upc.admin.usermdf.service.UserMdfService;
import com.upc.admin.usermdf.vo.UserMdfVO;

/**
 * 고객 정보 수정을 담당하는 컨트롤러
 * @author 김진혁
 * @since 2018. 12. 27.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2018.12.27	김진혁		최초작성
 */
@Controller
@RequestMapping("/admin")
public class UserMdfController {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(UserMdfController.class);
	
	@Autowired
	private UserMdfService userMdfService;
	
	/**
	 * 고객 정보 수정 페이지 요청을 담당하는 메소드
	 * @param model
	 * @param prtnum
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2018. 12. 27.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.27	김진혁		최초작성
	 */
	@RequestMapping(value = "/userMdf.do", method = RequestMethod.GET)
	public String getUserMdfView(Model model, @RequestParam String prtnum) throws Exception{
		UserMdfVO userMdfVO = userMdfService.getUserInfo(prtnum);
		model.addAttribute("userMdfVO", userMdfVO);
		return "admin/userMdf";
	}
	
	/**
	 * 고객 정보 수정 요청을 담당하는 메소드
	 * @param model
	 * @param userMdfVO
	 * @param bsnsFile
	 * @param principal
	 * @param checkFileChange
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2018. 12. 27.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.27	김진혁		최초작성
	 */
	@RequestMapping(value = "/userMdfReq", method = RequestMethod.POST)
	public String mdfUser(Model model, @ModelAttribute UserMdfVO userMdfVO, @ModelAttribute MultipartFile bsnsFile, Principal principal, @RequestParam String checkFileChange) throws Exception{
		logger.info("Controller bsnsFile={}",bsnsFile);
		String admid = principal.getName();
		userMdfVO.setMdfid(admid);
		userMdfService.mdfUserInfo(userMdfVO, bsnsFile, checkFileChange);
		return "redirect:userList.do";
	}
}
