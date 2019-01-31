package com.upc.admin.userjoinreqlist.vo;

import com.upc.common.search.vo.SearchAbstractModel;

public class SearchVO extends SearchAbstractModel {
	private String searchReqType = "ALL";
	private String searchPeriod = "3M";
	public SearchVO() {
		setSearchCondi("ALL");
	}
	public String getSearchReqType() {
		return searchReqType;
	}
	public void setSearchReqType(String searchReqType) {
		this.searchReqType = searchReqType;
	}
	public String getSearchPeriod() {
		return searchPeriod;
	}
	public void setSearchPeriod(String searchPeriod) {
		this.searchPeriod = searchPeriod;
	}
	
}
