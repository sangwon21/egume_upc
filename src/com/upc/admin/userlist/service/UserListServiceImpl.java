package com.upc.admin.userlist.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.upc.admin.userlist.dao.UserListDAO;
import com.upc.admin.userlist.vo.SearchVO;
import com.upc.admin.userlist.vo.UserVO;

@Service("userListService")
@Transactional
public class UserListServiceImpl implements UserListService {
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(UserListServiceImpl.class);
	
	@Autowired
	private UserListDAO userListDao;

	@Override
	public List<UserVO> userList(SearchVO searchVO) throws Exception {
		List<UserVO> userList = null;

		// 페이지에 처음 접속 시, 접수일자 조회일자를 3개월전~현재 로 세팅해줌
		if (searchVO.getDateFrom() == null && searchVO.getDateTo() == null) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			Date currentTime = new Date();
			String mTime = simpleDateFormat.format(currentTime);
			searchVO.setDateTo(mTime);
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -3);
			searchVO.setDateFrom(simpleDateFormat.format(cal.getTime()));  
		}

		// 전체 접수건
		int boardTotUnit = userListDao.getBoardTotUnit(searchVO);
		// 현재페이지
		int pageIndex = searchVO.getPageIndex();
		// 한페이지당 건 수
		int pageUnit = searchVO.getPageUnit();
		// 보여줄 페이지 크기
		int pageSize = searchVO.getPageSize();
		// 전체페이지
		int totPage = (boardTotUnit % pageUnit == 0) ? (boardTotUnit / pageUnit) : (boardTotUnit / pageUnit + 1);
		// 시작페이지
		int firstIndex = ((pageIndex - 1) / pageSize) * pageSize + 1;
		// 끝페이지
		int lastIndex = firstIndex + pageSize - 1;
		// 끝페이지 처리
		if (lastIndex > totPage) {
			lastIndex = totPage;
		}
		searchVO.setBoardTotUnit(boardTotUnit);
		searchVO.setTotPage(totPage);
		searchVO.setFirstIndex(firstIndex);
		searchVO.setLastIndex(lastIndex);
		logger.info("Processing : Paging Ok");
		try {
			userList = userListDao.userList(searchVO);
		} catch (Exception e) {
			logger.error("Error occurred : database select(userList)");
		}
		return userList;
	}

	@Override
	public int getBoardTotUnit(SearchVO searchVO) {
		return userListDao.getBoardTotUnit(searchVO);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public int delUser(String delUserId) throws Exception {
		return userListDao.delUser(delUserId);
	}
	
	

}
