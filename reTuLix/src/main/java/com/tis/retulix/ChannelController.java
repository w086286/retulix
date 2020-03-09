package com.tis.retulix;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChannelController {
	
	/**내 채널 진입*/
	@RequestMapping("/user/channel")
	public String chDoor() {
		return "channel/chDoor";
	}

}
