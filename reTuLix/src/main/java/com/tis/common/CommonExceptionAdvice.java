package com.tis.common;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import com.tis.common.model.NotUserException;

/** 예외 처리 */

@ControllerAdvice
public class CommonExceptionAdvice {
	
	@Inject
	private CommonUtil util;
	
	@ExceptionHandler(NotUserException.class)
	public String handleException(Exception ex, Model m) {
		return util.addMsgBack(m, ex.getMessage());
	}
}
