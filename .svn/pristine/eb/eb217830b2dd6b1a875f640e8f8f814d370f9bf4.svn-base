package com.upc.admin.adminrgst.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.upc.admin.adminrgst.dao.AdminRgstDAO;
import com.upc.admin.common.vo.AdminVO;

/**
 * 
 * @author 김진혁
 * @since 2018. 12. 19.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2018.12.19	김진혁		최초작성
 */
@Service("adminRgstService")
@Transactional
public class AdminRgstServiceImpl implements AdminRgstService {

	@Autowired
	private AdminRgstDAO dao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public void insertAdmin(AdminVO adminVO) throws Exception {
		// TODO Auto-generated method stub
		// 비밀번호 암호화
		String pw = passwordEncoder.encode(adminVO.getPw());
		adminVO.setPw(pw);
		dao.insertAdmin(adminVO);
	}

	@Override
	public int checkId(String id) throws Exception {
		return dao.checkId(id);
	}
	
	

}
