package com.tis.retulix.service;

import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;


public interface UserService {
	
	MemberVO findUserByEmail(String email);
	
	MemberVO isLoginOk(String email, String pwd) throws NotUserException;	
	
	
}
