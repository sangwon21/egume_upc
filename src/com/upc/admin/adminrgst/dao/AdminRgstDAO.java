package com.upc.admin.adminrgst.dao;

import com.upc.admin.common.vo.AdminVO;

public interface AdminRgstDAO {
	public void insertAdmin(AdminVO vo) throws Exception;
	public int checkId(String id) throws Exception;
}
