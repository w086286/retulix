package com.tis.retulix.trailer.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.retulix.domain.ReviewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.trailer.mapper.Trailer_Mapper;

@Service
public class Trailer_ServiceImpl implements Trailer_Service {

	@Inject
	private Trailer_Mapper trailer_Mapper;
	
	@Override
	public Trailer_ViewVO selectOne(String pp) {
		
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
	public List<ReviewVO> selectReview(String idx) {
		
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

}
