package com.deco.basket.db;

public class BasketDTO {
	
	private int n_num;
	private int n_user_num;
	private int l_num;
	private int bm_num;
	private int n_c_num;
	
	public int getN_num() {
		return n_num;
	}
	public void setN_num(int n_num) {
		this.n_num = n_num;
	}
	public int getN_user_num() {
		return n_user_num;
	}
	public void setN_user_num(int n_user_num) {
		this.n_user_num = n_user_num;
	}
	public int getL_num() {
		return l_num;
	}
	public void setL_num(int l_num) {
		this.l_num = l_num;
	}
	public int getBm_num() {
		return bm_num;
	}
	public void setBm_num(int bm_num) {
		this.bm_num = bm_num;
	}
	public int getN_c_num() {
		return n_c_num;
	}
	public void setN_c_num(int n_c_num) {
		this.n_c_num = n_c_num;
	}
	@Override
	public String toString() {
		return "BasketDTO [n_num=" + n_num + ", n_user_num=" + n_user_num + ", l_num=" + l_num + ", bm_num=" + bm_num
				+ ", n_c_num=" + n_c_num + "]";
	}
	
	
	
	
	
	
	

}
