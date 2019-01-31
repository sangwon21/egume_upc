package com.upc.admin.applrcptlist.service;


import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.upc.admin.applrcptlist.vo.ApplRcptListVO;
import com.upc.admin.applrcptlist.vo.ApplRcptRstVO;
import com.upc.admin.applrcptlist.vo.SearchVO;

/**
 * 발급신청 관련 인터페이스
 * @author 강성효
 * @since 2018. 12. 20.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */
@Service
public interface ApplRcptListService {
	/** 
	 * 발급건수 취합
	 * @return 금일 신청,발급 건수, 지난달 발급건수
	 * @throws SQLException
	 * @author 강성효
	 * @since 2018. 12. 20.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	ApplRcptRstVO applRcptCmbRst() throws SQLException;
	
	/** 
	 * 신청목록 조회
	 * @param searchVO
	 * @return 신청정보 리스트
	 * @author 강성효
	 * @since 2018. 12. 20.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	ArrayList<ApplRcptListVO> applList(SearchVO searchVO);
	
	
	/** 
	 * 담당자 지정 
	 * @param applRcptListVO
	 * @return SUCCESS, FAIL
	 * @author 강성효
	 * @since 2018. 12. 26.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	int wrtrApptd(ApplRcptListVO applRcptListVO);
	
}
