<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/top" />

<div class="imgAlign">
	<h3 align="left" style="color: lavender">좋아요순 영상</h3>
	<c:forEach var="good" items="${goodTitle}">

		<a href="showMovie?idx=${good.idx}"> <img
			src="${pageContext.request.contextPath}/resources/poster/${good.title }.png"
			height="230px" width="158px"></a>

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
						<div class="col-6 col-lg-2 animate-in-down">
							<a href="showMovie?idx=${reList.idx}"> <img
								src="${pageContext.request.contextPath}/resources/poster/${reList.title}.png"
								class="center-block img-fluid my-3" height="230px" width="158px"></a>
						</div>
					</c:forEach>

				</ul>
			</div>
		</div>
	</div>
	<!-- 찜 영상 -->
	<div class="container-fluid" id="cslide">
		<c:if test="${zzimListSize ne 0}">
			<h3 align="left" style="color: lavender">${loginUser.name}님이찜한
				영상</h3>
		</c:if>
		<c:if test="${zzimListSize eq 0}">
		</c:if>
		<div class="demo">
			<div class="row">
				<ul id="content-slider" class="content-slider">
					<c:forEach var="zzimList" items="${zzimListTitle}">
						<div class="col-6 col-lg-2 animate-in-down">
							<a href="showMovie?idx=${zzimList.idx}"> <img
								src="${pageContext.request.contextPath}/resources/poster/${zzimList.title}.png"
								class="center-block img-fluid my-3" height="230px" width="158px"></a>
						</div>
					</c:forEach>

				</ul>
			</div>
		</div>
	</div>
</section>
<c:import url="/foot" />