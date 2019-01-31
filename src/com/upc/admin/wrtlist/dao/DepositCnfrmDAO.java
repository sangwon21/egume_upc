package com.upc.admin.wrtlist.dao;

import com.upc.admin.wrtlist.vo.DepositCnfrmVO;
import com.upc.admin.wrtlist.vo.WrtListVO;

public interface DepositCnfrmDAO {
	int insertDepositHsty(DepositCnfrmVO depositCnfrmVo);
	int updateUsrRmncnt(WrtListVO wrtListVo);
}
