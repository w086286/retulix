
package com.tis.retulix.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Review_ViewVO {
	
	private String idx;
	private String title;
	private String url;
	private String info;
	private int good;
	private int click;
	private int zzim;
	private String email;
	private Date wdate;
	private String t_title;
	private String t_idx;
	
	public String change(String info) {
		info = info.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		return info.replaceAll("\\'", "");
	}

}
