package com.upc.admin.deplist.vo;

/**
 * 입금정보 등록 VO
 * @author 신혜영
 * @since 2018. 12. 18.
 * @version 1.0
 * @see 
 * 수정이력
 * 버전		수정일		수정자		수정내용
 */

public class DepositCnfrmVO {
	private String prtnum;
	private String depseq;
	private String depdt;
	private int depamt = 11000;
	private String deprnm;
	private int depcnt = 1;
	private String rgstid;
	private String rgsttm;
	private String cmpnnm;
	private String ceonm;
	private String addr1;
	private String addr2;
	private String mgrtel;
	
	public String getPrtnum() {
		return prtnum;
	}
	public void setPrtnum(String prtnum) {
		this.prtnum = prtnum;
	}
	public String getDepseq() {
		return depseq;
	}
	public void setDepseq(String depseq) {
		this.depseq = depseq;
	}
	public String getDepdt() {
		return depdt;
	}
	public void setDepdt(String depdt) {
		this.depdt = depdt;
	}
	public int getDepamt() {
		return depamt;
	}
	public void setDepamt(int depamt) {
		this.depamt = depamt;
	}
	public String getDeprnm() {
		return deprnm;
	}
	public void setDeprnm(String deprnm) {
		this.deprnm = deprnm;
	}
	public int getDepcnt() {
		return depcnt;
	}
	public void setDepcnt(int depcnt) {
		this.depcnt = depcnt;
	}
	public String getRgstid() {
		return rgstid;
	}
	public void setRgstid(String rgstid) {
		this.rgstid = rgstid;
	}
	public String getRgsttm() {
		return rgsttm;
	}
	public void setRgsttm(String rgsttm) {
		this.rgsttm = rgsttm;
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
	public String getMgrtel() {
		return mgrtel;
	}
	public void setMgrtel(String mgrtel) {
		this.mgrtel = mgrtel;
	}
	@Override
	public String toString() {
		return "DepositCnfrmVO [prtnum=" + prtnum + ", depseq=" + depseq + ", depdt=" + depdt + ", depamt=" + depamt
				+ ", deprnm=" + deprnm + ", depcnt=" + depcnt + ", rgstid=" + rgstid + ", rgsttm=" + rgsttm
				+ ", cmpnnm=" + cmpnnm + ", ceonm=" + ceonm + ", addr1=" + addr1 + ", addr2=" + addr2 + ", mgrtel="
				+ mgrtel + "]";
	}
	
	

}
