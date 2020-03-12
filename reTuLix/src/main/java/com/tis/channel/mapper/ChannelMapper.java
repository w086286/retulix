package com.tis.channel.mapper;

import java.util.List;
import java.util.Map;

import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Stat_ViewVO;

public interface ChannelMapper {
	
	/**chStat*/
	Stat_ViewVO showUserStat(String email);			//채널 추이 통계
	Stat_ViewVO showStatMax(String email);			//채널 추이 통계:최다 조회수, 최다 좋아요
	List<Stat_ViewVO> showUserReview(String email);	//업로드한 리뷰 목록
	
	/**chInfo*/
	MemberVO showUserInfo(String email);	//회원정보 출력 메소드
	int updateUserInfo(MemberVO vo);		//회원정보 수정 메소드
	int deleteUserInfo(String email);			//회원 탈퇴 메소드

}
