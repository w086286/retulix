<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.tis.retulix.domain.*"%>

<%
	String email=request.getParameter("email");
	String pwd=request.getParameter("pwd");
	String saveId=request.getParameter("saveId");
	
	if(email==null || pwd==null || email.trim().isEmpty() || pwd.trim().isEmpty()) {
		%><script>
			alert("잘못된 경로입니다");
			location.href="/login.jsp";
		</script><%
		return;
	}

	%> <jsp:useBean id="dao" class="common.persistence.LoginDAOMyBatis" scope="session" /> <%
	
	MemberVO user=dao.loginCheck(email, pwd);
	if(user!=null){
		session.setAttribute("loginUser", user);

		Cookie ck=new Cookie("saveId", email);
		if(saveId!=null){
			ck.setMaxAge(7*24*60*60);
			ck.setPath("/");
		} else {
			ck.setMaxAge(0);
			ck.setPath("/");
		}
		response.addCookie(ck);
		%>
		<script>
			location.href="../index.jsp";
		</script>
		<%
	}
%>