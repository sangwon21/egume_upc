package com.upc.user.usrinf.service;

import org.springframework.transaction.annotation.Transactional;

import com.upc.user.usrinf.vo.UsrInfVO;

@Transactional
public interface MemberInfoService {

	public UsrInfVO selectUsrInf(String prtnum) throws Exception;

	@Transactional
	public void updateUsrInf(UsrInfVO usrInfVO) throws Exception;

	public boolean checkPw(String prtnum, String pw) throws Exception;

	@Transactional
	public void deleteUsrInf(String prtnum) throws Exception;
}
