package com.upc.common.login.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.upc.common.login.service.UserAuthenticationServiceImpl;

/**
 * 로그인 실패 시 수행할 로직을 구성하는 핸들러
 * @author 이수빈
 * @since 2019.01.04.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2019.01.04	이수빈		최초작성
 */

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler{

	private static Logger logger = LoggerFactory.getLogger(CustomAuthenticationSuccessHandler.class);
	
	@Autowired
	UserAuthenticationServiceImpl service;
	
	private String loginId;
	private String loginPw;
	private String loginRedirectUrl;
	private String exceptionMsg;
	private String defaultUrl;
	
	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginPw() {
		return loginPw;
	}

	public void setLoginPw(String loginPw) {
		this.loginPw = loginPw;
	}

	public String getLoginRedirectUrl() {
		return loginRedirectUrl;
	}

	public void setLoginRedirectUrl(String loginRedirectUrl) {
		this.loginRedirectUrl = loginRedirectUrl;
	}

	public String getExceptionMsg() {
		return exceptionMsg;
	}

	public void setExceptionMsg(String exceptionMsg) {
		this.exceptionMsg = exceptionMsg;
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	public CustomAuthenticationFailureHandler() {
		this.loginId = "id";
		this.loginPw = "password";
		this.loginRedirectUrl = "loginRedirect";
		this.exceptionMsg = "securityexceptionmsg";
		this.defaultUrl = "/user/loginForm.do?error";
	}
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
	
		String id = request.getParameter(loginId);
		String pw = request.getParameter(loginPw);
		String loginRedirect = request.getParameter(loginRedirectUrl);
		
		request.setAttribute(loginId, id);
		request.setAttribute(loginPw, pw);
		request.setAttribute(loginRedirectUrl, loginRedirect);
		
		request.setAttribute(exceptionMsg, exception.getMessage());
		
		UserDetails userDetails = service.loadUserByUsername(id);
		
		try {
			userAuthorityDenied(response, userDetails);	// 사용자등록번호/패스워드 검사 후 로그인 실패 처리를 위해 alert를 띄어주는 함수
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}
	
	/**
	 * 로그인 실패 시 수행할 로직을 담당하는 메소드
	 * (휴면계정, 승인중, 로그인 실패 - 아이디/패스워드 불일치)
	 * @param response
	 * @param userDetails - 유저정보
	 * @author 이수빈
	 * @since 2019. 01. 04
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2019.01.04	이수빈		최초작성
	 */
	public void userAuthorityDenied(HttpServletResponse response, UserDetails userDetails) throws Exception {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		if(userDetails.getAuthorities().contains(new SimpleGrantedAuthority("P"))){
			out.println("<script>alert('서비스 승인중입니다.');");
			out.println("history.go(-1);</script>"); 
			out.flush();
		} else if(userDetails.getAuthorities().contains(new SimpleGrantedAuthority("N"))) {
			out.println("<script>alert('휴면계정입니다. 관리자에게 문의해주십시오.');");
			out.println("history.go(-1);</script>"); 
			out.flush();
		} else {
			out.println("<script>alert('아이디와 비밀번호가 일치하지 않습니다.');"
					+ "history.go(-1);</script>");
		}
	}
	
}
