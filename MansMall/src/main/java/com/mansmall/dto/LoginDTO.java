package com.mansmall.dto;

import java.util.Date;

//사용자로부터 아이디와 비번 입력정보를 저장용도
public class LoginDTO {

	private String  mb_id;
	private String  mb_pw;
	private String  mb_nickname;
	private String  mb_name;
	private int     mb_point;
	private Date    mb_Date_last;
	private int     mb_phone;
	private boolean useCookie;   // 로그인페이지  <input type="checkbox" name="useCookie"  아직 미구현 />
	
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getMb_pw() {
		return mb_pw;
	}
	public void setMb_pw(String mb_pw) {
		this.mb_pw = mb_pw;
	}
	public String getMb_nickname() {
		return mb_nickname;
	}
	public void setMb_nickname(String mb_nickname) {
		this.mb_nickname = mb_nickname;
	}
	public String getMb_name() {
		return mb_name;
	}
	public void setMb_name(String mb_name) {
		this.mb_name = mb_name;
	}
	public int getMb_point() {
		return mb_point;
	}
	public void setMb_point(int mb_point) {
		this.mb_point = mb_point;
	}
	public Date getMb_Date_last() {
		return mb_Date_last;
	}
	public void setMb_Date_last(Date mb_Date_last) {
		this.mb_Date_last = mb_Date_last;
	}
	public int getMb_phone() {
		return mb_phone;
	}
	public void setMb_phone(int mb_phone) {
		this.mb_phone = mb_phone;
	}
	public boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	
	@Override
	public String toString() {
		return "LoginDTO [mb_id=" + mb_id + ", mb_pw=" + mb_pw + ", mb_nickname=" + mb_nickname + ", mb_name=" + mb_name
				+ ", mb_point=" + mb_point + ", mb_Date_last=" + mb_Date_last + ", mb_phone=" + mb_phone
				+ ", useCookie=" + useCookie + "]";
	}
	
	
	
	
}
