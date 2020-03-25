package com.tis.trailer.mapper;

import java.util.List;
import java.util.Map;

import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Review_ViewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.domain.Zzim_TrailerVO;

public interface TrailerView_Mapper {

	Trailer_ViewVO selectOne(String pp);//1개만 꺼내는걸로
	Trailer_ViewVO select_Random_One();//랜덤으로 1개만꺼내는걸로
	public List<Trailer_ViewVO> selectPoster(Map map);//연관영상 가져오기
	public List<Review_ViewVO> selectReview(String idx); //영상리뷰
	int update_seleted(Map info); //영상정보 업데이트
	
	int insert_ZzimT(Map map);//Zzim추가
	Zzim_TrailerVO ZtVo(Map map);//Zzim안에  있나 확인
	int del_Zzim(Map map);//Zzim삭제
	Review_ViewVO selectOneReview(String pp); //리뷰1개만 추출
	MemberVO select_who_upload(String email);//사람추출
	List<Review_ViewVO> selectMultiReview(Map idx);//리뷰1개 뺴고 랜덤 추출

	int update_count(String pp);//트레일러 조회수
	int update_count_Review(String pp);//리뷰 조회수
	
}
