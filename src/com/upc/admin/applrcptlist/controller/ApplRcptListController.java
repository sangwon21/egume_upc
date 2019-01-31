package com.upc.admin.applrcptlist.controller;

import java.security.Principal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.upc.admin.applrcptlist.service.ApplRcptListServiceImpl;
import com.upc.admin.applrcptlist.vo.ApplRcptListVO;
import com.upc.admin.applrcptlist.vo.ApplRcptRstVO;
import com.upc.admin.applrcptlist.vo.SearchVO;
import com.upc.admin.wrtlist.dao.WrtListDAO;
import com.upc.admin.wrtlist.service.WrtListService;
import com.upc.admin.wrtlist.vo.WrtListVO;
import com.upc.common.process.status.StsCode;
import com.upc.user.usrinf.vo.UsrInfVO;

import ch.qos.logback.core.net.SyslogOutputStream;
import egovframework.rte.ptl.mvc.filter.HTMLTagFilter;
import oracle.net.aso.s;

/**
 * 발급신청 목록 관련 컨트롤러
 * @author 강성효
 * @since 2018. 12. 13.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/resources/mapper/*.xml",
"file:src/main/webapp/WEB-INF/spring/*.xml"})
@Controller
@RequestMapping("/admin/applrcpt")
public class ApplRcptListController {
	
	Logger log = LoggerFactory.getLogger(ApplRcptListController.class);
	
	@Autowired
	private ApplRcptListServiceImpl applRcptListServiceImpl;
	
	@Autowired
	private WrtListService wrtListService;
	
	
	/**
	 * 발급지원현황 View 
	 * @return
	 * @author 강성효
	 * @since 2018. 12. 14.
	 * @version 1.0
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1  	2018.12.17	강성효		기본 조회목록  추가
	 * @throws Exception 
	 */
	@GetMapping("/prchCnfrmApplList.do")
	private ModelAndView recpListView(@ModelAttribute SearchVO searchVO) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		log.info("request : 발급신청관리 페이지");
		
		ArrayList<ApplRcptListVO> appList = applRcptListServiceImpl.applList(searchVO);
		List<WrtListVO> wrtListVO = wrtListService.selectWriters();
		ApplRcptRstVO applRst = applRcptListServiceImpl.applRcptCmbRst();
		
		mv.addObject("searchVO",searchVO);  // 검색 + 페이지
		mv.addObject("appList",appList); // 목록
		mv.addObject("applRst",applRst); // 취합결과
		mv.addObject("wrtListVO",wrtListVO);
		// 작성자 리스트
		mv.setViewName("applrcpt/listView");
		
		log.info("response : 발급신청관리 페이지");
		return mv;
	}
	
	/** 
	 * 작성자 리스트 반환
	 * @return 작성자리스트
	 * @author 강성효
	 * @since 2018. 12. 26.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	@GetMapping("/wrtrList")
	@ResponseBody
	private List<WrtListVO> ajaxWrtrList(){
		log.info("request : 담당자 지정을 위한 작성자 리스트 요청");
		List<WrtListVO> wrtListVO = wrtListService.selectWriters();
		log.info("response : 작성자 리스트 ");
		return wrtListVO;
	}
	
	/** 
	 * 작성자 지정
	 * @param applNumList
	 * @param wrtrIdList
	 * @return 1 성공 0 실패
	 * @author 강성효
	 * @since 2018. 12. 26.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	@PostMapping("/wrtrList")
	@ResponseBody
	private int ajaxWrtrApptd(@ModelAttribute ApplRcptListVO applRcptListVO,Principal principal){
		log.info("request : 담당자 지정 요청");
		applRcptListVO.setApplRcvId(principal.getName());
		int rst = applRcptListServiceImpl.wrtrApptd(applRcptListVO);
		log.info("response : SUCCESS 1, FAIL 0 ");
		return rst;
	}
	
}
