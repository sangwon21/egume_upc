package com.upc.admin.wrtlist.dao;

import java.util.List;

import com.upc.admin.wrtlist.vo.SearchVO;
import com.upc.admin.wrtlist.vo.WrtListVO;

public interface WrtListDAO {
	List<WrtListVO> selectWrtrList(SearchVO searchVO);
	List<WrtListVO> selectWriters();
	int updateSts(WrtListVO wrtListVO);
	int selectBoardTotUnit(SearchVO searchVO);
}
