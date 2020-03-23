package com.tis.main.service;

import com.tis.retulix.domain.MemberVO;

public interface UserRegService {

	int userEmailCheck(String email);
	
	int userRegister(MemberVO user);
}
