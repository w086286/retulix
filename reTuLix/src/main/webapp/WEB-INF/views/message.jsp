<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	<!-- 제어문 사용하는 tag라이브러리 -->

<!-- jstl의 core태그 라이브러리를 이용하여 제어문 사용 >> c:if test="조건문"-->
<c:if test="${msg!=null}">
	<!-- msg가 null이 아니라면 알림창 보여주고 이동 -->
	<script>
		alert("${msg}");
		location.href="${loc}";
	</script>
</c:if>
<c:if test="${msg==null}">
	<!-- msg가 null이면 페이지만 이동 -->
	<script>
		location.href="${loc}";
	</script>
</c:if>