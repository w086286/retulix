package com.tis.retulix.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.retulix.mapper.UserMapper;
import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;


@Service(value="userServiceImpl")
public class UserServiceImpl implements UserService {
	

	@Inject		
	private UserMapper userMapper;

	
	@Override
	public MemberVO findUserByEmail(String email) {
		return this.userMapper.findUserByEmail(email);
		
	}

	@Override
	public MemberVO isLoginOk(String email, String pwd) throws NotUserException {
		MemberVO dbUser=this.findUserByEmail(email);		
		if(dbUser==null) throw new NotUserException("등록되지 않은 회원입니다. 회원가입 후 이용해주세요.");	
		if(!dbUser.getPwd().equals(pwd)) throw new NotUserException("아이디 또는 비밀번호가 일치하지 않습니다.");	
		return dbUser;	
	}

}
