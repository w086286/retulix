package com.tis.retulix;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.codec.json.Jackson2JsonEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.tis.admin.service.MemberService;
import com.tis.admin.service.NoticeService;
import com.tis.admin.service.TrailerService;
import com.tis.common.CommonUtil;
import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.NoticeVO;
import com.tis.retulix.domain.TrailerVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	/* 주입 */
	@Inject
	private NoticeService noticeService;
	@Inject
	private MemberService memberService;
	@Inject
	private TrailerService trailerService;
	@Inject
	private CommonUtil util;
		
	@GetMapping("/adminTop")
	public String showAdminTop() {
		return "admin/adminTop";
	}
	
	@GetMapping("/main")
	public String goAdminMain() {
		return "admin/adminMain";
	}
	
	/* 공지사항 리스트화면 */
	@RequestMapping("/notice")
	public String goNotice(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model model) {
		paging= new PagingVO(noticeService.getTotalNotice(), paging.getCpage(), 10, 5);
		List<NoticeVO> noticeList= noticeService.getNoticeList(paging);
		//유효성체크
		if(noticeList.size()<=0) {
			util.addMsgBack(model, "목록을 찾을 수 없습니다 [result:none]");
			return "javascript:history.back()";
		}
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/notice", false));
		
		return "admin/noticeMain";
	}
	
	/* 공지사항작성페이지 들어가기(GET) */
	@GetMapping("/noticeInsert")
	public String goNoticeInsert(HttpSession session, Model model) {
		MemberVO member= (MemberVO)session.getAttribute("loginUser");
		//유효성
		if(member.getState()!=99) {
			return util.addMsgLoc(model, "관리자가 아닙니다", "/index");
		}
		model.addAttribute("name", member.getName());
		return "admin/noticeInsert";
	}
	/* 공지사항 작성후 등록(POST) */
	@PostMapping("/noticeInsert")
	public String insertNotice(@ModelAttribute("notice") NoticeVO notice, Model model) {
		log.info("NoticeVO="+notice);
		
		int n= noticeService.insertNotice(notice);
		
		return (n>0)? util.addMsgLoc(model, "공지사항이 성공적으로 등록되었습니다", "notice")
				: util.addMsgBack(model, "공지사항 등록 실패");
	}
	
	/* 공지사항 보기 */
	@RequestMapping("/noticeView")
	public String goNoticeView(@ModelAttribute("notice") NoticeVO notice, Model model) {
		notice= noticeService.getNoticeByIdx(String.valueOf(notice.getIdx()));
		log.info("NoticeVO: "+notice);
		
		model.addAttribute("notice", notice);
		return "admin/noticeView";
	}
	/* 공지사항 검색 */
	@GetMapping("/noticeSearch")
	public String goNoticeSearch(@ModelAttribute("notice")NoticeVO notice,
			@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model model) {
		paging.setPageSize(10);
		paging.setPagingBlock(5);
		paging.setSelectBox(paging.getSelectBox());
		paging.setSearchInput(paging.getSearchInput());
		paging.setTotalCount(noticeService.getTotalSearchNotice(paging));
		paging.init();
		//log.info(paging);
		
		//input값이 없을때 전체리스트를 보여준다
		if(paging.getSelectBox()==null || paging.getSelectBox().trim().isEmpty()){
			return "redirect:notice";
		}
		if(paging.getSearchInput()==null || paging.getSearchInput().trim().isEmpty()) {
			return "redirect:notice";
		}
		
		//유효성
		List<NoticeVO> arr= noticeService.getSearchNotice(paging);
		if(arr.size()<=0) {
			String msg="검색결과를 찾을 수 없습니다 [result : none]";
			return util.addMsgBack(model, msg);
		}
		
		model.addAttribute("selectNotice", arr);
		model.addAttribute("paging", paging);
		model.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/noticeSearch", false));
		
		return "admin/noticeSearch";
	}
	
	/* 공지사항 수정페이지 진입(GET) */
	@GetMapping("/noticeEdit")
	public String goNoticeEdit(@ModelAttribute("notice")NoticeVO notice, Model model) {
		
		notice= noticeService.getNoticeByIdx(String.valueOf(notice.getIdx()));
		log.info(notice);
		model.addAttribute("notice", notice);
		
		return "admin/noticeEdit";
			
	}
	/* 공지사항 수정(POST) */
	@PostMapping("/noticeEdit")
	public String updateNotice(@ModelAttribute("notice")NoticeVO notice, Model model) {
		
		int n= noticeService.updateNotice(notice);
		log.info("NoticeVO: "+notice);
		//notice= noticeService.getNoticeByIdx(String.valueOf(notice.getIdx()));
		
		model.addAttribute("notice", notice);
		
		String msg= (n>0)? "공지사항을 수정하였습니다":"수정 실패";
		String loc= (n>0)? "noticeView?idx="+notice.getIdx():"javascript:history.back();";
		
		return util.addMsgLoc(model, msg, loc);
	}
	
	/* 공지사항 삭제 */
	@RequestMapping("noticeDelete")
	public String deleteNotice(@ModelAttribute("notice")NoticeVO notice, Model model) {
		//log.info(notice);

		int n= noticeService.deleteNotice(String.valueOf(notice.getIdx()));
		String msg= (n>0)? notice.getIdx()+" 번 공지사항이 삭제되었습니다":"삭제 실패";
		String loc= (n>0)? "notice":"javascript:history.back()";
		
		return util.addMsgLoc(model, msg, loc);
	}
	
	/* 회원목록 가져오기 */
	@GetMapping("/member")
	public String goMemberList(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model model) {
		paging= new PagingVO(memberService.getTotalMember(), paging.getCpage(), 10, 5);
		List<MemberVO> arr= memberService.getMemberList(paging);
		if(arr.size()<=0 || arr==null) {
			String msg="회원목록을 가져오는데 실패했습니다 [result:none]";
			String loc="admin/main";
			return util.addMsgLoc(model, msg, loc);
		}
		
		model.addAttribute("listMember", arr);
		model.addAttribute("paging",paging);
		model.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/member", false));
		return "admin/memberList";
	}
	@GetMapping("memberSearch")
	public String goSearchMember(@ModelAttribute("member")MemberVO member,
			@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model model) {
		
		paging.setPageSize(10);
		paging.setPagingBlock(5);
		paging.setSelectBox(paging.getSelectBox());
		paging.setSearchInput(paging.getSearchInput());
		paging.setTotalCount(memberService.getTotalSearchMember(paging));
		paging.init();
		
		/* input값이 없으면 전체리스트 보여주기 */
		if(paging.getSelectBox()==null || paging.getSelectBox().trim().isEmpty()) {
			return "redirect:member";
		}
		if(paging.getSearchInput()==null || paging.getSearchInput().trim().isEmpty()){
			return "redirect:member";
		}
		
		List<MemberVO> arr= memberService.getSearchMember(paging);
		//유효성
		if(arr==null || arr.size()<=0) {
			return util.addMsgBack(model, "검색결과를 찾을 수 없습니다 [result : none]");
		}
		
		model.addAttribute("paging",paging);
		model.addAttribute("pageNavi",paging.getPageNavi(req.getContextPath(), "admin/memberSearch", false));
		model.addAttribute("searchMember",arr);
		
		return "admin/memberSearch";
	}
	/* 회원정보 수정 */
	@GetMapping("memberEdit")
	public String goMemberEdit(@ModelAttribute("member")MemberVO member, Model model) {
		member= memberService.getMemberByEmail(member.getEmail());	//옛날정보
		log.info("GET: "+member);
		
		model.addAttribute("member", member);
		return "admin/memberEdit";
	}
	@PostMapping("memberEdit")
	public String memberEdit(@ModelAttribute("member")MemberVO member, 
			Model model, HttpSession ses) {
		MemberVO oldMember=memberService.getMemberByEmail(member.getEmail());	//이게 구버전
		//log.info("old: "+oldMember);
		
		int n= memberService.updateMember(member);
		member=memberService.getMemberByEmail(member.getEmail());	//새 정보
		//log.info("new: "+member);
		
		ses.setAttribute("oldMemberInfo", oldMember);
		ses.setAttribute("newMemberInfo", member);
		
		String msg=(n>0)? member.getEmail()+" 님의 정보가 수정되었습니다":"수정 실패";
		String loc=(n>0)? "memberEditResult":"javascript:history.back()";
		
		return util.addMsgLoc(model, msg, loc);
	}
	
	/* 회원정보 수정결과 보여주기 */
	@RequestMapping("memberEditResult")
	public String goMemberEditResult(@ModelAttribute("member")MemberVO member,
			HttpSession ses, Model model) {
		MemberVO oldMember= (MemberVO)ses.getAttribute("oldMemberInfo");
		//log.info("oldSesInfo: "+oldMember);
		member= (MemberVO)ses.getAttribute("newMemberInfo");
		//log.info("newSesInfo: "+member);
		
		model.addAttribute("oldMember", oldMember);
		model.addAttribute("member", member);
		ses.removeAttribute("oldMemberInfo");
		ses.removeAttribute("newMemberInfo");
		//log.info("memberInfoDel : "+ ses.getAttribute("newMemberInfo"));
		return "admin/memberEditResult";
	}

	/* 회원 삭제 */
	@RequestMapping("memberDelete")
	public String goDeleteMember(@ModelAttribute("member")MemberVO member, Model model) {
		member= memberService.getMemberByEmail(member.getEmail());
		log.info(member);
		
		int n= memberService.deleteMember(member.getEmail());
		String msg= (n>0)? member.getEmail()+" 님의 정보가 삭제되었습니다":"회원 삭제 실패";
		String loc= (n>0)? "member":"javascript:history.back()";
		
		return util.addMsgLoc(model, msg, loc);
	}
	
	/* 트레일러 목록 */
	@RequestMapping("/trailer")
	public String goTrailerList(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model m) {
		log.info(paging);
		paging= new PagingVO(trailerService.getTotalTrailer(),paging.getCpage(), 10, 5);
		List<TrailerVO> arr= trailerService.getTrailer(paging);
		log.info(arr);
		//유효성
		if(arr==null || arr.size()<=0) {
			return util.addMsgBack(m, "결과를 찾을 수 없습니다");
		}
		
		//받아온 리스트를 json으로 변환한다(외부라이브러리jackson)
		String jsonArr=null;
		ObjectMapper jacksonMapper= new ObjectMapper();
		try {
			jsonArr= jacksonMapper.writeValueAsString(arr);
		} catch(Exception e) {
			e.printStackTrace();
		}
		log.info(jsonArr);
		
		m.addAttribute("listTrailer", arr);
		m.addAttribute("jsonData", jsonArr);
		m.addAttribute("paging", paging);
		m.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/trailer", false));
		
		return "admin/trailerList";
	}
	
	
	
	
	@GetMapping("/memberContents")
	public String goMemberContentList() {
		return "admin/memberAllContentList";
	}
	
}
