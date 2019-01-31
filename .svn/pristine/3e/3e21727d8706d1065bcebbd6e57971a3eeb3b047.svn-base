package com.upc.user.reqfrm.dao;

import java.util.HashMap;
import java.util.List;

import com.upc.user.reqfrm.vo.ReqFrmListVO;
import com.upc.user.reqfrm.vo.ReqFrmVO;
import com.upc.user.reqfrm.vo.SearchVO;
import com.upc.user.reqfrm.vo.UsrInfVO;

public interface ReqFrmDAO {
	int insertCnfrmPrchReq(ReqFrmVO vo);
	UsrInfVO selectUser(String prtnum);
	int selectMaxSeq();
	ReqFrmVO selectReqFrm(HashMap<String, Object> map);
	List<ReqFrmVO> selectListsOfReqFrm(HashMap<String, Object> map);
	List<ReqFrmListVO> selectReqFrmList(SearchVO searchVO);
	List<ReqFrmListVO> selectReqFrms();
	int selectBoardTotUnit(SearchVO searchVO);
	int updateSts(ReqFrmListVO reqFrmListVO);
}
