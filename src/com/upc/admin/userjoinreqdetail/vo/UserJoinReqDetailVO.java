package com.upc.admin.userjoinreqdetail.vo;

public class UserJoinReqDetailVO {
	private String prtnum;
	private String pw;
	private String cmpnnm;
	private String ceonm;
	private String addr1;
	private String addr2;
	private String mgrname;
	private String mgrtel;
	private String mgrphone;
	private String mgremail;
	private String mgrpstn;
	private String mgrfax;
	private int rmncnt;
	private String prepayyn="N";
	private String emailyn="N";
	private String emaildt;
	private String smsyn="N";
	private String smsdt;
	private String sts;
	private String rgsttm;
	private String rgstid;
	private String mdftm;
	private String mdfid;
	private String bsnsfileid;
	private String bsnsfilenm;	//파일명
	private String bsnstype;	//확장자
	private String applfileid;
	private String applfilenm;	//파일명
	private String appltype;	//확장자
	public String getPrtnum() {
		return prtnum;
	}
	public void setPrtnum(String prtnum) {
		this.prtnum = prtnum;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
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
	public String getMgrname() {
		return mgrname;
	}
	public void setMgrname(String mgrname) {
		this.mgrname = mgrname;
	}
	public String getMgrtel() {
		return mgrtel;
	}
	public void setMgrtel(String mgrtel) {
		this.mgrtel = mgrtel;
	}
	public String getMgrphone() {
		return mgrphone;
	}
	public void setMgrphone(String mgrphone) {
		this.mgrphone = mgrphone;
	}
	public String getMgremail() {
		return mgremail;
	}
	public void setMgremail(String mgremail) {
		this.mgremail = mgremail;
	}
	public String getMgrpstn() {
		return mgrpstn;
	}
	public void setMgrpstn(String mgrpstn) {
		this.mgrpstn = mgrpstn;
	}
	public String getMgrfax() {
		return mgrfax;
	}
	public void setMgrfax(String mgrfax) {
		this.mgrfax = mgrfax;
	}
	public int getRmncnt() {
		return rmncnt;
	}
	public void setRmncnt(int rmncnt) {
		this.rmncnt = rmncnt;
	}
	public String getPrepayyn() {
		return prepayyn;
	}
	public void setPrepayyn(String prepayyn) {
		this.prepayyn = prepayyn;
	}
	public String getEmailyn() {
		return emailyn;
	}
	public void setEmailyn(String emailyn) {
		this.emailyn = emailyn;
	}
	public String getEmaildt() {
		return emaildt;
	}
	public void setEmaildt(String emaildt) {
		this.emaildt = emaildt;
	}
	public String getSmsyn() {
		return smsyn;
	}
	public void setSmsyn(String smsyn) {
		this.smsyn = smsyn;
	}
	public String getSmsdt() {
		return smsdt;
	}
	public void setSmsdt(String smsdt) {
		this.smsdt = smsdt;
	}
	public String getSts() {
		return sts;
	}
	public void setSts(String sts) {
		this.sts = sts;
	}
	public String getRgsttm() {
		return rgsttm;
	}
	public void setRgsttm(String rgsttm) {
		this.rgsttm = rgsttm;
	}
	public String getRgstid() {
		return rgstid;
	}
	public void setRgstid(String rgstid) {
		this.rgstid = rgstid;
	}
	public String getMdftm() {
		return mdftm;
	}
	public void setMdftm(String mdftm) {
		this.mdftm = mdftm;
	}
	public String getMdfid() {
		return mdfid;
	}
	public void setMdfid(String mdfid) {
		this.mdfid = mdfid;
	}
	public String getBsnsfileid() {
		return bsnsfileid;
	}
	public void setBsnsfileid(String bsnsfileid) {
		this.bsnsfileid = bsnsfileid;
	}
	public String getBsnsfilenm() {
		return bsnsfilenm;
	}
	public void setBsnsfilenm(String bsnsfilenm) {
		this.bsnsfilenm = bsnsfilenm;
	}
	public String getBsnstype() {
		return bsnstype;
	}
	public void setBsnstype(String bsnstype) {
		this.bsnstype = bsnstype;
	}
	public String getApplfileid() {
		return applfileid;
	}
	public void setApplfileid(String applfileid) {
		this.applfileid = applfileid;
	}
	public String getApplfilenm() {
		return applfilenm;
	}
	public void setApplfilenm(String applfilenm) {
		this.applfilenm = applfilenm;
	}
	public String getAppltype() {
		return appltype;
	}
	public void setAppltype(String appltype) {
		this.appltype = appltype;
	}
	@Override
	public String toString() {
		return "UserJoinReqDetailVO [prtnum=" + prtnum + ", pw=" + pw + ", cmpnnm=" + cmpnnm + ", ceonm=" + ceonm
				+ ", addr1=" + addr1 + ", addr2=" + addr2 + ", mgrname=" + mgrname + ", mgrtel=" + mgrtel
				+ ", mgrphone=" + mgrphone + ", mgremail=" + mgremail + ", mgrpstn=" + mgrpstn + ", mgrfax=" + mgrfax
				+ ", rmncnt=" + rmncnt + ", prepayyn=" + prepayyn + ", emailyn=" + emailyn + ", emaildt=" + emaildt
				+ ", smsyn=" + smsyn + ", smsdt=" + smsdt + ", sts=" + sts + ", rgsttm=" + rgsttm + ", rgstid=" + rgstid
				+ ", mdftm=" + mdftm + ", mdfid=" + mdfid + ", bsnsfileid=" + bsnsfileid + ", bsnsfilenm=" + bsnsfilenm
				+ ", bsnstype=" + bsnstype + ", applfileid=" + applfileid + ", applfilenm=" + applfilenm + ", appltype="
				+ appltype + "]";
	}
	
}
