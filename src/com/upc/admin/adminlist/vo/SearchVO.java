package com.upc.admin.adminlist.vo;

import com.upc.common.search.vo.SearchAbstractModel;



public class SearchVO extends SearchAbstractModel {
	private String searchRole = "ALL";
	private String searchPeriod = "3M";
	public SearchVO() {
		setSearchCondi("ALL");
	}
	public String getSearchRole() {
		return searchRole;
	}
	public void setSearchRole(String searchRole) {
		this.searchRole = searchRole;
	}
	public String getSearchPeriod() {
		return searchPeriod;
	}
	public void setSearchPeriod(String searchPeriod) {
		this.searchPeriod = searchPeriod;
	}
	@Override
	public String toString() {
		return "SearchVO [searchRole=" + searchRole + ", searchPeriod=" + searchPeriod + "]";
	}
	
}
