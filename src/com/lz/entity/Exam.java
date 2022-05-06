package com.lz.entity;

public class Exam {
	private Integer e_id;
	private String t_id;
	private String e_name;
	private String e_starttime;
	private String e_stoptime;
	private String q_name;
	private String q_path;
	private Integer e_autostart;
	private Integer e_status;
	
	//构造方法，域
	
	public Integer getE_id() {
		return e_id;
	}
	public void setE_id(Integer e_id) {
		this.e_id = e_id;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public String getE_starttime() {
		return e_starttime;
	}
	public void setE_starttime(String e_starttime) {
		this.e_starttime = e_starttime;
	}
	public String getE_stoptime() {
		return e_stoptime;
	}
	public void setE_stoptime(String e_stoptime) {
		this.e_stoptime = e_stoptime;
	}
	public String getQ_name() {
		return q_name;
	}
	public void setQ_name(String q_name) {
		this.q_name = q_name;
	}
	public String getQ_path() {
		return q_path;
	}
	public void setQ_path(String q_path) {
		this.q_path = q_path;
	}
	public Integer getE_autostart() {
		return e_autostart;
	}
	public void setE_autostart(Integer e_autostart) {
		this.e_autostart = e_autostart;
	}
	public Integer getE_status() {
		return e_status;
	}
	public void setE_status(Integer e_status) {
		this.e_status = e_status;
	}

	
}
