package com.tis.retulix;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	
	@RequestMapping("/top")
	public String top() {
		return "top";
	}

	@RequestMapping("/main")
	public String main() {
		return "main/main";
	}
	
	@RequestMapping("/foot")
	public String foot() {
		return "foot";
	}

	@RequestMapping("/user/index")
	public String home(Model model, HttpSession ses) {
		return "index";	
	}
}
