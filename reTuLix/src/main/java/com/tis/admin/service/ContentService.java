package com.tis.admin.service;

import java.util.List;

import com.tis.admin.domain.ContentVO;
import com.tis.common.model.PagingVO;

public interface ContentService {

	/* 컨텐츠 */
	int getTotalContent();		//총 컨텐츠
	int getTotalSearchContent(PagingVO paging);	//검색한 컨텐츠
	int getTotalContentByEmail(String email);		//특정멤버의 컨텐츠 수
	
	List<ContentVO> getContent(PagingVO paging);		//모든회원의 컨텐츠
	List<ContentVO> getSearchContent(PagingVO paging);	//검색한 회원의 컨텐츠
	List<ContentVO> getContentByEmail(PagingVO paging, String email);	//특정회원의 컨텐츠
	ContentVO getContentByIdx(String idx);		////idx로 해당 리뷰 가져오기
	
	int updateContent(ContentVO content);			//컨텐츠 수정
	int deleteContent(String idx);				//컨텐츠 삭제
}
