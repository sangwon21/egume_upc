package com.upc.admin.userjoinreqlist.dao;

import java.util.List;

import com.upc.admin.userjoinreqlist.vo.SearchVO;
import com.upc.admin.userjoinreqlist.vo.UserJoinReqVO;


public interface UserJoinReqListDAO {
	public List<UserJoinReqVO> getUserJoinReqList(SearchVO vo) throws Exception;
	int getBoardTotUnit(SearchVO searchVO);
	public int delUserJoinReq(String delUserId) throws Exception;
}
