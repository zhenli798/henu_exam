package com.lz.entity;

public class Teacher {
	private String t_id;
	private String t_pwd;
	private String t_name;
	private Integer t_isadmin;//0,1
	//构造方法，域
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getT_pwd() {
		return t_pwd;
	}
	public void setT_pwd(String t_pwd) {
		this.t_pwd = t_pwd;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	public Integer getT_isadmin() {
		return t_isadmin;
	}
	public void setT_isadmin(Integer t_isadmin) {
		this.t_isadmin = t_isadmin;
	}
}
