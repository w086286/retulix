package com.tis.retulix;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	
	@RequestMapping("/top")
	public void top() {
		
	}

	@RequestMapping("/foot")
	public void foot() {
		
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "index";	//WEB-INF/spring/views/index.jsp
	}
	
}