<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>




<jsp:include page="/admin/adminTop.jsp"/>

<!-- -------------------------------------------------------- -->

<div class='outer'>
	<div class='left'>
	<!-- 컨텐츠 테이블 -->
	<table>
		<tr>
			<th colspan='3' style='text-align:right; padding-right:7em;'>Content</th>
			<th style='text-align:right;'><a href="trailerList.do">
				<i class="fa fa-info-circle"></i></a></th>
		</tr>
		<!-- 반복문 -->
	<core:forEach var='trailer' items='${trailerList}' begin='0' end='3'>
		<tr>
			<td>${trailer.idx}</td>
			<td>${trailer.title}</td>
			<td>감독</td>
			<td>개봉일</td>
		</tr>
	</core:forEach>
		<!-- ------ -->
		
	</table>
	<!-- ------ -->
	</div>
	<div class='right'>
	<!-- 회원관리 테이블 -->
	<table>
		<tr>
			<th colspan='3' style='text-align:right; padding-right:8em;'>회원</th>
			<th style='text-align:right;'><a href="memberList.do">
				<i class="fa fa-info-circle"></i></a></th>
		</tr>
		<!-- 반복문 -->
	<core:forEach var='member' items='${memberList}' begin='0' end='3'>
		<tr>
			<td>${member.email}</td>
			<td>${member.name}</td>
			<td>${member.age}</td>
			<td>${member.stateStr}</td>
		</tr>
	</core:forEach>
		<!-- ------ -->
		
	</table>
	<!-- ------ -->
	</div>
</div>
<div class='outer'>
	<div class='left'>
		<!-- 사용자컨텐츠 테이블 -->
		<table>
			<tr>
			<th colspan='3' style='text-align:right; padding-right:7em;'>회원업로드</th>
			<th style='text-align:right;'><a href="memberAllContent.do">
				<i class="fa fa-info-circle"></i></a></th>
			</tr>
			<!-- 반복문 -->
		<core:forEach var='userContent' items='${userContentList}' begin='0' end='3'>
			<tr>
				<td>${userContent.idx}</td>
				<td style='width:50%;'>${userContent.reviewTitle}</td>
				<td>${userContent.trailerTitle }</td>
				<td>${userContent.name }</td>
			</tr>
		</core:forEach>
			<!-- ------ -->
		</table>
		<!-- ------ -->
	</div>
	<div class='right'>
		<!-- 공지사항 테이블 -->
		<table>
			<tr>
			<th colspan='3' style='text-align:right; padding-right:7em;'>공지사항</th>
			<th style='text-align:right;'><a href="noticeMain.do">
			<i class="fa fa-info-circle"></i></a></th>
			</tr>
			<!-- 반복문 -->
		<core:forEach var='notice' items='${noticeList}' begin='0' end='3'>
			<tr>
				<td>${notice.idx }</td>
				<td style='width:50%;'>${notice.title }</td>
				<td>${notice.name }</td>
				<td>${notice.wdate }</td>
			</tr>
		</core:forEach>
			<!-- ------ -->
		</table>
		<!-- ------ -->
	</div>
</div>

<jsp:include page="/foot.jsp" />