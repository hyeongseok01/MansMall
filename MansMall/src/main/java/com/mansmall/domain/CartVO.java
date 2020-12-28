package com.mansmall.domain;

public class CartVO {
	
	private int cart_code;
	private int pdt_num;
	private String mb_id;
	private int cart_amount;
	
	/* Getter and Setter */
	public int getCart_code() {
		return cart_code;
	}
	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public int getCart_amount() {
		return cart_amount;
	}
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	@Override
	public String toString() {
		return "CartVO [cart_code=" + cart_code + ", pdt_num=" + pdt_num + ", mb_id=" + mb_id + ", cart_amount="
				+ cart_amount + "]";
	}
	
	
	
	
	
	
	
}
