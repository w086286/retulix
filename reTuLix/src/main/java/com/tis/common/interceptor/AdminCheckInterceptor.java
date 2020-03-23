package com.tis.common.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.tis.retulix.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class AdminCheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession ses=request.getSession();
		MemberVO member=(MemberVO)ses.getAttribute("loginUser");
		if(member!=null) {
			//if(member.getState()==99) return true;
		}

		request.setAttribute("msg", "로그인 후 서비스 이용이 가능합니다.");
		request.setAttribute("loc", request.getContextPath()+"/index");
		
		String viewName="/WEB-INF/views/message.jsp";
		RequestDispatcher disp=request.getRequestDispatcher(viewName);
		disp.forward(request, response);
		return false;
	}
	
}
