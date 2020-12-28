package com.mansmall.domain;

import java.util.Date;

public class MemberVO {

	/*
	 * 1)테이블명의 컬럼명과 VO클래스의 필드(변수)명을 일치 시키는 경우
	 * 2) 테이블명의 컬럼명과 VO 클래스의 필드(변수)명을 다르게 하는 경우: 
	 * -중간 작업이 필요하다.(mapper 파일에 resultMap 사용해야 함.)
	
		CTRL+Shift+y : 대문자 -> 소문자,  CTRL+Shift+x : 소문자 -> 대문자
	*/
	
	private String mb_id;
	private String mb_name;
	private String mb_pw;
	private String mb_email ;
	private String mb_zipcode ;
	private String mb_addr; 
	private String mb_addr_d;
	private String mb_phone;
	private String mb_nickname;
	private String mb_accept_e;
	private int	   mb_point;
	private Date   mb_Date_sub;
	private Date   mb_Date_up;
	private Date   mb_Date_last;
	private String mb_authcode;
	
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getMb_name() {
		return mb_name;
	}
	public void setMb_name(String mb_name) {
		this.mb_name = mb_name;
	}
	public String getMb_pw() {
		return mb_pw;
	}
	public void setMb_pw(String mb_pw) {
		this.mb_pw = mb_pw;
	}
	public String getMb_email() {
		return mb_email;
	}
	public void setMb_email(String mb_email) {
		this.mb_email = mb_email;
	}
	public String getMb_zipcode() {
		return mb_zipcode;
	}
	public void setMb_zipcode(String mb_zipcode) {
		this.mb_zipcode = mb_zipcode;
	}
	public String getMb_addr() {
		return mb_addr;
	}
	public void setMb_addr(String mb_addr) {
		this.mb_addr = mb_addr;
	}
	public String getMb_addr_d() {
		return mb_addr_d;
	}
	public void setMb_addr_d(String mb_addr_d) {
		this.mb_addr_d = mb_addr_d;
	}
	public String getMb_phone() {
		return mb_phone;
	}
	public void setMb_phone(String mb_phone) {
		this.mb_phone = mb_phone;
	}
	public String getMb_nickname() {
		return mb_nickname;
	}
	public void setMb_nickname(String mb_nickname) {
		this.mb_nickname = mb_nickname;
	}
	public String getMb_accept_e() {
		return mb_accept_e;
	}
	public void setMb_accept_e(String mb_accept_e) {
		this.mb_accept_e = mb_accept_e;
	}
	public int getMb_point() {
		return mb_point;
	}
	public void setMb_point(int mb_point) {
		this.mb_point = mb_point;
	}
	public Date getMb_Date_sub() {
		return mb_Date_sub;
	}
	public void setMb_Date_sub(Date mb_Date_sub) {
		this.mb_Date_sub = mb_Date_sub;
	}
	public Date getMb_Date_up() {
		return mb_Date_up;
	}
	public void setMb_Date_up(Date mb_Date_up) {
		this.mb_Date_up = mb_Date_up;
	}
	public Date getMb_Date_last() {
		return mb_Date_last;
	}
	public void setMb_Date_last(Date mb_Date_last) {
		this.mb_Date_last = mb_Date_last;
	}
	public String getMb_authcode() {
		return mb_authcode;
	}
	public void setMb_authcode(String mb_authcode) {
		this.mb_authcode = mb_authcode;
	}
	@Override
	public String toString() {
		return "MemberVO [mb_id=" + mb_id + ", mb_name=" + mb_name + ", mb_pw=" + mb_pw + ", mb_email=" + mb_email
				+ ", mb_zipcode=" + mb_zipcode + ", mb_addr=" + mb_addr + ", mb_addr_d=" + mb_addr_d + ", mb_phone="
				+ mb_phone + ", mb_nickname=" + mb_nickname + ", mb_accept_e=" + mb_accept_e + ", mb_point=" + mb_point
				+ ", mb_Date_sub=" + mb_Date_sub + ", mb_Date_up=" + mb_Date_up + ", mb_Date_last=" + mb_Date_last
				+ ", mb_authcode=" + mb_authcode + "]";
	}

	
	
	
	
	}
	
	

	
	

