package com.upc.admin.usermdf.dao;

import com.upc.admin.usermdf.vo.UserMdfVO;


public interface UserMdfDAO {
	public UserMdfVO getUserInfo(String prtnum) throws Exception;
	public void mdfUserInfo(UserMdfVO userMdfVO) throws Exception;
}
