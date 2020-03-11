package com.tis.channel.mapper;

import com.tis.retulix.domain.MemberVO;

public interface ChannelMapper {
	
	MemberVO showUserInfo(String email);	//회원정보 출력 메소드
	int updateUserInfo(MemberVO vo);		//회원정보 수정 메소드
	int deleteUserInfo(String email);			//회원 탈퇴 메소드

}
