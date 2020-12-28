package com.mansmall.domain;

import java.util.Date;

public class ReviewVO {
	
	private int 	rev_num;
	private String 	mb_id;
	private int		pdt_num;
	private String	rev_content;
	private int 	rev_score;
	private Date	rev_date_reg;
	
	/* Getter and Setter */
	public int getRev_num() {
		return rev_num;
	}
	public void setRev_num(int rev_num) {
		this.rev_num = rev_num;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public int getRev_score() {
		return rev_score;
	}
	public void setRev_score(int rev_score) {
		this.rev_score = rev_score;
	}
	public Date getRev_date_reg() {
		return rev_date_reg;
	}
	public void setRev_date_reg(Date rev_date_reg) {
		this.rev_date_reg = rev_date_reg;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [rev_num=" + rev_num + ", mb_id=" + mb_id + ", pdt_num=" + pdt_num + ", rev_content="
				+ rev_content + ", rev_score=" + rev_score + ", rev_date_reg=" + rev_date_reg + "]";
	}
	
	
}
