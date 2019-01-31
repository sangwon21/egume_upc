package com.upc.admin.applrcptlist.vo;


/**
 * 발급지원 취합 기능 VO 클래스
 * @author 강성효
 * @since 2018. 12. 20.
 * @version
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */

public class ApplRcptRstVO {
	private int applReqTdy;
	private int applTdy;
	private int applPrvMth;
	private String reqTime;
	
	public int getApplReqTdy() {
		return applReqTdy;
	}
	public void setApplReqTdy(int applReqTdy) {
		this.applReqTdy = applReqTdy;
	}
	public int getApplTdy() {
		return applTdy;
	}
	public void setApplTdy(int applTdy) {
		this.applTdy = applTdy;
	}
	public int getApplPrvMth() {
		return applPrvMth;
	}
	public void setApplPrvMth(int applPrvMth) {
		this.applPrvMth = applPrvMth;
	}
	public String getReqTime() {
		return reqTime;
	}
	public void setReqTime(String reqTime) {
		this.reqTime = reqTime;
	}
	
	
}
