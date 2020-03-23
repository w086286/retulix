package com.tis.main.controller;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tis.main.service.MainService;
import com.tis.retulix.domain.Trailer_ViewVO;

@Controller
public class mainController {
	@Resource(name = "mainSvc")
	private MainService mainservice;

	// 메인 트레일러
	@GetMapping("/main")
	public String main(HttpSession ses, Model m) {
		String email = (String) ses.getAttribute("email");

		List<Trailer_ViewVO> TrailerList = this.mainservice.mainTrailer();
		List<Trailer_ViewVO> SFMList = this.mainservice.SF_Movie();
		List<Trailer_ViewVO> COMList = this.mainservice.CO_Movie();
		List<Trailer_ViewVO> ACMList = this.mainservice.AC_Movie();
		List<Trailer_ViewVO> HOMList = this.mainservice.HO_Movie();
		List<Trailer_ViewVO> ROMList = this.mainservice.RO_Movie();
		List<Trailer_ViewVO> DramaList = this.mainservice.Drama();
		List<Trailer_ViewVO> ClickList = this.mainservice.clickAlign();
		List<Trailer_ViewVO> zzimList = this.mainservice.zzimList(email);
		List<Trailer_ViewVO> historyList = this.mainservice.historyList(email);

		Collections.shuffle(TrailerList);
		Collections.shuffle(SFMList);
		Collections.shuffle(COMList);
		Collections.shuffle(ACMList);
		Collections.shuffle(HOMList);
		Collections.shuffle(ROMList);
		Collections.shuffle(DramaList);
		Collections.shuffle(ClickList);
		Collections.shuffle(zzimList);
		Collections.shuffle(historyList);

		m.addAttribute("mainTrailer", TrailerList);
		m.addAttribute("MS_title", SFMList);
		m.addAttribute("MC_title", COMList);
		m.addAttribute("MA_title", ACMList);
		m.addAttribute("MH_title", HOMList);
		m.addAttribute("MR_title", ROMList);
		m.addAttribute("D_title", DramaList);
		m.addAttribute("clickSlider", ClickList);
		m.addAttribute("zzimListTitle", zzimList);
		m.addAttribute("historyListTitle", historyList);

		m.addAttribute("zzimListSize", zzimList.size());
		m.addAttribute("historyListSize", historyList.size());

		return "main/main";
	}

	// 조회수
	@GetMapping("/clickAlign")
	public String clickAlign(Model m, HttpSession ses) {
		String email = (String) ses.getAttribute("email");

		List<Trailer_ViewVO> ClickList = this.mainservice.clickAlign();
		List<Trailer_ViewVO> recommendList = this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList = this.mainservice.zzimList(email);

		Collections.shuffle(zzimList);
		
		m.addAttribute("clickTitle", ClickList);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);

		m.addAttribute("zzimListSize", zzimList.size());

		return "main/clickAlign";
	}

	// 좋아요
	@GetMapping("/goodAlign")
	public String goodAlign(Model m, HttpSession ses) {
		String email = (String) ses.getAttribute("email");

		List<Trailer_ViewVO> goodAlignList = this.mainservice.goodAlign();
		List<Trailer_ViewVO> recommendList = this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList = this.mainservice.zzimList(email);

		Collections.shuffle(zzimList);
		
		m.addAttribute("goodTitle", goodAlignList);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);

		m.addAttribute("zzimListSize", zzimList.size());

		return "main/goodAlign";
	}

	// 드라마만
	@GetMapping("/onlyDrama")
	public String onlyDrama(Model m, HttpSession ses) {
		String email = (String) ses.getAttribute("email");

		List<Trailer_ViewVO> DramaList = this.mainservice.Drama();
		List<Trailer_ViewVO> recommendList = this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList = this.mainservice.zzimList(email);
		
		Collections.shuffle(DramaList);
		Collections.shuffle(zzimList);
		
		m.addAttribute("onDramaTitle", DramaList);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);

		m.addAttribute("zzimListSize", zzimList.size());

		return "main/onlyDrama";
	}

	// 무비만
	@GetMapping("/onlyMovie")
	public String onlyMovie(Model m, HttpSession ses) {
		String email = (String) ses.getAttribute("email");

		List<Trailer_ViewVO> onlyMovieList = this.mainservice.onlyMovie();
		List<Trailer_ViewVO> recommendList = this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList = this.mainservice.zzimList(email);
		
		Collections.shuffle(onlyMovieList);
		Collections.shuffle(zzimList);
		
		m.addAttribute("onMovieTitle", onlyMovieList);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);

		m.addAttribute("zzimListSize", zzimList.size());

		return "main/onlyMovie";
	}

	// 서치
	@GetMapping("/search")
	public String search(@RequestParam("findKeyWord") String keyword, Model m, HttpSession ses) {
		String email = (String) ses.getAttribute("email");

		List<Trailer_ViewVO> searchList = this.mainservice.searchList(keyword);
		List<Trailer_ViewVO> recommendList = this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList = this.mainservice.zzimList(email);

		Collections.shuffle(zzimList);

		m.addAttribute("keywordTitle", searchList);
		m.addAttribute("keyword", keyword);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);

		m.addAttribute("zzimListSize", zzimList.size());
		m.addAttribute("keywordsize", searchList.size());

		return "main/search";
	}

}
