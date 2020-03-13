package com.tis.retulix;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.common.CommonUtil;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.ReviewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.domain.Zzim_TrailerVO;
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
	public String showMovie(@RequestParam("idx") String idx,Model m,HttpSession ses) {
		
		Trailer_ViewVO vo = trailer_Service.selectOne(idx);
		List<ReviewVO> rarr = trailer_Service.selectReview(vo.getIdx()); 
		List<Trailer_ViewVO> tarr = trailer_Service.selectPoster(vo.getIdx());
		
		MemberVO mvo = (MemberVO)ses.getAttribute("loginUser");
		if(mvo!=null)
		{
			Zzim_TrailerVO Ztv=trailer_Service.ZtVo(mvo.getEmail(),vo.getIdx());
			if(Ztv!=null)
			{
				m.addAttribute(" ","true");
			}
		}
		
		
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
	
	
	@PostMapping("/ck_zzim")
	@ResponseBody
	public Map<String,Integer> zzim_chking(String [] idx,HttpSession ses) {
		/*
		 * ajax요청
		 * 세션x
		 * 걍리턴
		 * 
		 * 세션0
		 * 
		 * email값과 idx값 가지고  zzim테이블가서 있는지 확인
		 * 있다 ->삭제
		 * 없다 ->추가
		 * 
		 * 
		 */
		MemberVO mvo = (MemberVO)ses.getAttribute("loginUser");
		Map<String,Integer>map = new HashMap<>();
		String id=idx[0];
		if(mvo==null)
		{
			map.put("result", -1); //로그인x
			return map;
		}
		else
		{
			log.info(mvo.getEmail()+"이메일 없음?  아이디는 업냐 "+id);
			Zzim_TrailerVO Ztv=trailer_Service.ZtVo(mvo.getEmail(), id);
			if(Ztv!=null)
			{
				int del_result=trailer_Service.del_Zzim(mvo.getEmail(), id);
				if(del_result>0) {
					map.put("result",0); //로그인되있고 찜중이라 삭제
					return map;	
				}
				else
				{
					map.put("result",-2); //로그인되있고 찜중인데 삭제 실패
					return map;	
				}
				
			}
			else
			{
				int input_result=trailer_Service.insert_ZzimT(mvo.getEmail(),id);
				if(input_result>0) {
					map.put("result",1); //로그인되있고 찜 아니여서 추가
					return map;
				}
				else
				{
					map.put("result",-2); //로그인되있고 찜 아닌데  추가실패
					return map;
				}
			}
			
		}
		
	
	
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
