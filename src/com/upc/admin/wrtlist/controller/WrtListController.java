package com.upc.admin.wrtlist.controller;

import java.security.Principal;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.upc.admin.wrtlist.service.WrtListService;
import com.upc.admin.wrtlist.vo.SearchVO;
import com.upc.admin.wrtlist.vo.WrtListVO;

/**
 * 발급지원작성 화면 컨트롤러
 * 
 * @author 신혜영
 * @since 2018. 12. 13.
 * @version 1.2
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0	2018.12.13		신혜영	최초작성
 * 1.1	2018.12.17		신혜영	조건 검색 VO의 변수들 초기값 설정 추가
 * 1.2	2018.12.18		신혜영	상태변경(입금확인완료) 기능 추가
 */
@Controller
@RequestMapping("/admin")
public class WrtListController {
	@Resource(name = "wrtListService")
	private WrtListService wrtListService;

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(WrtListController.class);

	/**
	 * 발급지원 작성 목록을 가져와서 뷰로 전송
	 * 
	 * @param searchVO
	 * @param model
	 * @param principal
	 * @return String
	 * @author 신혜영
	 * @since 2018. 12. 13.
	 * @version 1.1
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1	2019.01.03		신혜영	비작성자 로그인시 조회조건 'all'로 세팅
	 */
	@RequestMapping(value = "/wrtlist.do", method = RequestMethod.GET)
	public String getWrtList(SearchVO searchVO, Model model, Principal principal) {
		
		String loginId = principal.getName();

		// 작성자 목록 가져오기
		List<WrtListVO> writers = wrtListService.selectWriters();
		model.addAttribute("writers", writers);
		
		//로그인한 사람이 작성자가 아닐경우 조회 조건 all로 세팅
		
		if ( searchVO.getSearchWriter() == null ) {
			boolean isWriter = false;
			
			for(WrtListVO item : writers) {
				if(item.getWrtrid().equals(loginId))
					isWriter = true;
			}
			
			if(isWriter == false) {
				searchVO.setSearchWriter("all");
			} else {
				searchVO.setSearchWriter(loginId);
			}
		}
		
		// 발급지원 작성 목록 가져오기
		model.addAttribute("list", wrtListService.selectWrtrList(searchVO, loginId));
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("loginId", loginId);

		logger.info("end wrtier list view controller, searchVO: "+searchVO.toString());

		return "writer/wrtList";
	}

	/**
	 * 입금확인완료로 상태변경
	 * 
	 * @param wrtListVO
	 * @return
	 * @author 신혜영
	 * @since 2018. 12. 18.
	 * @version 1.1
	 * @throws Exception
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 * 1.1	2019.01.04		신혜영	requestMapping url 수정 (updateSts->depositCnfrm)
	 */
	@RequestMapping(value = "/depositCnfrm", method = RequestMethod.PUT)
	public @ResponseBody List<WrtListVO> updateStatus(@RequestBody List<WrtListVO> wrtListVO) throws Exception {

		try {
			wrtListService.depositConfirm(wrtListVO);

		} catch (Exception e) {
			logger.info("error from serviceImpl updateStstus() : " + e.getMessage());
			throw e;
		}
		
		logger.info("end deposit confirm at wrtier list view");

		return wrtListVO;
	}
}