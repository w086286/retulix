package com.tis.channel.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Stat_ViewVO;

public interface ChannelMapper {
	
	/**chStat*/
	Stat_ViewVO showUserStat(String email);			//채널 추이 통계
	Stat_ViewVO showStatMax(Map<String, String> statMap);//채널 추이 통계:최다 조회수, 최다 좋아요
	//업로드한 리뷰 목록
	int getTotalPage(PagingVO paging);				//총 업로드 영상 수 추출
	List<Stat_ViewVO> showUserReview(String email);	//리뷰 목록 출력
	
	/**chInfo*/
	MemberVO showUserInfo(String email);			//회원정보 출력 메소드
	int updateUserInfo(MemberVO vo);				//회원정보 수정 메소드
	int deleteUserInfo(String email);				//회원 탈퇴 메소드
	int updateUserIcon(MemberVO vo);				//회원 아이콘 변경
	//int updateUserIcon(@Param("email") String email, @Param("userIcon") String userIcon);//파라미터가 1개 이상일 경우 @Param 사용 또는 map으로 묶어 전송

}
