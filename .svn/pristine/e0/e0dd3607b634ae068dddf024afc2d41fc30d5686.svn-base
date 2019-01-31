package com.upc.admin.wrtlist.vo;

import com.upc.common.search.vo.SearchAbstractModel;

/**
 * 발급작성 목록 조회 조건 VO
 * @author 신혜영
 * @since 2018. 12. 17.
 * @version 1.0
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */

public class SearchVO extends SearchAbstractModel implements Cloneable {
	private String dateCondition = "applrcvdt";
	private String period = "1M";
	private String searchCondition = "prtnum";
	private String conditionValue = "";
	private String searchStatus = "all";
	private String searchWriter;

	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	public String getDateCondition() {
		return dateCondition;
	}

	public void setDateCondition(String dateCondition) {
		this.dateCondition = dateCondition;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getConditionValue() {
		return conditionValue;
	}

	public void setConditionValue(String conditionValue) {
		this.conditionValue = conditionValue;
	}

	public String getSearchStatus() {
		return searchStatus;
	}

	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}

	public String getSearchWriter() {
		return searchWriter;
	}

	public void setSearchWriter(String searchWriter) {
		this.searchWriter = searchWriter;
	}

	@Override
	public String toString() {
		return "SearchVO [dateCondition=" + dateCondition + ", period=" + period + ", searchCondition="
				+ searchCondition + ", conditionValue=" + conditionValue + ", searchStatus=" + searchStatus
				+ ", searchWriter=" + searchWriter + "]";
	}
	
}
