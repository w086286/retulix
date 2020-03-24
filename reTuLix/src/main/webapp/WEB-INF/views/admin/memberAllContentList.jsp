<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/admin/adminTop"/>

<!-- ------------------------------------------------------- -->
<div class='box adm-title adm-bg-035'>
		<h2 class='head'><i class="fas fa-magic" style='margin-right:0.5em;'></i>회원 업로드 목록</h2>
</div>
<div class="outer">
<div class="tableContainer">
	<form action="contentSearch" name="searchForm" method="GET">
		<div class='box right'>
			<select class='' name="selectBox">
				<option value='idx'>번호</option>
				<option value='email'>이메일</option>
				<option value='name'>이름</option>
				<option value='title'>영화제목</option>
			</select>
			<input type='text' name="searchInput" class=''>
			<button type='button' onclick='goSearch()'>검색</button>
		</div>
	</form>
<!-- ----------------------------------------------------- -->
	<table class='adm-table'>
		<thead>
			<tr>
				<th>IDX</th>
				<th>이메일</th>
				<th>이름</th>
				<th>영화명</th>
				<th>리뷰제목</th>
				<!-- <th>소개</th> -->
				<th>작성일</th>
				<%--<th>수정</th> --%>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="all" items="${listContent}">
				<tr>
					<td><a href="showReview?idx=${all.idx}">${all.idx}</a></td>
					<td>${all.email}</td>
					<td>${all.name}</td>
					<td>${all.trailerTitle}</td>
					<td>${all.reviewTitle}</td>
			<%-- <c:if test='${function:length(all.info)<=40}'>	<!-- 너무길면 줄이기 -->
					<td title='${all.info}'>${all.info}</td>
			</c:if>
			<c:if test='${function:length(all.info)>40}'>
					<td title='${all.info}'>${function:substring(all.info,0,40)}...</td>
			</c:if> --%>
					<td>${all.wdate}</td>
					<%--<td><i class="fa fa-edit"></i></td> --%>
				</tr>
			</c:forEach>
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

<c:import url="/foot"/>