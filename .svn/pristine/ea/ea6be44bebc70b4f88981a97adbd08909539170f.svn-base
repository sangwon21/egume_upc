package com.upc.common.login.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.User;

/**
 * 로그인 정보 VO
 * (username, password, authority, enabled, name(cmpnnm/admname))
 * @author 이 수빈
 * @Date 2018.12.24
 * @version 1.0
 * @see
 *
 */
public class UserDetailsVO extends User{
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	  
	 private String cmpnnm;
	 private String mgrname;
	 public UserDetailsVO(String username, String password, boolean enabled,
	   boolean accountNonExpired, boolean credentialsNonExpired,
	   boolean accountNonLocked,
	   Collection<? extends GrantedAuthority> authorities,String cmpnnm, String mgrname) {
		 
		super(username, password, enabled, accountNonExpired, credentialsNonExpired,
		accountNonLocked, authorities);
		this.cmpnnm = cmpnnm;
		this.mgrname = mgrname;
	 }
	  
	 public String getCmpnnm() {
		return cmpnnm;
	}

	public void setCmpnnm(String cmpnnm) {
		this.cmpnnm = cmpnnm;
	}

	public String getMgrname() {
		return mgrname;
	}

	public void setMgrname(String mgrname) {
		this.mgrname = mgrname;
	}



	@Override
	 public String toString() {
		 return super.toString() + "; CompanyName : "+this.cmpnnm + "; ManagerName : " + this.mgrname;
	 }


}
