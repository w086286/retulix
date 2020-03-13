package com.tis.admin.service;

import java.util.List;

import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.TrailerVO;

/* XXXServiceImpl 만들때 반드시 @Service 어노테이션 붙여주고 value를 지정해주자 */
public interface TrailerService {

	int getTotalTrailer(); // 총트레일러수

	int getTotalSearchTrailer(PagingVO paging); // 검색한 트레일러수

	List<TrailerVO> getTrailer(PagingVO paging); // 모든 트레일러목록

	List<TrailerVO> getSearchTrailer(PagingVO paging); // 검색한 트레일러목록

	TrailerVO getTrailerByIdx(String idx); // 특정 트레일러내용 가져오기

	int updateTrailer(String idx); // 트레일러 수정

	int deleteTrailer(String idx); // 트레일러 삭제
}
