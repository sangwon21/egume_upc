/**
 * 회원 관련 파일 Service
 * (사업자등록증사본, 가입신청서 양식, 가입신청서)
 * @author 이 수빈
 * @Date 2018.12.17
 * @version 1.0
 * @see
 * 버전	수정일		수정자		내용
 * 1.1	2018.12.31	이수빈		insertMember input Parameter 변경 (fileVO로 변경)
 */
package com.upc.common.file.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.upc.common.file.vo.FileVO;

@Transactional
public interface MemberFileService {

	@Transactional
	public String insertFile(FileVO fileVO, MultipartFile file) throws Exception;
	
	public Map<String, String> selectFileInfo(String fileseq) throws Exception;

	public void filedownload(HttpServletResponse response, String fileseq) throws Exception;

	public void fileViewer(HttpServletResponse response,FileVO fileVO) throws Exception;
	
	public void modifyFile(FileVO fileVO, MultipartFile file) throws Exception;
}
