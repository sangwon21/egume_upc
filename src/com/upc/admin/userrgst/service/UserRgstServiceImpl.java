package com.upc.admin.userrgst.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.upc.admin.userrgst.dao.UserRgstDAO;
import com.upc.admin.userrgst.vo.UsrInfVO;
import com.upc.common.file.service.MemberFileService;
import com.upc.common.file.vo.FileVO;

@Service("userRgstService")
@Transactional
public class UserRgstServiceImpl implements UserRgstService {

	@Autowired
	private UserRgstDAO dao;
	
	@Autowired
	private MemberFileService fileService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public void insertMemberByAdm(UsrInfVO usrInfVO, MultipartFile bsnsFile) throws Exception {
		// TODO Auto-generated method stub
		String pw = passwordEncoder.encode(usrInfVO.getPw());
		usrInfVO.setPw(pw);
		
		if(usrInfVO.getEmailyn() == null) {
			usrInfVO.setEmailyn("N");
		}
		else if(usrInfVO.getEmailyn() != null) {
			usrInfVO.setEmailyn("Y");
		}
		
		if(usrInfVO.getSmsyn() == null) {
			usrInfVO.setSmsyn("N");
		}
		else if(usrInfVO.getSmsyn() != null) {
			usrInfVO.setSmsyn("Y");;
		}
		
		if(usrInfVO.getPrepayyn() == null) {
			usrInfVO.setPrepayyn("N");
		}
		else if(usrInfVO.getPrepayyn() != null) {
			usrInfVO.setPrepayyn("Y");
		}
		
		
		FileVO fileVO = new FileVO();
		fileVO.setPrtnum(usrInfVO.getPrtnum());
		fileVO.setFormtype("사업자등록증");
		String fileseq=fileService.insertFile(fileVO, bsnsFile);
		usrInfVO.setBsnsfileid(fileseq);
		dao.insertMemberByAdm(usrInfVO);
	}

}
