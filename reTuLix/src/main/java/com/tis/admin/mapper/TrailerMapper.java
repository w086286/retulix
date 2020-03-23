package com.tis.admin.mapper;

import java.util.List;

import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.TrailerVO;

public interface TrailerMapper {

	int getTotalTrailer(); // 총트레일러수

	int getTotalSearchTrailer(PagingVO paging); // 검색한 트레일러수

	List<TrailerVO> getTrailer(PagingVO paging); // 모든 트레일러목록

	List<TrailerVO> getSearchTrailer(PagingVO paging); // 검색한 트레일러목록

	TrailerVO getTrailerByIdx(String idx); // 특정 트레일러내용 가져오기
	String increaseSeq();						//시퀀스증가
	int insertTrailer(TrailerVO trailer);	//공지사항 작성

	int updateTrailer(TrailerVO trailer); // 트레일러 수정

	int deleteTrailer(String idx); // 트레일러 삭제
}
