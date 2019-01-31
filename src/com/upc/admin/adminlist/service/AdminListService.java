package com.upc.admin.adminlist.service;

import java.util.List;
import java.util.Map;

import com.upc.admin.adminlist.vo.SearchVO;
import com.upc.admin.common.vo.AdminVO;

public interface AdminListService {
	public List<AdminVO> adminList(SearchVO vo) throws Exception;
	public int delAdmin(String delAdmId) throws Exception;
	int getBoardTotUnit(SearchVO searchVO);
}
