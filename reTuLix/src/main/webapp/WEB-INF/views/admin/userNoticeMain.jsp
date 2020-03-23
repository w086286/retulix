<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/top"/>

<div class='box adm-title adm-bg-035' >
	<h1 class='head'>공지사항</h1>
</div>
<div class='outer'>
	<div class='tableContainer'>
	<form action="noticeSearch" name="searchForm" method="GET">
		<div class='box right'>
			<select class='' name="selectBox">
				<option value='idx'>글번호</option>
				<option value='title'>제목</option>
			</select>
			<input type='text' name="searchInput" class=''>
			<button type='button' onclick='goSearch()'>검색</button>
		</div>
	</form>
		<table class='adm-table' style='margin-bottom:0.5em;'>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var='list' items='${noticeList}'>
				<tr>
					<td>${list.idx }</td>
					<td><a href='noticeView?idx=${list.idx}'>${list.title}</a></td>
					<td>${list.name}</td>
					<td>${list.wdate }</td>
					<td>${list.click }</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class='box'><!-- 페이지 -->
			${pageNavi}
		</div>
	</div>
</div>

<script>
function goSearch(){
	searchForm.submit();
}


</script>
<c:import url="/foot"/>