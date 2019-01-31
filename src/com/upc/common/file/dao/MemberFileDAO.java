/**
 * 회원 관련 파일 DAO
 * (사업자등록증사본, 가입신청서 양식, 가입신청서)
 * @author 이 수빈
 * @Date 2018.12.17
 * @version 1.0
 * @see
 *
 */
package com.upc.common.file.dao;

import java.util.Map;

import com.upc.common.file.vo.FileVO;

public interface MemberFileDAO {

	// 사업자등록증사본 등록
	public void insertFile(FileVO fileVO) throws Exception;

	// 파일 다운로드를 위한 파일 저장 정보 검색
	public Map<String, String> selectFileInfo(String fileseq) throws Exception;

	// 파일 업로드 채번을 위한 seq의 max값 검색
	public int selectMaxseq() throws Exception;
	
	//파일 변경
	public int updateFile(FileVO fileVO) throws Exception;
}
