package com.upc.admin.adminrgst.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.upc.admin.adminrgst.service.AdminRgstService;
import com.upc.admin.common.vo.AdminVO;


/**
 * 어드민 등록을 담당하는 컨트롤러
 * @author 김진혁
 * @since 2018. 12. 18.
 * @version 1.1
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2018.12.18	김진혁		최초작성
 * 1.1		2018.12.19	김진혁		등록요청과 아이디체크요청 추가
 */
@Controller
@RequestMapping("/admin")
public class AdminRgstController {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AdminRgstController.class);
	
	@Autowired
	private AdminRgstService adminRgstService;
	
	
	/**
	 * 어드민 등록 뷰를 제공하는 메소드
	 * @param model
	 * @return
	 * @author 김진혁
	 * @since 2018. 12. 18.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.18	김진혁		최초작성
	 */
	@RequestMapping(value = "/adminRgst.do", method = RequestMethod.GET)
	public String getAdminRgstView(Model model) {
		return "admin/adminRgst";
	}  
	
	
	/**
	 * 어드민 등록 처리하는 메소드
	 * @param adminVO
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
	@RequestMapping(value = "/adminRgst", method = RequestMethod.POST)
	public String AdminRgst(@ModelAttribute AdminVO adminVO, Principal principal) throws Exception {
		logger.info("AdminVO={}", adminVO );
		
		// 등록자ID와 수정자ID 값을 지정하기 위해 로그인 정보를 얻어옴
		String id=principal.getName();
		adminVO.setRgstid(id);
		adminVO.setMdfid(id);
		adminRgstService.insertAdmin(adminVO);
		return "redirect:adminList.do";
	}  
	
	
	/**
	 * 어드민 id 중복체크를 제공하는 메소드
	 * @param id
	 * @return
	 * @throws Exception
	 * @author 김진혁
	 * @since 2018. 12. 19.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.0		2018.12.19	김진혁		최초작성
	 */
	@RequestMapping(value="/checkIdAjax", method=RequestMethod.POST)
	public @ResponseBody Map<Object, Object> CheckId(@RequestBody String id) throws Exception {
		logger.info("checkid={}",id);
		int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
        count=adminRgstService.checkId(id);
        map.put("cnt", count);
        return map;
	}
	
	
}
