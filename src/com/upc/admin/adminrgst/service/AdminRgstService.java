package com.upc.admin.adminrgst.service;

import com.upc.admin.common.vo.AdminVO;

public interface AdminRgstService {
	public void insertAdmin(AdminVO vo) throws Exception;
	public int checkId(String id) throws Exception;
}
