package com.upc.common.exception.interceptor;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


/**
 * 예외 처리 핸들러
 * @author 강성효
 * @since 2019. 01. 10.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2019.01.10	강성효		최초작성
 * 1.1		2019.01.10	이수빈		Controller 경로 설정
 */
@ControllerAdvice
public class EgumeExceptionHandler {
	
	Logger log = LoggerFactory.getLogger(EgumeExceptionHandler.class);
	
	@ExceptionHandler(Exception.class)
	public String exception(Exception e) {

		log.error("message",e);

		return "redirect:/400_Error_Page";
	}

	@ExceptionHandler(IOException.class)
	public String ioExcption(Exception e) {
		log.error("파일입출력 오류입니다.",e);
		
		return "redirect:/400_Error_Page";
	}
	
	@ExceptionHandler(SQLException.class)
	public String sqlException(Exception e, HttpServletResponse response, HttpServletRequest request) throws IOException {
		log.error("SQL 오류입니다.",e);
		
		return "redirect:/500_Error_Page";
	}
	
	
	
	

}
