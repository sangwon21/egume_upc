package com.upc.admin.applrcptrgst.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.upc.admin.applrcptlist.vo.ApplRcptListVO;
import com.upc.common.file.vo.FileVO;
import com.upc.common.rgstid.vo.UsrInfVO;
import com.upc.user.reqfrm.vo.ReqFrmVO;

/**
 * 발급신청 등록&상세 관련 인터페이스
 * @author 강성효
 * @since 2018. 12. 27.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */
public interface ApplRcptRgstService {
	
	/** 
	 * 발급신청번호에 대한 상세정보 조회
	 * @param applRcptListVO
	 * @return 신청정보
	 * @author 강성효
	 * @since 2018. 12. 27.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	ApplRcptListVO applRcptOne(ApplRcptListVO applRcptListVO);
	
	
	/** 
	 * 첨부서류 조회
	 * @param applRcptListVO
	 * @return 첨부서류 리스트
	 * @author 강성효
	 * @since 2018. 12. 31.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	ArrayList<FileVO> fileInfoList(ApplRcptListVO applRcptListVO);
	
	
	/** 
	 * 구매확인접수 등록 & 수정 
	 * @param applRcptListVO
	 * @param usrInfVO
	 * @param tax
	 * @param sup
	 * @author 강성효
	 * @since 2018. 12. 31.
	 * @version
	 * 수정이력
	 * 버전		수정일		수정자		수정내용
	 */
	void modApplRgst(ReqFrmVO reqFrmVO,FileVO fileVO,MultipartFile tax[],MultipartFile sup[],String modTax[], String modSup[]) throws Exception;
}
