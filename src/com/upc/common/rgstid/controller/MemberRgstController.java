/**
 * 간편 사용자 등록 controller
 * @author 이 수빈
 * @Date 2018.12.13
 * @version 1.0
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.1		2018.12.17	이수빈		간편 사용자 등록(직접입력 > 가입신청서) 기능 추가
 */
package com.upc.common.rgstid.controller;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.upc.common.file.vo.FileVO;
import com.upc.common.rgstid.service.MemberRgstService;
import com.upc.common.rgstid.vo.UsrInfVO;


@Controller
@RequestMapping("/rgstid/")
public class MemberRgstController {

	private static final Logger logger = LoggerFactory.getLogger(MemberRgstController.class);

	@Autowired
	private MemberRgstService rgstService;
	
	/** 
	 * 간편 사용자등록 페이지 (Default : 직접입력) 이동
	 * @author 이수빈
	 * @since 2018.12.13
	 * @version 1.0
	 */
	@RequestMapping(value="/join.do", method=RequestMethod.GET) 
	public String joinView() throws Exception {

		return "user/joinInfoC";
	}
	
	/** 
	 * 간편 사용자등록 첨부파일 페이지 이동
	 * @author 이수빈
	 * @since 2018.12.17
	 * @version 1.0
	 */
	@RequestMapping(value="/joinAsAtt.do", method=RequestMethod.GET) 
	public String joinAsAttView() throws Exception {
		
		return "user/joinAttInfoC";
	}
	
	/** 
	 * 간편 사용자등록 (직접입력) 계정 승인 요청
	 * @param usrInfVO
	 * @param multipartFile
	 * @return 
	 * @author 이수빈
	 * @since 2018.12.13
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1		2018.12.17	이수빈		간편 사용자 등록(직접입력 > 가입신청서) 기능 추가
	 * 1.2		2018.12.26	이수빈		트랜잭션처리(파일 업로드 에러 시 가입정보 rollback)
	 * 1.3		2018.12.31	이수빈		insertMember input Parameter 변경 (fileVO 추가)
	 */
	@RequestMapping(value="/join", method=RequestMethod.POST) 
	public String joinMember(@ModelAttribute UsrInfVO usrInfVO, @ModelAttribute FileVO fileVO, 
							@ModelAttribute MultipartFile bsnsFile, @ModelAttribute MultipartFile applFile,
							HttpServletResponse response) throws Exception {
		
		logger.info(usrInfVO.toString());
		logger.info("bsnsFileInfo : " + bsnsFile.getOriginalFilename());
		rgstService.insertMember(usrInfVO, fileVO, bsnsFile, applFile);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		out.println("<script>alert('신청이 완료되었습니다.'); location.href='/egume_upc/';</script>");
		out.flush();
		
		return null;
	}
	
	/** 
	 * 간편 사용자 등록 시 사업자등록번호 중복체크
	 * @param String(prtnum)
	 * @return 
	 * @author 이수빈
	 * @since 2018.12.18
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	@RequestMapping(value="/prtnumCheck", method=RequestMethod.GET)
	public @ResponseBody int prtnumCheck(@RequestParam("prtnum") String prtnum) throws Exception {
		logger.debug("prtnum" + prtnum);
		logger.debug("duplication Check : " + rgstService.checkId(prtnum));
		
		return rgstService.checkId(prtnum);
		
	}
	

}


