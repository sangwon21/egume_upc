package com.upc.admin.applrcptlist.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.upc.admin.applrcptlist.vo.ApplRcptListVO;
import com.upc.admin.applrcptlist.vo.ApplRcptRstVO;
import com.upc.admin.applrcptlist.vo.SearchVO;

public interface ApplRcptListDAO {
	ApplRcptRstVO getApplRcptCmbRst();
	ArrayList<ApplRcptListVO> getApplList(SearchVO searchVO);
	int getBoardTotUnit(SearchVO searchVO);
	int updateWrtrApptd(ApplRcptListVO applRcptListVO);
}
