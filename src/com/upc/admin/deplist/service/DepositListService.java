package com.upc.admin.deplist.service;

import java.util.List;

import com.upc.admin.deplist.vo.DepositCnfrmVO;
import com.upc.admin.deplist.vo.RmnCntCheckVO;
import com.upc.admin.deplist.vo.SearchVO;
import com.upc.user.usrinf.vo.UsrInfVO;

public interface DepositListService {
	public List<DepositCnfrmVO> depList(SearchVO vo) throws Exception;
	public int delDep(String delDepSeq) throws Exception;
	public UsrInfVO searchCmpnCeoNm(String prtnum) throws Exception;
	public void insertDepositHsty(DepositCnfrmVO depCnfrmVO) throws Exception;
	int updateUsrRmncnt(DepositCnfrmVO depCnfrmVO) throws Exception;
	public DepositCnfrmVO selectDepositHsty(String depseq) throws Exception;
	int getBoardTotUnit(SearchVO searchVO);
	boolean canDelete(String [] delDepSeq) throws Exception;
}
