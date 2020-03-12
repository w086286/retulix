<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="myChannelHead">업로드한 영상</div>
<div class="chHomeHead">
	<div class="channelAlign">
		<select>
			<option value="조회수순">조회수순</option>
			<option value="좋아요순">좋아요순</option>
			<option value="업로드순">업로드순</option>
		</select>
	</div>
	<div class="channelSearch">
		<input placeholder="검색어를 입력하세요">
		<i class="fa fa-search"></i>
	</div>
</div>

<div class="chUploadList">
	<div class="myChannelHead">최근 업로드</div>
	<section id="about" class="two">
	<div class="container-fluid" id="cslide">
	<div class="demo">
	<div class="row">
		<ul id="mvs" class="content-slider">
			<c:forEach var="MOVIE" begin="1" end="10">		
			<div class="col-6 col-lg-2 animate-in-down">
				<a href="'+[movies[i]]+'">
				 <img src="${pageContext.request.contextPath}/resources/images/noUserIcon.png" class="center-block img-fluid my-3" height="230px">
				</a>
			</div>
			</c:forEach>
		</ul>
	</div>
	</div>
	</div>
	</section>
	
	<div class="myChannelHead">업로드 영상</div>
	
	<div class="myChannelHead">인기 영상</div>
</div>