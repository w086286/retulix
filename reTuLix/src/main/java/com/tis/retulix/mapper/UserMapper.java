package com.tis.retulix.mapper;

import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;


public interface UserMapper {
	int createUser(MemberVO user);
	
	MemberVO findUserByEmail(String email);
	
	MemberVO isLoginOk(String email, String pwd) throws NotUserException;


}
