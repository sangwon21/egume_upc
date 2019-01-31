package com.upc.common.login.controller;

import java.security.Principal;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.upc.admin.adminmypage.service.AdminMyPageService;
import com.upc.admin.adminrgst.service.AdminRgstService;
import com.upc.admin.common.vo.AdminVO;
import com.upc.common.rgstid.service.MemberRgstService;
import com.upc.user.usrinf.service.MemberInfoService;
import com.upc.user.usrinf.vo.UsrInfVO;



/**
 * 로그인 처리 페이지를 담당하는 컨트롤러
 * @author 김진혁
 * @since 2018. 12. 13.
 * @version 1.2
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0 		2018.12.13	김진혁		최초작성
 * 1.1		2018.12.14	김진혁		loginDo 메소드 추가
 * 1.2		2018.12.18	김진혁		loginDo 메소드 삭제, accessDenied/adminMain/userMain 메소드 추가
 * 1.3		2018.01.09	이수빈		로그인 시 아이디 체크 메소드 추가 ( 주석처리 )
 */
@Controller
public class LoginController {
	
	@Autowired
	MemberRgstService userService;
	
	@Autowired
	AdminRgstService adminService;
	
	@Autowired
	private AdminMyPageService adminMyPageService;
	
	@Autowired
	private MemberInfoService memberInfoService;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
		
	/**
	 * 디폴트 페이지 처리 메소드
	 * 로그인 페이지 요청 시 로그인 페이지를 응답하는 메소드
	 * @param locale
	 * @param model
	 * @return
	 * @author 김진혁
	 * @since 2018. 12. 13.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.13	김진혁		최초작성
	 * 1.1		2019.01.11	이수빈		발급건수 조회되도록 추가 & loginForm.do/ "/" 메소드 하나로 합침
	 * @throws Exception 
	 */
	@RequestMapping(value = {"/", "/user/loginForm.do"}, method = RequestMethod.GET)
	public ModelAndView defaultPage(Locale locale, Model model, Principal principal) throws Exception {
		ModelAndView mv = new ModelAndView("main");
		if(principal==null) {
			logger.info("null principal={}",principal);
		}
		else {
			logger.info("principal={}",principal);
			UsrInfVO usrInfVO = memberInfoService.selectUsrInf(principal.getName());
			
			if(usrInfVO.getPrepayyn().equals("Y") || usrInfVO.getRmncnt() != 0) {	
				mv.addObject("rmncnt", usrInfVO.getRmncnt());
				mv.addObject("prepayyn", usrInfVO.getPrepayyn());
			} 
		}
		return mv;
	}
	
	/**
	 * 어드민 로그인 페이지 요청 시 응답하는 메소드
	 * @param locale
	 * @param model
	 * @return
	 * @author 김진혁
	 * @since 2019. 1. 4.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일			수정자		수정내용
	 * 1.0		2019.1.4	김진혁		최초작성
	 */
	@RequestMapping(value = "/admin/adminLogin.do", method = RequestMethod.GET)
	public String adminLoginForm(Locale locale, Model model, Principal principal) throws Exception{
		if(principal==null) {
			logger.info("null principal={}",principal);
			return "adminLogin";
		}
		else {
			logger.info("principal={}",principal);
			AdminVO adminVO = adminMyPageService.getAdminInfo(principal.getName());
			logger.info("logined admin={}",adminVO);
			if(adminVO.getRole().equals("M")) {
				return "redirect:/admin/userJoinReqList.do";
			}
			else if(adminVO.getRole().equals("R")) {
				return "redirect:/admin/applrcpt/prchCnfrmApplList.do";
			}
			else if(adminVO.getRole().equals("W")) {
				return "redirect:/admin/wrtlist.do";
			}	
			else {
				return "adminLogin";
			}
		}
		
	}
	
	
	/**
	 * 로그인 처리 시 접근이 제한되었을 때 응답 페이지를 제공하는 메소드
	 * @param locale
	 * @param model
	 * @return
	 * @author 김진혁
	 * @since 2018. 12. 18.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.18	김진혁		최초작성
	 * 1.1		2019.01.11	이수빈		에러페이지 경로 수정
	 */
	@RequestMapping(value = "/error/accessDenied", method = RequestMethod.GET)
	public String accessDenied(Locale locale, Model model) {
		logger.info("Welcome Access Denied!");
		
		return "error/403";
	}
	
	/**
	 * admin전용 메인 페이지를 제공하는 메소드
	 * @param locale
	 * @param model
	 * @param principal
	 * @return
	 * @author 김진혁
	 * @since 2018. 12. 18.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.18	김진혁		최초작성
	 */
	@RequestMapping(value = "/admin/adminMain.do", method = RequestMethod.GET)
	public String adminMain(Locale locale, Model model, Principal principal) {
		String name=principal.getName();	
		logger.info("name = {}", name);
		model.addAttribute("name", name);
		return "/admin/adminMain";
	}
	
}	
