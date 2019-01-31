package com.upc.admin.applrcptlist.vo;
import com.upc.common.search.vo.SearchAbstractModel;

/**
 * 검색 VO 클래스
 * @author 강성효
 * @since 2018. 12. 18.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */

public class SearchVO extends SearchAbstractModel{
	
	/**조회기간 조건*/
	public String dtCondi = "신청일자";
	/**진행상태 조건*/
	private String stsCondi = "전체";
	/**작성자 조건*/
	private String wrtrCondi = "전체";
	/**작성자 이름*/
	private String wrtrNm;
	/**상태*/
	private String sts;
	/**신청방법*/
	private String appMthd = "전체";
	
	public String getAppMthd() {
		return appMthd;
	}
	public void setAppMthd(String appMthd) {
		this.appMthd = appMthd;
	}
	public String getDtCondi() {
		return dtCondi;
	}
	public void setDtCondi(String dtCondi) {
		this.dtCondi = dtCondi;
	}
	public String getStsCondi() {
		return stsCondi;
	}
	public void setStsCondi(String stsCondi) {
		this.stsCondi = stsCondi;
	}
	public String getWrtrCondi() {
		return wrtrCondi;
	}
	public void setWrtrCondi(String wrtrCondi) {
		this.wrtrCondi = wrtrCondi;
	}
	public String getWrtrNm() {
		return wrtrNm;
	}
	public void setWrtrNm(String wrtrNm) {
		this.wrtrNm = wrtrNm;
	}
	public String getSts() {
		return sts;
	}
	public void setSts(String sts) {
		this.sts = sts;
	}
	
	
}
