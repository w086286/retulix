package com.tis.retulix.trailer.service;

import java.util.List;
import java.util.Map;

import com.tis.retulix.domain.ReviewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.domain.Zzim_TrailerVO; 

public interface Trailer_Service {

	Trailer_ViewVO selectOne(String pp);//1개만 꺼내는걸로
	Trailer_ViewVO select_Random_One();//랜덤으로 1개만꺼내는걸로
	public List<Trailer_ViewVO> selectPoster(String map);//연관영상 가져오기
	public List<ReviewVO> selectReview(String idx); //영상리뷰
	int update_seleted(String [] info); //영상정보 업데이트
	
	int insert_ZzimT(String email,String idx);//zzimtrailer추가 
	Zzim_TrailerVO ZtVo(String email,String idx);//있냐판단
	int del_Zzim(String email,String idx);//삭제
}
