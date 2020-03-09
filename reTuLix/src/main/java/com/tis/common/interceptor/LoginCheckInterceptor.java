package com.tis.common.interceptor;

import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.tis.retulix.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginCheckInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession ses=request.getSession();
		MemberVO member=(MemberVO)ses.getAttribute("loginUser");
		if(member!=null) return true;

		//유효성 통과 못했을 경우
		request.setAttribute("msg", "로그인 후 서비스 이용이 가능합니다.");
		request.setAttribute("loc", request.getContextPath()+"/");
		
		String viewName="/WEB-INF/views/message.jsp";
		RequestDispatcher disp=request.getRequestDispatcher(viewName);
		disp.forward(request, response);
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

}
