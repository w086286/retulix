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

import com.tis.retulix.domain.Review_ViewVO;
import com.tis.retulix.domain.Trailer_ViewVO;
import com.tis.retulix.domain.Zzim_TrailerVO;
import com.tis.trailer.service.Trailer_Service;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/user")
public class Trailer_viewController {

	@Inject
	private CommonUtil util;
	
	@Inject
	private Trailer_Service trailer_Service;
	
	@RequestMapping(value="/showReview",method=RequestMethod.GET)
	public String showReview(@RequestParam("idx") String idx,Model m,HttpSession ses) {
		Review_ViewVO RevVO= trailer_Service.selectOneReview(idx);
		List<Review_ViewVO> arr = trailer_Service.selectMultiReview(idx);
		log.info("배열오냐"+arr);
		String tmp=RevVO.change(RevVO.getInfo());
		//관련 영상 랜덤 몆개?
		
		String tmp2 =RevVO.change_title(RevVO.getTitle());
		Trailer_ViewVO vo = trailer_Service.selectOne(RevVO.getT_idx());
		MemberVO memberVo = trailer_Service.select_who_upload(RevVO.getEmail());
		//log.info("테스트리뷰"+vo);
		RevVO.setInfo(tmp);
		RevVO.setTitle(tmp2);
		m.addAttribute("review_multi",arr);
		m.addAttribute("member",memberVo);
		m.addAttribute("review",RevVO);
		m.addAttribute("trailer",vo);
		return "mList/review_repage";
	}
	@RequestMapping(value="/showMovie",method=RequestMethod.GET)
	public String showMovie(@RequestParam("idx") String idx,Model m,HttpSession ses) {
		
		Trailer_ViewVO vo = trailer_Service.selectOne(idx);
		List<Review_ViewVO> rarr = trailer_Service.selectReview(vo.getIdx()); 
		//log.info("테스트리뷰"+rarr);
		List<Trailer_ViewVO> tarr = trailer_Service.selectPoster(vo.getIdx());
		
		MemberVO mvo = (MemberVO)ses.getAttribute("loginUser");
		if(mvo!=null)
		{
			Zzim_TrailerVO Ztv=trailer_Service.ZtVo(mvo.getEmail(),vo.getIdx());
			if(Ztv!=null)
			{
				m.addAttribute("m_info","true");
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
		List<Review_ViewVO> rarr = trailer_Service.selectReview(vo.getIdx());
		List<Trailer_ViewVO> tarr = trailer_Service.selectPoster(vo.getIdx());
		
		m.addAttribute("mvo",vo);
		m.addAttribute("arr",tarr);
		m.addAttribute("reviews",rarr);
		return "mList/repage";
	}
	
	
	@PostMapping("/ck_zzim")
	@ResponseBody
	public Map<String,Integer> zzim_chking(String [] idx,HttpSession ses) {
	
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
