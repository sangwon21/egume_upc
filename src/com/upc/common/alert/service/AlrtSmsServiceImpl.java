package com.upc.common.alert.service;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.upc.common.alert.dao.AlrtSmsDAO;
import com.upc.common.alert.vo.AlrtSmsVO;
import com.upc.common.util.MessageUtils;

/**
 * 구매확인서 진행 sms 알림 로직
 * @author 신혜영
 * @since 2019. 1. 7.
 * @version 1.0
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */
@Service("alrtSmsService")
public class AlrtSmsServiceImpl implements AlrtSmsService {
	@Autowired
	private AlrtSmsDAO alrtSmsDAO;
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AlrtSmsServiceImpl.class);
	
	/**
	* db에 sms 정보 저장
	* @param alrtSmsVO
	* @return int
	* @author 신혜영
	* @since 2019. 1. 7.
	* @version 1.0
	*/
	@Override
	@Transactional
	public int insertSms(AlrtSmsVO alrtSmsVO) {

		//sms 정보 세팅
		alrtSmsVO.setSm_SdMbNo(MessageUtils.getMessage("alrt.sms.sendtel"));
		alrtSmsVO.setSm_FirstCk(new Double(MessageUtils.getMessage("alrt.sms.firstck")));
		alrtSmsVO.setSm_code1(MessageUtils.getMessage("alrt.sms.code1"));
		alrtSmsVO.setSm_code2(MessageUtils.getMessage("alrt.sms.code2"));

		int result = 0;
		try {
			result = alrtSmsDAO.insertSms(alrtSmsVO);
			if( result != 1) {
				logger.info("SMS 등록 실패: inserting sms result is "+result);
				return result;
			}
		} catch(Exception e) {
			logger.error("SMS 등록 실패: "+e.getMessage());
		}
		return result;
	}

}
