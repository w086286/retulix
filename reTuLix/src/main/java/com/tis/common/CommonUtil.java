package com.tis.common;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

/**메세지 반환받아 유저에게 알림 보여주고 페이지 이동시키는 클래스*/

@Component	//어떤 기능을 가지고 있는 객체. MVC의 어떤 범주에 속하지 않을 경우 component annotation 부여
public class CommonUtil {
	
	public String addMsgLoc(Model m, String msg, String loc) {
		m.addAttribute("msg", msg);
		m.addAttribute("loc", loc);
		return "message";
	}

	public String addMsgBack(Model m, String msg) {
		m.addAttribute("msg", msg);
		m.addAttribute("loc", "javascript:history.back()");
		return "message";
	}
}
