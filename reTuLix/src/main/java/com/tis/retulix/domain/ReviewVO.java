package com.tis.retulix.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewVO {
	
	private String divi;
	private String genre;
	private String num;
	private String idx;
	private String title;
	private String url;
	private String info;
	private int good;
	private int click;
	private int zzim;
	private String email;
	private String t_idx;
	private Date wdate;
	
	public ReviewVO(String divi, String genre, String num, String idx, String title, String url, String info, int good,
			int click, int zzim, String email, String t_idx, Date wdate) {
		super();
		this.divi = divi;
		this.genre = genre;
		this.num = num;
		this.idx = this.divi+this.genre+this.num;
		this.title = title;
		this.url = url;
		this.info = info;
		this.good = good;
		this.click = click;
		this.zzim = zzim;
		this.email = email;
		this.t_idx = t_idx;
		this.wdate = wdate;
	}
	
}
