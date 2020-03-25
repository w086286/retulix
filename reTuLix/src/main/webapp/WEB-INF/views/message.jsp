<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	<!-- 제어문 사용하는 tag라이브러리 -->


<c:if test="${msg!=null}">
	
	<script>
		alert("${msg}");
		location.href="${loc}";
	</script>
</c:if>
<c:if test="${msg==null}">

	<script>
		location.href="${loc}";
	</script>
</c:if>