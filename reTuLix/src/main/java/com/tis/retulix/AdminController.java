package com.tis.retulix;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tis.admin.domain.ContentVO;
import com.tis.admin.service.ContentService;
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
	private ContentService contentService;
	@Inject
	private CommonUtil util;
	
	/* jackson 라이브러리 사용할 jacksonmapper */
	ObjectMapper jacksonMapper= new ObjectMapper();
	
	@RequestMapping("/adminTop") 
	public String showAdminTop() {
		return "admin/adminTop";
	}
	
	@RequestMapping("/main")
	public String goAdminMain(HttpServletRequest req, Model m,
			@ModelAttribute("paging")PagingVO paging) {
		paging= new PagingVO(5, paging.getCpage(), 5, 5);
		
		List<TrailerVO> trailer= trailerService.getTrailer(paging);
		List<MemberVO> member= memberService.getMemberList(paging);
		List<ContentVO> content= contentService.getContent(paging);
		List<NoticeVO> notice= noticeService.getNoticeList(paging);
		
		m.addAttribute("trailerList", trailer);
		m.addAttribute("memberList", member);
		m.addAttribute("contentList", content);
		m.addAttribute("noticeList", notice);
		
		//트레일러 json데이터 보내기
		String jsonTrailer=null;
		try {
			jsonTrailer= jacksonMapper.writeValueAsString(trailer);
		}
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		if(jsonTrailer==null || jsonTrailer.isEmpty()) {
			util.addMsgBack(m, "잘못된 접근입니다");
		}
		m.addAttribute("jsonTrailer", jsonTrailer);
		
		return "admin/adminMain";
	}
	
	
/* 공지사항 ------------------------------------------------------------*/
	
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
		log.info("pagingtest"+paging);
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
	
/*/////공지사항 ------------------------------------------------------------*/
	
	
/* 회원관리 --------------------------------------------------------------- */
	
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

	/* 회원 검색 */
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
	/* 특정회원이 등록한 컨텐츠 */
	@GetMapping("memberContent")
	public String goContentByEmail(@ModelAttribute("paging")PagingVO paging,
			@RequestParam(defaultValue="")String email,
			HttpServletRequest req, Model m) {
		paging= new PagingVO(contentService.getTotalContentByEmail(email), paging.getCpage(),10,5);
		
		List<ContentVO> arr= contentService.getContentByEmail(paging, email);
		/* 
			sql 호출 메소드에서 매개변수를 2개 넣고싶을때는
			xxxMapper.java 인터페이스 파일의 해당 메소드 매개변수에 
			(@Param("이름")자료형 변수명) annotation을 붙이면 해결할 수 있다.
			이렇게 넘긴 매개변수는 xxxMapper.xml 에서(실제 sql문을 작성할 때)
			#{이름.변수명} 으로 구분하여 붙일 수 있다.
		*/
		//유효성
		if(arr==null || arr.size()<=0) {
			return util.addMsgBack(m, "검색결과를 찾을 수 없습니다 [result : none]");
		}
		//리스트로 넘겨놓고 엘리먼트 하나만 불러오려고할때 memberContent.email 하면
		//넘버포맷익셉션 난다 반드시 인덱스를 붙여야한다 memberContent[0].email
		
		//idx로 회원의 특정한 리뷰 내용을 불러오기(세부내용 출력용)
		//contentService.getContentByIdx()
		
		
		m.addAttribute("memberContent", arr);
		m.addAttribute("paging", paging);
		m.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/memberContent", false));
		
		return "admin/memberContentList";
	}
	/* 특정회원의 리뷰idx정보 보여주기 */
	/*
	 * @RequestMapping("contentView") public String goContentView(Model m,
	 * 
	 * @RequestParam("idx")String idx) { ContentVO content=
	 * contentService.getContentByIdx(idx); log.info(content);
	 * 
	 * m.addAttribute("content", content); m.addAttribute("idx", content.getIdx());
	 * m.addAttribute("trailerTitle", content.getTrailerTitle());
	 * m.addAttribute("reviewTitle", content.getReviewTitle());
	 * m.addAttribute("info", content.getInfo());
	 * 
	 * String jsonStr=""; try {
	 * 
	 * jsonStr= jacksonMapper.writeValueAsString(content); } catch(Exception e) {
	 * e.printStackTrace(); } m.addAttribute("jsonStr", jsonStr); log.info(jsonStr);
	 * 
	 * return "admin/memberContentDesc"; }
	 */
	
	
/*////회원관리 --------------------------------------------------------------- */
	
/* 트레일러관리 ------------------------------------------------------------*/
	/* 트레일러 목록 */
	@RequestMapping("trailer")
	public String goTrailerList(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model m) {
		paging= new PagingVO(trailerService.getTotalTrailer(),paging.getCpage(), 10, 5);
		List<TrailerVO> arr= trailerService.getTrailer(paging);
		//log.info(arr);
		//유효성
		if(arr==null || arr.size()<=0) {
			return util.addMsgBack(m, "결과를 찾을 수 없습니다");
		}
		
		//받아온 리스트를 json으로 변환한다(외부라이브러리jackson)
		String jsonArr=null;
		
		try {
			jsonArr= jacksonMapper.writeValueAsString(arr);
		} catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		//log.info(jsonArr);
		
		m.addAttribute("listTrailer", arr);
		m.addAttribute("jsonData", jsonArr);
		m.addAttribute("paging", paging);
		m.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/trailer", false));
		
		return "admin/trailerList";
	}
	
	/* 트레일러 검색 */
	@GetMapping("trailerSearch")
	public String goNoticeSearch(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model m) {
		paging.setPageSize(10);
		paging.setPagingBlock(5);
		paging.setSelectBox(paging.getSelectBox());
		paging.setSearchInput(paging.getSearchInput());
		paging.setTotalCount(trailerService.getTotalSearchTrailer(paging));
		paging.init();
		log.info(paging);
		
		/* input값이 없으면 전체리스트 보여주기 */
		if(paging.getSelectBox()==null || paging.getSelectBox().trim().isEmpty()) {
			return "redirect:trailer";
		}
		if(paging.getSearchInput()==null || paging.getSearchInput().trim().isEmpty()){
			return "redirect:trailer";
		}
		
		List<TrailerVO> arr= trailerService.getSearchTrailer(paging);
		//유효성
		if(arr==null || arr.size()<=0) {
			return util.addMsgBack(m, "검색결과를 찾을 수 없습니다 [result : none]");
		}
		
		/* 받아온 데이터 json형태로 만들어 넘기기(jackson 라이브러리) */
		String jsonArr=null;
		try {
			jsonArr= jacksonMapper.writeValueAsString(arr);
		}
		catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		if(jsonArr==null || jsonArr.trim().isEmpty()) {
			return util.addMsgBack(m, "결과를 찾을 수 없습니다");
		}
		//log.info(jsonArr);
		
		m.addAttribute("paging",paging);
		m.addAttribute("pageNavi",paging.getPageNavi(req.getContextPath(), "admin/trailerSearch", false));
		m.addAttribute("searchTrailer",arr);
		m.addAttribute("jsonData", jsonArr);
		
		return "admin/trailerSearch";
	}
	
	/* 트레일러 등록(GET) */
	@GetMapping("/trailerInsert")
	public String goTrailerInsert(HttpSession session, Model model,
			@ModelAttribute("member")MemberVO member) {
		member= (MemberVO)session.getAttribute("loginUser");
		log.info(member);
		//유효성
		if(member.getState()!=99) {
			return util.addMsgLoc(model, "관리자가 아닙니다", "/index");
		}
		model.addAttribute("member", member);
		return "admin/trailerInsert";
	}

	/* 트레일러 등록(POST) */
	@PostMapping("/trailerInsert")
	public String trailerInsert(HttpSession session, Model model,
			@ModelAttribute("trailer")TrailerVO trailer,
			@ModelAttribute("member")MemberVO member) {
		log.info(trailer);
		String seq= trailerService.increaseSeq();
		member=(MemberVO)session.getAttribute("loginUser");
		trailer.setNum(seq);
		trailer.setIdx(trailer.getDivi()+trailer.getGenre()+trailer.getNum());
		trailer.setUrl(".");
		trailer.setEmail(member.getEmail());
		int n=trailerService.insertTrailer(trailer);
		log.info(member);
		
		String msg= (n>0)?"트레일러가 등록되었습니다":"트레일러 등록 실패";
		String loc= (n>0)?"trailer":"javascript:history.back()";
		
		return util.addMsgLoc(model, msg, loc);
	}
	
	/* 트레일러 수정(GET) */
	@GetMapping("/trailerEdit")
	public String goTrailerEdit(@ModelAttribute("trailer")TrailerVO trailer, Model m) {
		trailer= trailerService.getTrailerByIdx(trailer.getIdx());
		//log.info("editGet: "+trailer);
		
		m.addAttribute("trailer", trailer);
		
		return "admin/trailerEdit";
	}
	/* 트레일러 수정(POST) */
	@PostMapping("/trailerEdit")
	public String trailerEdit(@ModelAttribute("trailer")TrailerVO trailer, Model m) {
		int n= trailerService.updateTrailer(trailer);
		//log.info("editPOST: "+trailer);
		
		String msg= (n>0)? trailer.getIdx()+" 의 내용이 수정되었습니다":"수정 실패";
		String loc= (n>0)? "trailer":"javascript:history.back()";
		
		m.addAttribute("trailer", trailer);
		
		return util.addMsgLoc(m, msg, loc);
	}
	
	/* 트레일러 삭제 */
	@RequestMapping("trailerDelete")
	public String goTrailerDelete(@RequestParam(defaultValue="")String idx, Model m) {
		if(idx.isEmpty()) {
			return util.addMsgBack(m, "대상을 찾을 수 없습니다");
		}
		
		int n= trailerService.deleteTrailer(idx);
		
		String msg= (n>0)? idx+" 번 항목을 삭제하였습니다":"삭제 실패";
		String loc= (n>0)? "trailer":"javascript:history.back()";
		
		return util.addMsgLoc(m, msg, loc);
		
	}

/*////트레일러관리 ------------------------------------------------------------*/
	
/* 회원업로드 관리 -----------------------------------------------------*/
	
	/* 회원컨텐츠 목록 */
	@RequestMapping("/contents")
	public String goMemberContentList(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model m) {
		paging= new PagingVO(contentService.getTotalContent(), paging.getCpage(), 10, 5);
		log.info(paging);
		List<ContentVO> arr= contentService.getContent(paging);
		if(arr.size()<=0 || arr==null) {
			String msg="회원목록을 가져오는데 실패했습니다 [result:none]";
			String loc="admin/main";
			return util.addMsgLoc(m, msg, loc);
		}
		log.info(arr.size());
		
		
		
		m.addAttribute("listContent", arr);
		m.addAttribute("paging",paging);
		m.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "admin/contents", false));
		
		return "admin/memberAllContentList";
	}
	
	/* 검색한 회원컨텐츠 */
	@GetMapping("contentSearch")
	public String goContentSearch(@ModelAttribute("paging")PagingVO paging,
			HttpServletRequest req, Model m) {
		paging.setPageSize(10);
		paging.setPagingBlock(5);
		paging.setSelectBox(paging.getSelectBox());
		paging.setSearchInput(paging.getSearchInput());
		paging.setTotalCount(contentService.getTotalSearchContent(paging));
		paging.init();
		log.info(paging);
		
		/* input값이 없으면 전체리스트 보여주기 */
		if(paging.getSelectBox()==null || paging.getSelectBox().trim().isEmpty()) {
			return "redirect:contents";
		}
		if(paging.getSearchInput()==null || paging.getSearchInput().trim().isEmpty()){
			return "redirect:contents";
		}
		
		List<ContentVO> arr= contentService.getSearchContent(paging);
		//유효성
		if(arr==null || arr.size()<=0) {
			return util.addMsgBack(m, "검색결과를 찾을 수 없습니다 [result : none]");
		}
		

		
		m.addAttribute("paging",paging);
		m.addAttribute("pageNavi",paging.getPageNavi(req.getContextPath(), "admin/contentSearch", false));
		m.addAttribute("searchContent",arr);
		
		return "admin/memberContentSearch";
	}
	
	/*  리뷰idx정보 보여주기 */
	@RequestMapping("showReview")
	public String goShowReview(@RequestParam("idx")String idx) {
		return "redirect:../user/showReview?idx="+idx;
	}

/*////회원업로드 관리 -----------------------------------------------------*/	
}
