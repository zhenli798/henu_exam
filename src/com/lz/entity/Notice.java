package com.lz.entity;

public class Notice {

	private Integer n_id;
	private Integer e_id;
	private String n_text;
	private String n_time;
	//构造方法，域
	
	public Integer getN_id() {
		return n_id;
	}
	public void setN_id(Integer n_id) {
		this.n_id = n_id;
	}
	public Integer getE_id() {
		return e_id;
	}
	public void setE_id(Integer e_id) {
		this.e_id = e_id;
	}
	public String getN_text() {
		return n_text;
	}
	public void setN_text(String n_text) {
		this.n_text = n_text;
	}
	public String getN_time() {
		return n_time;
	}
	public void setN_time(String n_time) {
		this.n_time = n_time;
	}
}
