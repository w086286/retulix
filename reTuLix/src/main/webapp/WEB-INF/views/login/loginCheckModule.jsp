<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="common.domain.*" %>
<%
	MemberVO user=(MemberVO)session.getAttribute("loginUser");
	
	if(user==null){
		%>
		<script>
			alert("로그인 후 이용할 수 있습니다");
			history.back();
		</script>
		<%
		return;
	}
%>