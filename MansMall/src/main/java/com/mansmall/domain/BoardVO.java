package com.mansmall.domain;

import java.util.Date;

public class BoardVO {
	
	/*
	CREATE TABLE BOARD_TBL(
	BRD_NUM				    NUMBER								PRIMARY KEY, 
	MB_ID					VARCHAR2(15)						NOT NULL,
	BRD_TITLE				VARCHAR2(100)						NOT NULL,
	BRD_CONTENT		        VARCHAR2(4000)					    NOT NULL,
	BRD_DATE_REG			DATE DEFAULT SYSDATE		    	NOT NULL,
    view_cnt                NUMBER   DEFAULT 0 ,
    FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
	);
	 */
	
	private int brd_num;
	private String mb_id;
	private String brd_title;
	private String brd_content;
	private Date brd_date_reg;
	private int view_cnt;
	
	//신규 게시물에 new마크를 붙일지 말지 결정하는 논리필드 선언.
	private boolean newMark;
	
	public boolean isNewMark() {
		return newMark;
	}
	public void setNewMark(boolean newMark) {
		this.newMark = newMark;
	}
	
	
	public int getBrd_num() {
		return brd_num;
	}
	public void setBrd_num(int brd_num) {
		this.brd_num = brd_num;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getBrd_title() {
		return brd_title;
	}
	public void setBrd_title(String brd_title) {
		this.brd_title = brd_title;
	}
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public Date getBrd_date_reg() {
		return brd_date_reg;
	}
	public void setBrd_date_reg(Date brd_date_reg) {
		this.brd_date_reg = brd_date_reg;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	
	@Override
	public String toString() {
		return "BoardVO [brd_num=" + brd_num + ", mb_id=" + mb_id + ", brd_title=" + brd_title + ", brd_content="
				+ brd_content + ", brd_date_reg=" + brd_date_reg + ", view_cnt=" + view_cnt + "]";
	}
	
	
}
