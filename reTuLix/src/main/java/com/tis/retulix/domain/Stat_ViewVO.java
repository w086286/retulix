package com.tis.retulix.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Stat_ViewVO {
	
	private String idx;
	private String title;
	private String url;
	private String info;
	private int good;
	private int click;
	private int zzim;
	private int subs;
	private String email;
	private String name;
	private Date wdate;
	private String t_title;
	private String t_idx;
	
}
