package com.tis.common.model;

public class NotUserException extends Exception {
	
	public NotUserException() {
		super("등록된 회원이 아닙니다. 회원가입 후 이용해 주세요.");	
	}
	
	public NotUserException(String msg) {
		super(msg);
	}

}
