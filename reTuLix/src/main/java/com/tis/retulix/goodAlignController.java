package com.tis.retulix;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.service.MainService;

@Controller
public class goodAlignController {
	@Resource(name="mainSvc")
	private MainService mainservice;

	@GetMapping("/goodAlign")
	public String goodAlign(Model m) {
		List<Trailer_ViewVO> goodAlignList=this.mainservice.goodAlign();
		List<Trailer_ViewVO> recommendList=this.mainservice.recommendList();
		List<Trailer_ViewVO> zzimList=this.mainservice.zzimList();
		
		Collections.shuffle(zzimList);
		m.addAttribute("goodTitle", goodAlignList);
		m.addAttribute("reListTitle", recommendList);
		m.addAttribute("zzimListTitle", zzimList);
		return "main/goodAlign";
	}

}
