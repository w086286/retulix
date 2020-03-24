
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
	
	public String change_title(String title)
	{
		if(title==null||title.isEmpty()) {return title;}
		title = title.replaceAll("(\r\n|\r|\n|\n\r)", "");
		return title.replaceAll("\\'", "");
	}
	public String change(String info) {
		if(info==null||info.isEmpty()) {return info;}
		info = info.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		return info.replaceAll("\\'", "");
	}

}
