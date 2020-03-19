<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/lightslider.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>

<section id="about" class="two">
<div class="container-fluid" id="cslide">
<div class="myChannelHead">최근 업로드</div>
<div class="demo">
<div id="history"></div>
<div class="row">
<ul id="content-slider" class="content-slider">
	<c:forEach var="zzimList" begin="1" end="10">
		<div class="col-6 col-lg-2 animate-in-down">
		<a href="movieView" style="color:white">
			<img src="${pageContext.request.contextPath}/resources/images/noUserIcon.png" class="center-block img-fluid my-3" height="230px" width="158px"><br>
			타이틀
		</a><br>
		업로드일
		</div>
	</c:forEach>		
</ul>
</div>
</div>
</div>
</section>