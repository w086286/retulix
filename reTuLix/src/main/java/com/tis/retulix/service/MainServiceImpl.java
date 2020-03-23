package com.tis.main.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.tis.main.mapper.MainMapper;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Trailer_ViewVO;

@Service(value = "mainSvc")
public class MainServiceImpl implements MainService {

	@Resource(name = "mainMapper")
	private MainMapper mainMapper;

	@Override
	public List<MemberVO> subscribeList(String email) {
		// TODO Auto-generated method stub
		return this.mainMapper.subscribeList(email);
	}

	@Override
	public List<Trailer_ViewVO> mainTrailer() {
		// TODO Auto-generated method stub
		return this.mainMapper.mainTrailer();
	}

	@Override
	public List<Trailer_ViewVO> SF_Movie() {
		// TODO Auto-generated method stub
		return this.mainMapper.SF_Movie();
	}

	@Override
	public List<Trailer_ViewVO> CO_Movie() {
		// TODO Auto-generated method stub
		return this.mainMapper.CO_Movie();
	}

	@Override
	public List<Trailer_ViewVO> AC_Movie() {
		// TODO Auto-generated method stub
		return this.mainMapper.AC_Movie();
	}

	@Override
	public List<Trailer_ViewVO> HO_Movie() {
		// TODO Auto-generated method stub
		return this.mainMapper.HO_Movie();
	}

	@Override
	public List<Trailer_ViewVO> RO_Movie() {
		// TODO Auto-generated method stub
		return this.mainMapper.RO_Movie();
	}

	@Override
	public List<Trailer_ViewVO> Drama() {
		// TODO Auto-generated method stub
		return this.mainMapper.Drama();
	}

	@Override
	public List<Trailer_ViewVO> clickAlign() {
		// TODO Auto-generated method stub
		return this.mainMapper.clickAlign();
	}

	@Override
	public List<Trailer_ViewVO> goodAlign() {
		// TODO Auto-generated method stub
		return this.mainMapper.goodAlign();
	}

	@Override
	public List<Trailer_ViewVO> recommendList() {
		// TODO Auto-generated method stub
		return this.mainMapper.recommendList();
	}

	@Override
	public List<Trailer_ViewVO> zzimList(String email) {
		// TODO Auto-generated method stub
		return this.mainMapper.zzimList(email);
	}

	@Override
	public List<Trailer_ViewVO> historyList(String email) {
		// TODO Auto-generated method stub
		return this.mainMapper.historyList(email);
	}

	@Override
	public List<Trailer_ViewVO> onlyMovie() {
		// TODO Auto-generated method stub
		return this.mainMapper.onlyMovie();
	}

	@Override
	public List<Trailer_ViewVO> searchList(String keyword) {
		// TODO Auto-generated method stub
		return this.mainMapper.searchList(keyword);
	}
}
