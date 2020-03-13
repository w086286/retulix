package com.tis.retulix;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.retulix.service.UserRegService;



@Controller
public class UserRegController {
	
	/* @Autowired UserRegService userregservice; */
		@Resource(name="UserReg")
		private UserRegService reg_service;
		
		@RequestMapping("/signup")
		public String signup() {
			return "main/SignUp";
		}
		
	/*
	 * @Resource(name="UserReg") private UserRegService reg_service;
	 */
	
	@RequestMapping(value= "checkemail", method= RequestMethod.GET,produces = "application/json; charset=UTF-8")
	
	public @ResponseBody Map<String, Integer> emailCheck(@RequestParam("inputemail") String email, Model m) {
		int userEmail=reg_service.userEmailCheck(email);
		/* m.addAttribute("userEmailCheck", userEmail); */
		System.out.println("userEmail="+userEmail);
		System.out.println("email="+email);
		/* System.out.println("m="+m); */
		Map<String, Integer> map=new HashMap<>();
		map.put("userEmailCheck", userEmail);
		return map; /*reg_service.userEmailCheck(email); */
	}
	
	

}
