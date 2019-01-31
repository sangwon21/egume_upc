package com.upc.admin.userlist.dao;

import java.util.List;

import com.upc.admin.userlist.vo.SearchVO;
import com.upc.admin.userlist.vo.UserVO;

public interface UserListDAO {
	public List<UserVO> userList(SearchVO searchVO) throws Exception;
	int getBoardTotUnit(SearchVO searchVO);
	public int delUser(String delUserId) throws Exception;
}
