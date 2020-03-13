 package com.tis.retulix;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.service.MainService;

import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/user")
public class mainController {
	@Resource(name="mainSvc")
	private MainService mainservice;
	
	
	/*
	 * @GetMapping("/main") public @ResponseBody Map<String, String>
	 * subscribeList(@RequestParam("inputemail") String email, Model m) {
	 * 
	 * Map<String, String> map=new HashMap<>(); map.put("userEmailCheck", email);
	 * 
	 * m.addAttribute("mainTrailer", map); return "main/main"; }
	 */
	
	//메인 트레일러
	@GetMapping("/main")
	public String main(Model m) {
		List<Trailer_ViewVO> TrailerList=this.mainservice.mainTrailer();
		List<Trailer_ViewVO> SFMList=this.mainservice.SF_Movie();
		List<Trailer_ViewVO> COMList=this.mainservice.CO_Movie();
		List<Trailer_ViewVO> ACMList=this.mainservice.AC_Movie();
		List<Trailer_ViewVO> HOMList=this.mainservice.HO_Movie();
		List<Trailer_ViewVO> ROMList=this.mainservice.RO_Movie();
		List<Trailer_ViewVO> DramaList=this.mainservice.Drama();
		List<Trailer_ViewVO> ClickList=this.mainservice.clickAlign();
		List<Trailer_ViewVO> zzimList=this.mainservice.zzimList();
		List<Trailer_ViewVO> historyList=this.mainservice.historyList();
		
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
		return "main/main";
	}

}
