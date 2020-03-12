package com.tis.retulix;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.channel.service.ChannelService;
import com.tis.common.CommonUtil;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.Stat_ViewVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/user")
public class ChannelController {
	
	@Inject
	private CommonUtil util;
	
	@Inject
	private ChannelService channelService;
	
	/**세션 정보 가져오기 모듈화하여 사용: chInfo 제외*/
	private String LoginUser(HttpSession ses, Model m) {
		//1)세션에서 로그인 회원 정보 추출
		MemberVO loginUser=(MemberVO)ses.getAttribute("loginUser");
		//2)유효성 체크
		if(loginUser==null) {
			return util.addMsgLoc(m, "로그인 후 서비스 이용이 가능합니다", "/login");
		}
		String email=loginUser.getEmail();
		return email;
	}
	
	/**[내 채널]진입*/
	@RequestMapping("/channel")
	public String chDoor() {
		return "/channel/chDoor";
	}

	/**[내 채널 메인]진입*/
	@RequestMapping("/chHome")
	public String chHome() {
		return "/channel/chHome";
	}
	
	/**[내 채널 관리]진입*/
	@GetMapping("/chStat")
	public String chStat(HttpSession ses, Model m) {
		String email=LoginUser(ses, m);
		
		Stat_ViewVO stat=channelService.showUserStat(email);
		//Stat_ViewVO statMax=channelService.showStatMax(email);
		List<Stat_ViewVO> reviewList=channelService.showUserReview(email);
		
		m.addAttribute("stat", stat);
		//m.addAttribute("statMax", statMax);	//맵퍼 syntax 해결하고 주석 풀기
		m.addAttribute("reviewList", reviewList);
		return "/channel/chStat";
	}

	/**[내 정보 관리]진입*/
	@RequestMapping(value="/chInfo", method=RequestMethod.GET)
	public String chInfo(HttpSession ses, Model m) {
		//1)세션에서 로그인 회원 정보 추출
		MemberVO loginUser=(MemberVO)ses.getAttribute("loginUser");
		//log.info(loginUser);
		
		//2)유효성 체크
		if(loginUser==null) return util.addMsgLoc(m, "로그인 후 서비스 이용이 가능합니다", "/login");
		
		MemberVO vo=channelService.showUserInfo(loginUser.getEmail());
		m.addAttribute("userInfo", vo);
		
		return "/channel/chInfo";
	}
	
	/**[내 정보 관리]정보 수정*/
	@PostMapping("/chInfo")
	@ResponseBody
	public Map<String, String> chInfoByAjax(HttpSession ses, Model m,
			@ModelAttribute MemberVO vo,	//ModelAttribute사용시 form에서 전달받은 모든 값을 자동으로 vo에 set해줌(단 vo의 변수와 form의 id값이 일치하는 것들에 한해서..)
			@RequestParam(name="originPwd", defaultValue="") String originPwd,	//기존 비밀번호
			@RequestParam(name="pwd", defaultValue="") String pwd,				//변경 비밀번호
			@RequestParam(name="pwdCheck", defaultValue="") String pwdCheck,	//변경 비밀번호 확인
			@RequestParam(name="age", defaultValue="") String age){
		
		//1)세션에 저장된 로그인 회원 정보 가져오기
		MemberVO loginUser=(MemberVO)ses.getAttribute("loginUser");
		vo.setEmail(loginUser.getEmail());
		//log.info(originPwd+"/"+pwd+"/"+pwdCheck);

		//2)반환할 map property 선언
		Map<String, String> map=new HashMap<>();
		
		//3)유효성 체크
		String checkPwd=null;
		if(!originPwd.equals(loginUser.getPwd())) checkPwd="noMatchOriginPwd";
		if(!pwd.equals(pwdCheck)) checkPwd="noMatchEditPwd";

		if(checkPwd!=null) {
			if(checkPwd.equals("noMatchOriginPwd")) map.put("msg", "현재 비밀번호와 일치하지 않습니다.");
			if(checkPwd.equals("noMatchEditPwd")) map.put("msg", "변경할 비밀번호를 동일하게 입력하세요.");
			map.put("result", "false");
		}
		//4)유효성 체크 통과했을 경우 result=="true" --> else로 가서 나머지 처리
		else{
			//비밀변호 변경 안할 경우
			if(pwd==null || pwd.trim().isEmpty()) {
				pwd=loginUser.getPwd();
			}else{
				map.put("pwdEdited", "pwdEdited");
			}
			vo.setPwd(pwd);
			//나이 변경 안할 경우
			if(age==null || age.trim().isEmpty() || age.equals(loginUser.getAge())) age=loginUser.getAge();

			int n=channelService.updateUserInfo(vo);
			map.put("msg", "회원정보가 성공적으로 수정되었습니다.");
			map.put("result", "true");
		}
		return map;
		
		//5)DB까지 정보 수정이 완료되었을 경우 ajax에서 화면 갱신 처리
	}

	/**[내 정보 관리]탈퇴*/
	@PostMapping("/userDrop")
	private String chInfoUserDrop(HttpSession ses, Model m,
			@RequestParam(name="originPwd", defaultValue="") String originPwd) {
		MemberVO loginUser=(MemberVO)ses.getAttribute("loginUser");
		String email=loginUser.getEmail();
		
		//유효성 체크
		if(!originPwd.equals(loginUser.getPwd())) return util.addMsgBack(m, "현재 비밀번호와 일치하지 않습니다.");
		
		int n=channelService.deleteUserInfo(email);
		if(n<0) return util.addMsgLoc(m, "탈퇴가 처리되지 않았습니다.", "/retulix/user/channel");
		
		return util.addMsgLoc(m, "성공적으로 탈퇴 처리되었습니다.", "/retulix/");
	}
	
	/**[내 정보 관리]회원 아이콘 변경*/
	//@PostMapping("/iconEdit")
	
	//CommonUtil 사용하여 유효성 체크시 반환값 주의
	/*if(!originPwd.equals(loginUser.getPwd())) {
		return util.addMsgBack(m, "현재 비밀번호와 일치하지 않습니다.");	//util값 자체를 반환
		
		//아래와 같이 반환하면 url이 이상하게 전송됨: http://localhost:9090/retulix/user/javascript:history.back().jsp
		util.addMsgBack(m, "현재 비밀번호와 일치하지 않습니다.");
		return "javascript:histroy.back()";
	}*/
}
