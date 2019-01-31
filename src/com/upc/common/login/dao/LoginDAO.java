package com.upc.common.login.dao;

import java.util.Map;
/**
 * 로그인 정보 DAO
 * (username, password, authority, enabled, name(cmpnnm/admname))
 * @author 이 수빈
 * @Date 2018.12.24
 * @version 1.0
 * @see
 *
 */
public interface LoginDAO {
	public Map<String, Object> selectLoginInfo(String usrname); 
}
