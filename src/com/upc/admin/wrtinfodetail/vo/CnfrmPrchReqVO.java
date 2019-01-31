package com.upc.admin.wrtinfodetail.vo;

/**
 * 발급지원 작성 상세 정보 VO
 * @author 신혜영
 * @since 2018. 12. 26.
 * @version 1.4
 * @see
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.1	2018.12.27		신혜영	견본파일id, 견본확인파일id 추가
 * 1.2	2019.01.02		신혜영	원본수정요청사항 추가
 * 1.3	2019.01.03		신혜영	toString(), 접수자id, 접수자nm, 코드명 추가
 * 1.4	2019.01.07		신혜영	sms/카톡여부 추가
 * 1.5	2019.01.14		신혜영	발급일자 추가
 */
public class CnfrmPrchReqVO {
	//신청 및 신청자 정보
	private String applnum;
	private String applrcvdt;
	private String applrcvid;
	private String applrcvnm;
	private String prchdt;
	private String shipdt;
	private String prtnum;
	private String cmpnnm;
	private String addr1;
	private String addr2;
	private String ceonm;
	private String mgrname;
	private String mgremail;
	private String mgrfax;
	private String mgrtel;
	private String mgrphone;
	private String prepayyn;
	private String smsyn;
	private String applditc;
	private String sts;
	private String codenm;
	private String notes;
	private int rmncnt;
	//공급자 정보
	private String splyprtnum;
	private String splyaddr1;
	private String splyaddr2;
	private String splyceonm;
	private String splyorgnm;
	//견본 , 견본 확인, 원본 정보
	private String wrtrid;
	private String wrtrnm;
	private String smpldt;
	private String smpldocid;
	private String smplfileid;
	private String smplfilenm;
	private String cnfrmdt;
	private String cnfrmid;
	private String smplmdfreq;
	private String cnfrmfileid;
	private String cnfrmfilenm;
	private String issuenum;
	private String rgsttm;
	private String issuemdfreq;
	
	public String getApplnum() {
		return applnum;
	}
	public void setApplnum(String applnum) {
		this.applnum = applnum;
	}
	public String getApplrcvdt() {
		return applrcvdt;
	}
	public void setApplrcvdt(String applrcvdt) {
		this.applrcvdt = applrcvdt;
	}
	public String getApplrcvid() {
		return applrcvid;
	}
	public void setApplrcvid(String applrcvid) {
		this.applrcvid = applrcvid;
	}
	public String getApplrcvnm() {
		return applrcvnm;
	}
	public void setApplrcvnm(String applrcvnm) {
		this.applrcvnm = applrcvnm;
	}
	public String getPrchdt() {
		return prchdt;
	}
	public void setPrchdt(String prchdt) {
		this.prchdt = prchdt;
	}
	public String getShipdt() {
		return shipdt;
	}
	public void setShipdt(String shipdt) {
		this.shipdt = shipdt;
	}
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
	public String getCeonm() {
		return ceonm;
	}
	public void setCeonm(String ceonm) {
		this.ceonm = ceonm;
	}
	public String getMgrname() {
		return mgrname;
	}
	public void setMgrname(String mgrname) {
		this.mgrname = mgrname;
	}
	public String getMgremail() {
		return mgremail;
	}
	public void setMgremail(String mgremail) {
		this.mgremail = mgremail;
	}
	public String getMgrfax() {
		return mgrfax;
	}
	public void setMgrfax(String mgrfax) {
		this.mgrfax = mgrfax;
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
	public String getPrepayyn() {
		return prepayyn;
	}
	public void setPrepayyn(String prepayyn) {
		this.prepayyn = prepayyn;
	}
	public String getSmsyn() {
		return smsyn;
	}
	public void setSmsyn(String smsyn) {
		this.smsyn = smsyn;
	}
	public String getApplditc() {
		return applditc;
	}
	public void setApplditc(String applditc) {
		this.applditc = applditc;
	}
	public String getSts() {
		return sts;
	}
	public void setSts(String sts) {
		this.sts = sts;
	}
	public String getCodenm() {
		return codenm;
	}
	public void setCodenm(String codenm) {
		this.codenm = codenm;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public int getRmncnt() {
		return rmncnt;
	}
	public void setRmncnt(int rmncnt) {
		this.rmncnt = rmncnt;
	}
	public String getSplyprtnum() {
		return splyprtnum;
	}
	public void setSplyprtnum(String splyprtnum) {
		this.splyprtnum = splyprtnum;
	}
	public String getSplyaddr1() {
		return splyaddr1;
	}
	public void setSplyaddr1(String splyaddr1) {
		this.splyaddr1 = splyaddr1;
	}
	public String getSplyaddr2() {
		return splyaddr2;
	}
	public void setSplyaddr2(String splyaddr2) {
		this.splyaddr2 = splyaddr2;
	}
	public String getSplyceonm() {
		return splyceonm;
	}
	public void setSplyceonm(String splyceonm) {
		this.splyceonm = splyceonm;
	}
	public String getSplyorgnm() {
		return splyorgnm;
	}
	public void setSplyorgnm(String splyorgnm) {
		this.splyorgnm = splyorgnm;
	}
	public String getWrtrid() {
		return wrtrid;
	}
	public void setWrtrid(String wrtrid) {
		this.wrtrid = wrtrid;
	}
	public String getWrtrnm() {
		return wrtrnm;
	}
	public void setWrtrnm(String wrtrnm) {
		this.wrtrnm = wrtrnm;
	}
	public String getSmpldt() {
		return smpldt;
	}
	public void setSmpldt(String date) {
		this.smpldt = date;
	}
	public String getSmpldocid() {
		return smpldocid;
	}
	public void setSmpldocid(String smpldocid) {
		this.smpldocid = smpldocid;
	}
	public String getSmplfileid() {
		return smplfileid;
	}
	public void setSmplfileid(String smplfileid) {
		this.smplfileid = smplfileid;
	}
	public String getSmplfilenm() {
		return smplfilenm;
	}
	public void setSmplfilenm(String smplfilenm) {
		this.smplfilenm = smplfilenm;
	}
	public String getCnfrmdt() {
		return cnfrmdt;
	}
	public void setCnfrmdt(String cnfrmdt) {
		this.cnfrmdt = cnfrmdt;
	}
	public String getCnfrmid() {
		return cnfrmid;
	}
	public void setCnfrmid(String cnfrmid) {
		this.cnfrmid = cnfrmid;
	}
	public String getSmplmdfreq() {
		return smplmdfreq;
	}
	public void setSmplmdfreq(String smplmdfreq) {
		this.smplmdfreq = smplmdfreq;
	}
	public String getCnfrmfileid() {
		return cnfrmfileid;
	}
	public void setCnfrmfileid(String cnfrmfileid) {
		this.cnfrmfileid = cnfrmfileid;
	}
	public String getCnfrmfilenm() {
		return cnfrmfilenm;
	}
	public void setCnfrmfilenm(String cnfrmfilenm) {
		this.cnfrmfilenm = cnfrmfilenm;
	}
	public String getIssuenum() {
		return issuenum;
	}
	public void setIssuenum(String issuenum) {
		this.issuenum = issuenum;
	}
	public String getRgsttm() {
		return rgsttm;
	}
	public void setRgsttm(String rgsttm) {
		this.rgsttm = rgsttm;
	}
	public String getIssuemdfreq() {
		return issuemdfreq;
	}
	public void setIssuemdfreq(String issuemdfreq) {
		this.issuemdfreq = issuemdfreq;
	}
	
	@Override
	public String toString() {
		return "CnfrmPrchReqVO [applnum=" + applnum + ", applrcvdt=" + applrcvdt + ", applrcvid=" + applrcvid
				+ ", applrcvnm=" + applrcvnm + ", prchdt=" + prchdt + ", shipdt=" + shipdt + ", prtnum=" + prtnum
				+ ", cmpnnm=" + cmpnnm + ", addr1=" + addr1 + ", addr2=" + addr2 + ", ceonm=" + ceonm + ", mgrname="
				+ mgrname + ", mgremail=" + mgremail + ", mgrfax=" + mgrfax + ", mgrtel=" + mgrtel + ", mgrphone="
				+ mgrphone + ", prepayyn=" + prepayyn + ", smsyn=" + smsyn + ", applditc=" + applditc + ", sts=" + sts
				+ ", codenm=" + codenm + ", notes=" + notes + ", rmncnt=" + rmncnt + ", splyprtnum=" + splyprtnum
				+ ", splyaddr1=" + splyaddr1 + ", splyaddr2=" + splyaddr2 + ", splyceonm=" + splyceonm + ", splyorgnm="
				+ splyorgnm + ", wrtrid=" + wrtrid + ", wrtrnm=" + wrtrnm + ", smpldt=" + smpldt + ", smpldocid="
				+ smpldocid + ", smplfileid=" + smplfileid + ", smplfilenm=" + smplfilenm + ", cnfrmdt=" + cnfrmdt
				+ ", cnfrmid=" + cnfrmid + ", smplmdfreq=" + smplmdfreq + ", cnfrmfileid=" + cnfrmfileid
				+ ", cnfrmfilenm=" + cnfrmfilenm + ", issuenum=" + issuenum + ", rgsttm=" + rgsttm + ", issuemdfreq="
				+ issuemdfreq + "]";
	}
}
