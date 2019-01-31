package com.upc.admin.wrtlist.vo;

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
	private String depnm;
	private int depcnt = 1;
	private String rgstid;
	private String rgsttm;
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
	public String getDepnm() {
		return depnm;
	}
	public void setDepnm(String depnm) {
		this.depnm = depnm;
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
	
	

}
