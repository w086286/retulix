package com.tis.retulix.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class NoticeVO {
	
	private int idx;
	private String title;
	private String info;
	private Date wdate;
	private int click;
	private String name;
	
	public NoticeVO() {
		
	}

}
