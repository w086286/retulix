package com.tis.trailer.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Review_ViewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.domain.Zzim_TrailerVO;
import com.tis.trailer.mapper.TrailerView_Mapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class Trailer_ServiceImpl implements Trailer_Service {

	@Inject
	private TrailerView_Mapper trailer_Mapper;
	
	@Override
	public Trailer_ViewVO selectOne(String pp) {
		trailer_Mapper.update_count(pp);
		return trailer_Mapper.selectOne(pp);
	}
  
	@Override
	public Trailer_ViewVO select_Random_One() {
		
		return trailer_Mapper.select_Random_One();
	}

	@Override
	public List<Trailer_ViewVO> selectPoster(String vo) {
		
		Map<String,String> map = new HashMap<>();
		String checking_range = vo.substring(0,2);
		map.put("not", vo);
		map.put("end","%"+checking_range+"%");
		return trailer_Mapper.selectPoster(map);
	}

	@Override
	public List<Review_ViewVO > selectReview(String idx) {
		
		return trailer_Mapper.selectReview(idx);
	}

	@Override
	public int update_seleted(String[] info) {
		Map<String,String> map = new HashMap<>();
		map.put("title", info[0]);
		map.put("api_num", info[1]);
		map.put("idx", info[2]);
		return trailer_Mapper.update_seleted(map);
	}

	@Override
	public int insert_ZzimT(String email,String idx) {
		Map<String,String> map= new HashMap<>();
		map.put("email", email);
		map.put("idx", idx);
		return trailer_Mapper.insert_ZzimT(map);
	}

	@Override
	public Zzim_TrailerVO ZtVo(String email, String idx) {
		Map<String,String> map= new HashMap<>();
		map.put("email", email);
		map.put("idx", idx);
		log.info("map값 확인"+map);
		return trailer_Mapper.ZtVo(map);
	}

	@Override
	public int del_Zzim(String email, String idx) {
		Map<String,String> map= new HashMap<>();
		map.put("email", email);
		map.put("idx", idx);
		return trailer_Mapper.del_Zzim(map);
	}

	@Override
	public Review_ViewVO selectOneReview(String pp) {
		trailer_Mapper.update_count_Review(pp);
		
		return trailer_Mapper.selectOneReview(pp);
	}

	@Override
	public List<Review_ViewVO> selectMultiReview(String idx) {
		String tmp =idx.substring(0,2);
		
		Map<String,String> map= new HashMap<>();
		map.put("start", tmp);
		map.put("end", idx);
		log.info("map값 확인"+map);
		return trailer_Mapper.selectMultiReview(map);
	}

	@Override
	public MemberVO select_who_upload(String email) {
		// TODO 자동 생성된 메소드 스텁
		return trailer_Mapper.select_who_upload(email);
	}

	

}
