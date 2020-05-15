package com.tis.admin.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ContentVO {

	private String idx;
	private String email;
	private String name;
	private String trailerTitle;
	private String reviewTitle;
	private String info;
	private String url;
	private Date wdate;
	
	private String adddddd;
	
	public ContentVO() {
		
	}
}
