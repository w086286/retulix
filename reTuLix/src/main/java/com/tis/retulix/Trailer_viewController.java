package com.tis.retulix;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.common.CommonUtil;
import com.tis.retulix.domain.ReviewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.trailer.service.Trailer_Service;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class Trailer_viewController {

	@Inject
	private CommonUtil util;
	
	@Inject
	private Trailer_Service trailer_Service;
	

	@RequestMapping(value="/showMovie",method=RequestMethod.GET)
	public String showMovie(@RequestParam("idx") String idx,Model m) {
		
		Trailer_ViewVO vo = trailer_Service.selectOne(idx);
		List<ReviewVO> rarr = trailer_Service.selectReview(vo.getIdx()); 
		List<Trailer_ViewVO> tarr = trailer_Service.selectPoster(vo.getIdx());
		
		m.addAttribute("mvo",vo);
		m.addAttribute("arr",tarr);
		m.addAttribute("reviews",rarr);
		return "mList/repage";
		
	}
	
	
	@RequestMapping("/randomMovie")
	public String randomMovie(Model m) {
		Trailer_ViewVO vo=trailer_Service.select_Random_One();
		List<ReviewVO> rarr = trailer_Service.selectReview(vo.getIdx());
		List<Trailer_ViewVO> tarr = trailer_Service.selectPoster(vo.getIdx());
		
		m.addAttribute("mvo",vo);
		m.addAttribute("arr",tarr);
		m.addAttribute("reviews",rarr);
		return "mList/repage";
	}
	
	
	@RequestMapping(value="/refresh_screen",method=RequestMethod.GET)
	@ResponseBody
	public Trailer_ViewVO refresh_screen(String title) {
		
		Trailer_ViewVO vo = trailer_Service.selectOne(title);
		
		return vo;
	}
	
	
	
	@RequestMapping(value="/movie_changeInfo")
	@ResponseBody
	public Map<String,Integer> movie_changeInfo(String[] tdArr) {
		String tmp2[]= {tdArr[0],tdArr[4],tdArr[5]};
		int result = trailer_Service.update_seleted(tmp2);
		Map<String,Integer> zz=new HashMap<>();
		zz.put("result",result);
		return zz;
	}
	
}
