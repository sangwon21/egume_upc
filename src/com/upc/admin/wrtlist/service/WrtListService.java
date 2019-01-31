package com.upc.admin.wrtlist.service;

import java.util.List;

import com.upc.admin.wrtlist.vo.SearchVO;
import com.upc.admin.wrtlist.vo.WrtListVO;

public interface WrtListService {
	List<WrtListVO> selectWrtrList(SearchVO searchVO, String loginId);
	List<WrtListVO> selectWriters();
	void depositConfirm(List<WrtListVO> wrtListVO) throws Exception;
}
