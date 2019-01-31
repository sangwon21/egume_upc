package com.upc.admin.wrtinfodetail.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.upc.admin.wrtinfodetail.vo.CnfrmPrchIsueVO;
import com.upc.admin.wrtinfodetail.vo.CnfrmPrchReqVO;
import com.upc.common.file.vo.FileVO;

public interface WrtInfoDetailService {
	CnfrmPrchReqVO selectCnfrmPrchReq(String applnum);
	List<CnfrmPrchIsueVO> selectCnfrmPrchIsue(CnfrmPrchReqVO cnfrmPrchReqVO);
	void updateCnfrmPrchReqInfo(CnfrmPrchReqVO cnfrmPrchReqVO, FileVO fileVO, MultipartFile tax[], MultipartFile sup[], String modTax[], String modSup[]) throws Exception;
	void insertSmpFile(MultipartHttpServletRequest smpFileForm, String loginId) throws Exception;
	void insertSmpCnfrmFile(CnfrmPrchReqVO cnfrmPrchReqVO, MultipartFile file, String loginId) throws Exception;
	void insertIssueFile(CnfrmPrchIsueVO cnfrmPrchIsueVO, MultipartFile file, String loginId) throws Exception;
	int updateMdfReq(Map<String, Object> mdfReqMap);
}
