package com.upc.admin.adminmypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.upc.admin.adminmypage.dao.AdminMyPageDAO;
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
@Service("adminMyPageService")
@Transactional
public class AdminMyPageServiceImpl implements AdminMyPageService {

	@Autowired
	private AdminMyPageDAO dao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public AdminVO getAdminInfo(String id) throws Exception {
		return dao.getAdminInfo(id);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public void updateAdminInfo(AdminVO vo) throws Exception {
		String pw = passwordEncoder.encode(vo.getPw());
		vo.setPw(pw);
		dao.updateAdminInfo(vo);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public void updateAdminInfoEcpPw(AdminVO vo) throws Exception {
		dao.updateAdminInfoEcpPw(vo);
		
	}

}
