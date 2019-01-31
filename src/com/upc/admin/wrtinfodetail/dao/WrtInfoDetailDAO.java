package com.upc.admin.wrtinfodetail.dao;

import java.util.List;
import java.util.Map;

import com.upc.admin.wrtinfodetail.vo.ChrgHstyVO;
import com.upc.admin.wrtinfodetail.vo.CnfrmPrchIsueVO;
import com.upc.admin.wrtinfodetail.vo.CnfrmPrchReqVO;

public interface WrtInfoDetailDAO {
	CnfrmPrchReqVO selectCnfrmPrchReq(String applnum);

	List<CnfrmPrchIsueVO> selectCnfrmPrchIsue(CnfrmPrchReqVO cnfrmPrchReqVO);
	
	int updateCnfrmPrchReq(CnfrmPrchReqVO cnfrmPrchReqVO);

	int selectChrg(String applnum);

	int insertChrg(ChrgHstyVO chrgHstyVO);

	int updateSmpInfo(CnfrmPrchReqVO cnfrmPrchReqVO);

	int updateUsrRmncnt(String prtnum);

	int updateSmpCnfrmInfo(CnfrmPrchReqVO cnfrmPrchReqVO);

	int insertIssue(CnfrmPrchIsueVO cnfrmPrchIsueVO);

	int updateIssueInfo(CnfrmPrchIsueVO cnfrmPrchIsueVO);
	
	int updateMdfReq(Map<String, Object> mdfReqMap);
}
