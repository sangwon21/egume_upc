package com.upc.common.util;

import java.util.Locale;

import org.springframework.context.support.MessageSourceAccessor;

/**
 * 공통 메시지 처리 클래스
 * @author 신혜영
 * @since 2019. 1. 7.
 * @version 1.0
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */
public class MessageUtils {
	private static MessageSourceAccessor msAcc = null;

	public void setMessageSourceAccessor(MessageSourceAccessor msAcc) {
		MessageUtils.msAcc = msAcc;
	}

	public static String getMessage(String code) {
		return msAcc.getMessage(code, Locale.getDefault());
	}

	public static String getMessage(String code, Object[] objs) {
		return msAcc.getMessage(code, objs, Locale.getDefault());
	}

}
