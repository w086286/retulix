package com.tis.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.main.service.UserRegService;
import com.tis.retulix.domain.MemberVO;

@Controller
public class UserRegController {

	@Resource(name = "UserReg")
	private UserRegService reg_service;

	@RequestMapping("/signup")
	public String signup() {
		return "login/SignUp";
	}
    //이메일 중복 체크
	@RequestMapping(value = "checkemail", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")

	public @ResponseBody Map<String, Integer> emailCheck(@RequestParam("inputemail") String email, Model m) {
		int userEmail = reg_service.userEmailCheck(email);
		System.out.println("userEmail=" + userEmail);
		System.out.println("email=" + email);
		Map<String, Integer> map = new HashMap<>();
		map.put("userEmailCheck", userEmail);
		return map;
	}
	//회원 가입 insert
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String userRegister(@ModelAttribute MemberVO user, Model m) {

		int n = this.reg_service.userRegister(user);
		String str = (n > 0) ? "회원가입 성공" : "회원가입 실패";
		String loc = (n > 0) ? "/retulix" : "javascript:history.back()";

		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		return "message";
	}

}
