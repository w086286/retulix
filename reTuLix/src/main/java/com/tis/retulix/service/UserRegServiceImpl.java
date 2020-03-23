package com.tis.main.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.main.mapper.UserRegMapper;
import com.tis.retulix.domain.MemberVO;

@Service(value = "UserReg")
public class UserRegServiceImpl implements UserRegService {

	@Inject
	private UserRegMapper userregmapper;

	@Override
	public int userEmailCheck(String email) {

		return this.userregmapper.userEmailCheck(email);
	}

	@Override
	public int userRegister(MemberVO user) {

		return this.userregmapper.userRegister(user);
	}

}
