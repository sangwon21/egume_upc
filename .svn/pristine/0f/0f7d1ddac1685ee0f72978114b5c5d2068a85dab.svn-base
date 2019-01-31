/**
 * 파일관리 controller
 * (사업자등록증사본, 가입신청서)
 * @author 이 수빈
 * @Date 2018.12.17
 * @version 1.0
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 
 */
package com.upc.common.file.controller;


import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.upc.common.file.service.MemberFileService;
import com.upc.common.file.vo.FileVO;

@Controller
public class MemberFileController {
  
	@Autowired
	MemberFileService service;
	
	/** 
	 * 파일 다운로드
	 * @param 
	 * @return
	 * @author 이수빈
	 * @since 2018.12.17
	 * @version 1.0
	 * 수정이력
	 * 버전	수정일		수정자	내용
	 * 1.1	2018.12.27	이수빈	압축파일 다운로드
	 * 1.2	2018.12.28	이수빈	기능구현 서비스로 이동
	 */
	@RequestMapping(value="/filedownload", method=RequestMethod.GET)
	public String download(HttpServletResponse response, String fileseq) throws Exception {
		
		service.filedownload(response, fileseq);

	    return null;
	}
	
	/** 
	 * @return
	 * @author 강성효
	 * @since 2019. 1. 8.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * @throws Exception 
	 */
	@GetMapping("/filepdfview")
	public String fileViewer(HttpServletResponse response, @ModelAttribute FileVO fileVO) throws Exception {
		service.fileViewer(response, fileVO);
		return null;
	}

}