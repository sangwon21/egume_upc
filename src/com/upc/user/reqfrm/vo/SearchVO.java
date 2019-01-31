package com.upc.user.reqfrm.vo;

import com.upc.common.search.vo.SearchAbstractModel;


public class SearchVO extends SearchAbstractModel implements Cloneable {
	private String dateCondition = "";
	private String searchCondition = "";
	private String conditionValue = "";
	private String searchStatus = "";
	private String prtnum = "";
	private String period = "";
	
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

	public String getPrtnum() {
		return prtnum;
	}

	public void setPrtnum(String prtnum) {
		this.prtnum = prtnum;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}
	
	
}
