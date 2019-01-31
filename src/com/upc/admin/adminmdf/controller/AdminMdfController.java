package com.upc.admin.adminmdf.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.upc.admin.adminmypage.service.AdminMyPageService;
import com.upc.admin.common.vo.AdminVO;


/**
 * 어드민 정보 수정을 담당하는 컨트롤러
 * @author 김진혁
 * @since 2018. 12. 19.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2018.12.19	김진혁		최초작성
 */
@Controller
@RequestMapping("/admin")
public class AdminMdfController {
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AdminMdfController.class);
	
	@Autowired
	private AdminMyPageService adminMyPageService;
	
	
	/**
	 * 어드민 정보 수정 뷰를 제공하는 메소드
	 * @param model
	 * @param principal
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2018. 12. 19.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.19	김진혁		최초작성
	 */
	@RequestMapping(value = "/adminMdf.do", method = RequestMethod.GET)
	public String getAdminMdfView(Model model, Principal principal, @RequestParam String admid) throws Exception {
		AdminVO adminVO = adminMyPageService.getAdminInfo(admid);
		logger.info("adminVO={}",adminVO);
		model.addAttribute("AdminVO",adminVO);
		return "admin/adminMdf";
	}  
	 
	
	/**
	 * 어드민 정보 수정 처리하는 메소드
	 * @param adminVO
	 * @param principal
	 * @param model
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2018. 12. 19.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.19	김진혁		최초작성
	 */
	@RequestMapping(value = "/adminMdfReq", method = RequestMethod.GET)
	public String mdfAdmin(@ModelAttribute AdminVO adminVO, Principal principal, Model model) throws Exception {
		String id = principal.getName();
		adminVO.setMdfid(id);
		adminMyPageService.updateAdminInfoEcpPw(adminVO);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		List<GrantedAuthority> updatedAuthorities = new ArrayList<>();
		String ChangedAuth = adminVO.getRole();
		SimpleGrantedAuthority authority = new SimpleGrantedAuthority(ChangedAuth);
		updatedAuthorities.add(authority); 
		Authentication newAuth = new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(), updatedAuthorities);
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		if(adminVO.getUseyn().equals("N")) {
			return "redirect:adminLogin.do";
		}
		else {
			if(adminVO.getRole().equals("M")) {
				return "redirect:userJoinReqList.do";
			}
			else if(adminVO.getRole().equals("R")) {
				return "redirect:applrcpt/prchCnfrmApplList.do";
			}
			else if(adminVO.getRole().equals("W")) {
				return "redirect:wrtlist.do";
			}
			else {
				return "redirect:/";
			}
		}
		
	}  
}	
