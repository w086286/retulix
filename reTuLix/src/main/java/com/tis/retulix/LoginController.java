package com.tis.retulix;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tis.common.CommonUtil;
import com.tis.common.model.NotUserException;
import com.tis.main.service.MainService;
import com.tis.retulix.domain.MemberVO;
import com.tis.retulix.domain.SubsVO;
import com.tis.retulix.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LoginController {
	
	@Autowired	//변수를 자료유형으로 자동으로 넣어줌
	private CommonUtil util;
	
	@Inject		//자료유형으로 주입
	private UserService userService;
	
	@Resource(name="mainSvc")
	private MainService mainservice;

	/**로그인 화면 진입: "localhost:9090/retulix/"*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(Model model) {
		return "login/login";
	}
	
	/**로그인 정보 체크*/
	@RequestMapping("/login")
	public String loginCheck(
			@RequestParam(name="email", defaultValue="") String email,
			@RequestParam(defaultValue="") String pwd,
			@RequestParam(defaultValue="false") boolean saveId,
			@RequestParam(defaultValue="false") boolean saveLogin,
			Model model, HttpSession ses, HttpServletResponse res
			) throws NotUserException {
		//log.info(email+"/"+pwd+"/"+saveId+"/"+saveLogin);
		
		//[2]유효성 체크
		if(email.trim().isEmpty()||pwd.isEmpty()) {
			return "redirect:/";	//로그인 페이지로 이동
		}
		
		//[3]로직처리: 로그인 인증처리 메소드 호출
		MemberVO loginUser=userService.isLoginOk(email, pwd);
		if(loginUser!=null) {
			//1)세션에 key-value 저장
			ses.setAttribute("email", email);
			ses.setAttribute("loginUser", loginUser);
			ses.setAttribute("userMode", loginUser.getState());
			//log.info(loginUser);
			
			//2)아이디 저장 처리
			Cookie ckEmail=new Cookie("uid", loginUser.getEmail());	
			if(saveId) ckEmail.setMaxAge(7*24*60*60);					//아이디 저장 7일간 유효
			else ckEmail.setMaxAge(0);									//아이디 저장 안했을 경우(F) 쿠키 유효기간 삭제
			
			ckEmail.setPath("/");		//어디서든 쿠키에 접근할 수 있도록 "/"로 경로 처리
			res.addCookie(ckEmail);		//response에 쿠키 추가
		}
		
		//구독자 리스트
		List<MemberVO> email_subs = mainservice.subscribeList(email);
		if (email_subs != null) {

			ses.setAttribute("email_subs", email_subs);
		}
		return "redirect:main";

		//[4]UserServiceImpl가서 나머지 구현:findUserByUserid()
	}
	
	/**로그아웃 처리*/
	@RequestMapping("/logout")
	public String logout(HttpSession ses) {
		ses.invalidate();	//세션 무효화
		return "redirect:/";	//로그인 페이지로 이동
	}
	
	/**접근 권한 처리
	 * GetMapping: get방식의 요청만 받고자 할 때 
	 * PostMapping: post방식의 요청만 받고자 할 때 */
	@GetMapping("/user/mypage")
	public String showMyPage(Model m, HttpSession ses) {
		return "member/mypage";	//WEB-INF/views/member/mypage.jsp 찾아감
	}
	
}
