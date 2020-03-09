package com.tis.retulix.service;

import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;

//[1]인터페이스 생성
public interface UserService {
	
	MemberVO findUserByEmail(String email);
	
	MemberVO isLoginOk(String email, String pwd) throws NotUserException;	//로그인 여부 체크
	
	//[2]com.tis.user.service 패키지에 UserService를 상속받는 UserServiceImpl 클래스 생성
	
}
