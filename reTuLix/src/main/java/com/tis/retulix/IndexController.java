package com.tis.retulix;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tis.admin.service.NoticeService;
import com.tis.common.CommonUtil;
import com.tis.common.model.PagingVO;
import com.tis.retulix.domain.NoticeVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class IndexController {
	
	@Inject
	private NoticeService noticeService;
	@Inject
	private CommonUtil util;
	
	@RequestMapping("/top")
	public String top() {
		return "top";
	}
	
	@RequestMapping("/foot")
	public String foot() {
		return "foot";
	}

	@RequestMapping("/user/index")
	public String home(Model model, HttpSession ses) {
		return "index";	//WEB-INF/spring/views/index.jsp
	}
	
	/* 공지사항 입장 */
	@RequestMapping("/user/notice")
	public String goNotice(Model m, HttpServletRequest req,
			@ModelAttribute("paging")PagingVO paging) {
		
		paging= new PagingVO(noticeService.getTotalNotice(), paging.getCpage(), 10, 5);
		List<NoticeVO> noticeList= noticeService.getNoticeList(paging);
		//유효성체크
		if(noticeList.size()<=0) {
			util.addMsgBack(m, "목록을 찾을 수 없습니다 [result:none]");
			return "javascript:history.back()";
		}
		
		m.addAttribute("noticeList", noticeList);
		m.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "user/notice", false));
		
		return "admin/userNoticeMain";
	}
	/* 공지사항 검색 */
	@GetMapping("/user/noticeSearch")
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
		model.addAttribute("pageNavi", paging.getPageNavi(req.getContextPath(), "user/noticeSearch", false));
		
		return "admin/userNoticeSearch";
	}
	/* 공지사항 보기 */
	@RequestMapping("user/noticeView")
	public String goNoticeView(@ModelAttribute("notice") NoticeVO notice, Model model) {
		noticeService.updateClick(String.valueOf(notice.getIdx()));
		notice= noticeService.getNoticeByIdx(String.valueOf(notice.getIdx()));
		log.info("NoticeVO: "+notice);
		
		model.addAttribute("notice", notice);
		return "admin/userNoticeView";
	}
}
