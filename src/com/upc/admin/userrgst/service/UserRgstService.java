package com.upc.admin.userrgst.service;

import org.springframework.web.multipart.MultipartFile;

import com.upc.admin.userrgst.vo.UsrInfVO;

public interface UserRgstService {

	public void insertMemberByAdm(UsrInfVO vo, MultipartFile bsnsFile) throws Exception;
}
