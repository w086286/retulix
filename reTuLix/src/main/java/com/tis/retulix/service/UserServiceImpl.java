package com.tis.retulix.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.retulix.mapper.UserMapper;
import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;

//[1]annotation 부여: 비즈니스 계층
@Service(value="userServiceImpl")
public class UserServiceImpl implements UserService {
	
	//[2]UserController에 가서 서비스 주입(2]번 부터)
	
	//[3]주입
	@Inject		//@Autowried와 동일하게 by type으로 주입함. 단 pom.xml에 의존성 라이브러리를 등록해야 사용 가능
	private UserMapper userMapper;

	//[4]오버라이드하면 DB연동 끝!
	@Override
	public MemberVO findUserByEmail(String email) {
		return this.userMapper.findUserByEmail(email);
		//UserMapper.xml가서 select문 작성
	}

	@Override
	public MemberVO isLoginOk(String email, String pwd) throws NotUserException {
		MemberVO dbUser=this.findUserByEmail(email);		//userid로 select해서 있으면 가져오고 아니면 말고
		if(dbUser==null) throw new NotUserException("등록되지 않은 회원입니다. 회원가입 후 이용해주세요.");	//아이디가 존재하지 않을 경우 exception 발생시킴
		if(!dbUser.getPwd().equals(pwd)) throw new NotUserException("아이디 또는 비밀번호가 일치하지 않습니다.");	//비밀번호 틀렸을 경우 exception 발생시킴
		return dbUser;	//유효성체크 모두 통과시 dbUser반환
	}

}
