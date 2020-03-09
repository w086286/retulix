package com.tis.retulix.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int idx;
	private String title;
	private String info;
	private Date wdate;
	private int click;
	private String name;

}
