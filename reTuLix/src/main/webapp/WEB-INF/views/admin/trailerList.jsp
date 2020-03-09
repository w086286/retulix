<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/admin/adminTop.jsp"/>
<!-- ------------------------------------------------------- -->
<!-- api -->
<script src='./js/api.js'></script>
<!-- -------- -->

<div class='box'>
		<h2 class='head'>컨텐츠 목록</h2>
</div>
<form action="trailerSearch.do" name="searchForm" method="POST">
	<div class='box'>
		<select class='' name="selectBox">
			<option value='idx'>번호</option>
			<option value='title'>제목</option>
		</select>
		<input type='text' name="searchInput" class=''>
		<button type='button' onclick='goSearch()'>검색</button>
	</div>
</form>
<!-- ----------------------------------------------------- -->
<div class="outer">
	<div class='tableContainer'>
		<table class="table">
			<thead>
				<tr>
					<th>#</th>
					<th>인덱스</th>
					<th>제목</th>
					<th>감독</th>
					<th>개봉일</th>
					<th>소개</th>
					<th>삭제</th>
				</tr>
			</thead>
			
			<tbody>
				<core:forEach var="list" items="${listTrailer}">
					<tr>
						<td><a href='trailerEdit.do?idx=${list.idx}'><i class="fa fa-edit"></i></a></td>
						<!-- 컨텐츠 세부내용 보기는 저쪽으로 링크 이어줄거 -->
						<td><a href='movieView.do?idx=${list.idx}'>${list.idx}</a></td>
						<td>${list.title}</td>
						<td></td>
						<td>개봉일</td>
				<core:if test='${function:length(list.title)<=40}'>	<!-- 너무길면 줄이기 -->
						<td title='${list.title}'>영화소개</td>
				</core:if>
				<core:if test='${function:length(list.title)>40}'>
						<td title='${list.title}'>${function:substring(list.title,0,40)}...</td>
				</core:if>
						<td><a href='javascript:goDel("${list.idx}")'><i class="fa fa-trash"></i></a></td>
					</tr>
				</core:forEach>
			</tbody>
		</table>
		<div class='box'>
			${pageNavi}
		</div>
	</div>
</div>

<script>

function goSearch() {
	searchForm.submit();
}
function goDel(idx){
	var check= confirm("["+idx+"] 항목을 정말로 삭제하시겠습니까?");
	if(check){
		location.href="trailerDelete.do?idx="+idx;		
	}
	else {
		alert("삭제가 취소되었습니다");
		return;
	}
}

</script>


<jsp:include page="/foot.jsp" />
