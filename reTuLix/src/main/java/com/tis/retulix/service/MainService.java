package com.tis.retulix.service;



import java.util.List;

import com.tis.retulix.domain.SubsVO;
import com.tis.retulix.domain.Trailer_ViewVO;

public interface MainService {

	public List<SubsVO> subscribeList(String email);
	
	public List<Trailer_ViewVO> mainTrailer();
	
	public List<Trailer_ViewVO> SF_Movie();
	
	public List<Trailer_ViewVO> CO_Movie();
	
	public List<Trailer_ViewVO> AC_Movie();
	
	public List<Trailer_ViewVO> HO_Movie();
	
	public List<Trailer_ViewVO> RO_Movie();
	
	public List<Trailer_ViewVO> Drama();
	
	public List<Trailer_ViewVO> clickAlign();
	
	/* public List<Trailer_ViewVO> clickAlignSlider(); */
	
	public List<Trailer_ViewVO> goodAlign();
	
	public List<Trailer_ViewVO> recommendList();
	
	public List<Trailer_ViewVO> zzimList();
	
	public List<Trailer_ViewVO> historyList();
	
	public List<Trailer_ViewVO> onlyMovie();
	
	/* public List<Trailer_ViewVO> onlyDrama(); */
	
	public List<Trailer_ViewVO> searchList(String keyword);
}
