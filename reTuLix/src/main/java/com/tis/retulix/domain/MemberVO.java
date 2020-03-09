package com.tis.retulix.domain;

import lombok.Data;

@Data
public class MemberVO {

	private String email;
	private String pwd;
	private String name;
	private String age;
	private int point;
	private int subs;
	private String icon;
	private String chimg;
	private int state;
	
}
