package com.tis.retulix;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.service.MainService;

@Controller
@RequestMapping("/user")
public class onlyDramaController {
	@Resource(name="mainSvc")
	private MainService mainservice;
	
	//구독자 

	//드라마만
	@GetMapping("/onlyDrama")
	public String onlyDrama(Model m) {
		List<Trailer_ViewVO> DramaList=this.mainservice.Drama();
		List<Trailer_ViewVO> recommendList=this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList=this.mainservice.zzimList();
		Collections.shuffle(DramaList);
		Collections.shuffle(zzimList);
		m.addAttribute("onDramaTitle", DramaList);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);
		return "main/onlyDrama";
	}
	
}
