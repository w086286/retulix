<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/top"/>
<!-- admintop-------------------------------------------------------- -->
<div class='adm-title adm-bg-035' style='padding-bottom:0.3em;'>
	<div class="box">
		<div class="head" style='font-size:1.5em;'><h1><i class='fas fa-cogs'>&nbsp;&nbsp;Admin Page</i> </h1></div>
	</div>
	<div id="" class="box">
		<div class="left">
			<a href="${pageContext.request.contextPath}/admin/member" class='button'>회원정보</a> 
			<a href="${pageContext.request.contextPath}/admin/trailer" class='button'>트레일러</a> 
			<a href="${pageContext.request.contextPath}/admin/contents" class="button">회원업로드</a> 
			<a href="${pageContext.request.contextPath}/admin/notice" class="button">공지사항</a> 
			<!-- <a type="button" class="">결제내역</a> -->
		</div>
		<div class='right'>
			<a href='trailerInsert' id='trailerInsert' class='button' 
			style='margin-left:2em; background-color:#d00; font-weight:bolder;'>트레일러 등록</a>
		</div>
	</div>
</div>

