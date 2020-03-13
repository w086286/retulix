<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/top" />

<div class="imgAlign">
<h3 align="left" style="color: lavender">드라마</h3>
<c:forEach var="onDrama" items="${onDramaTitle}"> 

	<a href="movieView?idx=${onDrama.idx}">
	<img src="${pageContext.request.contextPath}/resources/poster/${onDrama.title }.png"
		height="230px" width="158px" ></a>

</c:forEach>
</div>

<section id="about" class="two">
<!--추천 영상-->
			<div class="container-fluid" id="cslide">
				<h3 align="left" style="color: lavender">추천 영상</h3>
				<div class="demo">
					<div class="row">
						<ul id="content-slider" class="content-slider">
			<c:forEach var="reList" items="${reListTitle}">		
			 <div class="col-6 col-lg-2 animate-in-down"><a href="movieView?idx=${reList.idx}">
			 <img src="${pageContext.request.contextPath}/resources/poster/${reList.title}.png" 
			 class="center-block img-fluid my-3" height="230px" width="158px"></a></div>
   			 </c:forEach>

						</ul>
					</div>
				</div>
			</div>
			
			<div class="container-fluid" id="cslide">
				<h3 align="left" style="color: lavender">누구누구가 찜한 영상</h3>
				<div class="demo">
					<div class="row">
						<ul id="content-slider" class="content-slider">
			<c:forEach var="zzimList" items="${zzimListTitle}">		
			 <div class="col-6 col-lg-2 animate-in-down"><a href="movieView?idx=${zzimList.idx}">
			 <img src="${pageContext.request.contextPath}/resources/poster/${zzimList.title}.png" 
			 class="center-block img-fluid my-3" height="230px" width="158px"></a></div>
   			 </c:forEach>

						</ul>
					</div>
				</div>
			</div>
</section>
<c:import url="/foot" />