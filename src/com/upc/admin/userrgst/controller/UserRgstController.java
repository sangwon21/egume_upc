package com.upc.admin.userrgst.controller;

import java.security.Principal;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.upc.admin.userrgst.service.UserRgstService;
import com.upc.admin.userrgst.vo.UsrInfVO;


/**
 * 고객 등록을 담당하는 컨트롤러
 * @author 김진혁
 * @since 2018. 12. 28.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2018.12.28	김진혁		최초작성
 */
@Controller
@RequestMapping("/admin")
public class UserRgstController {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(UserRgstController.class);
	
	@Autowired
	private UserRgstService userRgstService;
	
	/**
	 * 고객 등록 페이지 요청을 담당하는 메소드
	 * @param model
	 * @return
	 * @author 김진혁
	 * @since 2018. 12. 28.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.28	김진혁		최초작성
	 */
	@RequestMapping(value = "/userRgst.do", method = RequestMethod.GET)
	public String getUserRgstView(Model model) {
		return "admin/userRgst";
	}  
	
	/**
	 * 고객 등록 요청을 담당하는 메소드
	 * @param usrInfVO
	 * @param bsnsFile
	 * @param principal
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2018. 12. 28.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.28	김진혁		최초작성
	 */
	@RequestMapping(value = "/userRgst", method = RequestMethod.POST)
	public String userRgst(@ModelAttribute UsrInfVO usrInfVO, @ModelAttribute MultipartFile bsnsFile, Principal principal) throws Exception{
		String admid=principal.getName();
		usrInfVO.setRgstid(admid);
		userRgstService.insertMemberByAdm(usrInfVO, bsnsFile);
		return "redirect:userList.do";
	}
}
