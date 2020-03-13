package com.tis.admin.mapper;

import java.util.List;

import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.MemberVO;

public interface MemberMapper {

	/* 회원관리 */
	int getTotalMember();		//전체 회원수
	int getTotalSearchMember(PagingVO paging);		//검색한 회원 수
	List<MemberVO> getMemberList(PagingVO paging);		//전체회원목록
	List<MemberVO> getSearchMember(PagingVO paging);		//검색한회원목록
	MemberVO getMemberByEmail(String email);		//이메일로 회원가져오기
	
	int updateMember(MemberVO member);		//회원정보수정
	int deleteMember(String email);			//이메일로 회원정보 삭제
}
