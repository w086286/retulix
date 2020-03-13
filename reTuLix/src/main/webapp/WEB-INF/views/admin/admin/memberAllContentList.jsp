<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/admin/adminTop.jsp"/>

<!-- ------------------------------------------------------- -->
<div class='box'>
		<h2 class='head'>회원 업로드 목록</h2>
</div>
<form action="memberContentSearch.do" name="searchForm" method="POST">
	<div class='box'>
		<select class='' name="selectBox">
			<option value='idx'>번호</option>
			<option value='email'>이메일</option>
			<option value='name'>이름</option>
			<option value='title'>제목</option>
		</select>
		<input type='text' name="searchInput" class=''>
		<button type='button' onclick='goSearch()'>검색</button>
	</div>
</form>
<!-- ----------------------------------------------------- -->
<div class="outer">
<div class="tableContainer">
	<table class='table'>
		<thead>
			<tr>
				<th>IDX</th>
				<th>이메일</th>
				<th>이름</th>
				<th>영화명</th>
				<th>리뷰제목</th>
				<th>소개</th>
				<th>작성일</th>
				<th>수정</th>
			</tr>
		</thead>
		<tbody>
			<core:forEach var="all" items="${listAllMemberContent}">
				<tr>
					<td>${all.idx}</td>
					<td>${all.email}</td>
					<td>${all.name}</td>
					<td>${all.trailerTitle}</td>
					<td>${all.reviewTitle}</td>
			<core:if test='${function:length(all.info)<=40}'>	<!-- 너무길면 줄이기 -->
					<td title='${all.info}'>${all.info}</td>
			</core:if>
			<core:if test='${function:length(all.info)>40}'>
					<td title='${all.info}'>${function:substring(all.info,0,40)}...</td>
			</core:if>
					<td>${all.wdate}</td>
					<td><i class="fa fa-edit"></i></td>
				</tr>
			</core:forEach>
		</tbody>
	</table>
	<div class='box'>
		${pageNavi}
	</div>
</div>
</div>
<!-- ----------------------------------------------------------------- -->
<script>

function goSearch() {
	searchForm.submit();
}

</script>

<jsp:include page="/foot.jsp"/>