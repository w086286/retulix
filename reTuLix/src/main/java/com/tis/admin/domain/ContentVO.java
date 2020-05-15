package com.tis.admin.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ContentVO {
//12312312312312312
	private String idx;
	private String email;
	private String name;
	private String trailerTitle;
	private String reviewTitle;
	private String info;
	private String url;
	private Date wdate;
	//dfdfdfdfdfdfdfdf gittestestest
	private String gitBumpTest;
	
	private String add;
	
	public ContentVO() {
		
	}
}
