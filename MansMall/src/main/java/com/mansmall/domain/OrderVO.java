package com.mansmall.domain;

import java.util.Date;

public class OrderVO {
	
	/*
	 * CREATE TABLE ORDER_TBL(
	ODR_CODE				NUMBER								PRIMARY KEY,
	MB_ID					VARCHAR2(15)						NOT NULL,
	ODR_NAME				VARCHAR2(30)						NOT NULL,
	ODR_ZIPCODE		    	CHAR(5)								NOT NULL,
	ODR_ADDR				VARCHAR2(50)						NOT NULL,
	ODR_ADDR_D			    VARCHAR2(50)						NOT NULL,
	ODR_PHONE				VARCHAR2(20)						NOT NULL,
	ODR_TOTAL_PRICE		    NUMBER								NOT NULL,
	ODR_DATE				DATE DEFAULT SYSDATE			    NOT NULL,
    FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
	 */
	
	private int odr_code;
	private String mb_id;
	private String odr_name;
	private String odr_zipcode;
	private String odr_addr;
	private String odr_addr_d;
	private String odr_phone;
	private int odr_totalprice;
	private Date odr_date;
	private String delivery; 
	
	public int getOdr_code() {
		return odr_code;
	}
	public void setOdr_code(int odr_code) {
		this.odr_code = odr_code;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getOdr_name() {
		return odr_name;
	}
	public void setOdr_name(String odr_name) {
		this.odr_name = odr_name;
	}
	public String getOdr_zipcode() {
		return odr_zipcode;
	}
	public void setOdr_zipcode(String odr_zipcode) {
		this.odr_zipcode = odr_zipcode;
	}
	public String getOdr_addr() {
		return odr_addr;
	}
	public void setOdr_addr(String odr_addr) {
		this.odr_addr = odr_addr;
	}
	public String getOdr_addr_d() {
		return odr_addr_d;
	}
	public void setOdr_addr_d(String odr_addr_d) {
		this.odr_addr_d = odr_addr_d;
	}
	public String getOdr_phone() {
		return odr_phone;
	}
	public void setOdr_phone(String odr_phone) {
		this.odr_phone = odr_phone;
	}
	public int getOdr_totalprice() {
		return odr_totalprice;
	}
	public void setOdr_totalprice(int odr_totalprice) {
		this.odr_totalprice = odr_totalprice;
	}
	public Date getOdr_date() {
		return odr_date;
	}
	public void setOdr_date(Date odr_date) {
		this.odr_date = odr_date;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	@Override
	public String toString() {
		return "OrderVO [odr_code=" + odr_code + ", mb_id=" + mb_id + ", odr_name=" + odr_name + ", odr_zipcode="
				+ odr_zipcode + ", odr_addr=" + odr_addr + ", odr_addr_d=" + odr_addr_d + ", odr_phone=" + odr_phone
				+ ", odr_totalprice=" + odr_totalprice + ", odr_date=" + odr_date + ", delivery=" + delivery + "]";
	}
	
	
	
	
	
}
