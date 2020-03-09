package com.tis.retulix.domain;

import lombok.Data;

@Data
public class TrailerVO {

	private String divi;
	private String genre;
	private String num;
	private String idx;
	private String api_idx;
	private String url;
	private String title;
	private int good;
	private int click;
	private int zzim;
	private String email;
	
	public TrailerVO(String divi, String genre, String num, String idx, String api_idx, String url, String title,
			int good, int click, int zzim, String email) {
		super();
		this.divi = divi;
		this.genre = genre;
		this.num = num;
		this.idx = this.divi+this.genre+this.num;
		this.api_idx = api_idx;
		this.url = url;
		this.title = title;
		this.good = good;
		this.click = click;
		this.zzim = zzim;
		this.email = email;
	}
	
}
