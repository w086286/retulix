package com.tis.retulix.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.retulix.mapper.UserMapper;

import lombok.extern.log4j.Log4j;

import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;

@Service(value="userServiceImpl")
@Log4j
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserMapper userMapper;

	/**로그인 정보 대조*/
	@Override
	public MemberVO findUserByEmail(String email) {
		return this.userMapper.findUserByEmail(email);
	}

	/**로그인 가능여부 판별*/
	@Override
	public MemberVO isLoginOk(String email, String pwd) throws NotUserException {
		MemberVO dbUser=this.findUserByEmail(email);		//userid로 select해서 있으면 가져오고 아니면 말고
		
		//회원상태 별 로그인 허용 판별
		//log.info("회원 상태="+dbUser.getState());
		if(dbUser==null || dbUser.getState()==-2) throw new NotUserException("등록되지 않은 회원입니다. 회원가입 후 이용해주세요.");	//아이디가 존재하지 않거나 탈퇴회원인 경우
		if(dbUser.getState()==-1) throw new NotUserException("정지된 계정입니다. admin@retulix.com으로 문의하시길 바랍니다.");		//정지회원인 경우
		if(!dbUser.getPwd().equals(pwd)) throw new NotUserException("아이디 또는 비밀번호가 일치하지 않습니다.");	//비밀번호 틀렸을 경우
		
		return dbUser;	//유효성체크 모두 통과시 dbUser LoginController로 반환
	}

}
