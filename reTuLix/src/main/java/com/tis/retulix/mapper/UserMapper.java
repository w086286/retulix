package com.tis.retulix.mapper;

import com.tis.common.model.NotUserException;
import com.tis.retulix.domain.MemberVO;

/** DAO, 영속성 계층
 * - context-datasource.xml에 mybatis-spring:scan에 등록된  패키지의 Mapper인터페이스명과 
 * 	 Mapper.xml 파일의 네임스페이스명을 반드시 동일하게 기술해야 함 
 * - 인터페이스의 추상 메소드 이름이 Mapper.xml의 id로 사용됨 ==> id로 식별 */

//[1]인터페이스 생성
//[2]context-datasource.xml에 가서 spring-scan 설정(a]부터)
public interface UserMapper {
	int createUser(MemberVO user);
	
	MemberVO findUserByEmail(String email);
	
	MemberVO isLoginOk(String email, String pwd) throws NotUserException;

	//[4]UserMapper.xml작성하러 가기
}
