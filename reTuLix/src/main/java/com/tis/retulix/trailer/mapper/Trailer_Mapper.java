package com.tis.retulix.trailer.mapper;

import java.util.List;
import java.util.Map;

import com.tis.retulix.domain.ReviewVO;
import com.tis.retulix.domain.Trailer_ViewVO;

public interface Trailer_Mapper {

	Trailer_ViewVO selectOne(String pp);//1개만 꺼내는걸로
	Trailer_ViewVO select_Random_One();//랜덤으로 1개만꺼내는걸로
	public List<Trailer_ViewVO> selectPoster(Map map);//연관영상 가져오기
	public List<ReviewVO> selectReview(String idx); //영상리뷰
	int update_seleted(Map info); //영상정보 업데이트

	
}
