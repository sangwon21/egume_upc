package com.upc.admin.usermdf.service;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.upc.admin.usermdf.controller.UserMdfController;
import com.upc.admin.usermdf.dao.UserMdfDAO;
import com.upc.admin.usermdf.vo.UserMdfVO;
import com.upc.common.file.service.MemberFileService;
import com.upc.common.file.vo.FileVO;

@Service("userMdfService")
@Transactional
public class UserMdfServiceImpl implements UserMdfService {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(UserMdfServiceImpl.class);
	
	@Autowired
	private UserMdfDAO userMdfDAO;
	
	@Autowired
	private MemberFileService fileService;
	
	@Override
	public UserMdfVO getUserInfo(String prtnum) throws Exception {
		return userMdfDAO.getUserInfo(prtnum);
	}

	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public void mdfUserInfo(UserMdfVO userMdfVO, MultipartFile bsnsFile, String checkFileChange) throws Exception {
		
		logger.info("UserMdfVO={}",userMdfVO);
		logger.info("bsnsFile={}",bsnsFile);
		logger.info("checkFileChange={}",checkFileChange);
		
		// 파일 변경 시
		if(checkFileChange.equals("Y")) {
			FileVO fileVO = new FileVO();
			fileVO.setPrtnum(userMdfVO.getPrtnum());
			fileVO.setRgstid(userMdfVO.getMdfid());
			fileVO.setFormtype("사업자등록증");
			String fileseq=fileService.insertFile(fileVO, bsnsFile);
			userMdfVO.setBsnsfileid(fileseq);
			logger.info("fileseq={}",fileseq);
			userMdfDAO.mdfUserInfo(userMdfVO);
		}
		// 파일 변경하지 않았을 때,
		else if(checkFileChange.equals("N")) {
			userMdfVO.setBsnsfileid("");
			userMdfDAO.mdfUserInfo(userMdfVO);
		}
	}
		
}
