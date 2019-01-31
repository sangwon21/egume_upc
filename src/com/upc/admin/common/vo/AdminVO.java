package com.upc.admin.common.vo;

import java.util.Date;

/**
 * 어드민 등록을 위한 VO
 * @author 김진혁
 * @since 2018. 12. 19.
 * @version 1.0
 * @see 참고
 * 수정이력
 * 버전		수정일		수정자		수정내용
 * 1.0		2018.12.19	김진혁		최초작성
 */
public class AdminVO {
	private String admid;
	private String pw;
	private String name;
	private String email;
	private String tel;
	private String role;
	private String useyn; 
	private String rgsttm;
	private String rgstid;
	private String mdftm;
	private String mdfid;
	public String getAdmid() {
		return admid;
	}
	public void setAdmid(String admid) {
		this.admid = admid;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getUseyn() {
		return useyn;
	}
	public void setUseyn(String useyn) {
		this.useyn = useyn;
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
	@Override
	public String toString() {
		return "AdminVO [admid=" + admid + ", pw=" + pw + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", role=" + role + ", useyn=" + useyn + ", rgsttm=" + rgsttm + ", rgstid=" + rgstid + ", mdftm="
				+ mdftm + ", mdfid=" + mdfid + "]";
	}
	
}
