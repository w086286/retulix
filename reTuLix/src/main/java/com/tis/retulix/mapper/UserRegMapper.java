package com.tis.main.mapper;

import com.tis.retulix.domain.MemberVO;

public interface UserRegMapper {

	int userEmailCheck(String email);
	
	int userRegister(MemberVO user);
}
