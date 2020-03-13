package com.tis.retulix.service;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.mapper.UserRegMapper;

@Service(value="UserReg")
public class UserRegServiceImpl implements UserRegService {

	@Inject	
	/* private SqlSessionTemplate userSqlSession; */
	private UserRegMapper userregmapper;
	
	@Override
	public int userEmailCheck(String email) {
		/* userregmapper=userSqlSession.getMapper(UserRegMapper.class); */
		/* int cnt=this.userregmapper.userEmailCheck(email); */
		return this.userregmapper.userEmailCheck(email);
	}

}
