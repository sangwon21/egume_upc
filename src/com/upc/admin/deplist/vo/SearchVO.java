package com.upc.admin.deplist.vo;

import com.upc.common.search.vo.SearchAbstractModel;

public class SearchVO extends SearchAbstractModel {
	private String searchPeriod = "1M";
	public SearchVO() {
		setSearchCondi("ALL");
	}
	public String getSearchPeriod() {
		return searchPeriod;
	}
	public void setSearchPeriod(String searchPeriod) {
		this.searchPeriod = searchPeriod;
	}
	@Override
	public String toString() {
		return "SearchVO [searchPeriod=" + searchPeriod + ", dateTo=" + dateTo + ", dateFrom=" + dateFrom
				+ ", searchCondi=" + searchCondi + ", searchVal=" + searchVal + ", boardTotUnit=" + boardTotUnit
				+ ", totPage=" + totPage + ", pageIndex=" + pageIndex + ", pageUnit=" + pageUnit + ", pageSize="
				+ pageSize + ", firstIndex=" + firstIndex + ", lastIndex=" + lastIndex + "]";
	}
}
