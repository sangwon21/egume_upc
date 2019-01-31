package com.upc.user.reqfrm.vo;

/**
 * 구매확인서 발급 신청
 * @author 이상원
 * @since 2018. 12. 18.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */


public class UsrInfVO {
	private String prtnum;
	private String cmpnnm;
	private String ceonm;
	private String addr1;
	private String addr2;
	public String getPrtnum() {
		return prtnum;
	}
	public void setPrtnum(String prtnum) {
		this.prtnum = prtnum;
	}
	public String getCmpnnm() {
		return cmpnnm;
	}
	public void setCmpnnm(String cmpnnm) {
		this.cmpnnm = cmpnnm;
	}
	public String getCeonm() {
		return ceonm;
	}
	public void setCeonm(String ceonm) {
		this.ceonm = ceonm;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	
	
}
