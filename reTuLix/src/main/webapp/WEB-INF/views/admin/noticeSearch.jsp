<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/admin/adminTop"/>
<div class='box'>
	<h1 class='head'>공지사항 [검색어 - ${paging.searchInput}]</h1>
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
			<a href='noticeInsert.do' class='button' style='margin-left:10px; background:#111;'>등 록</a>
		</div>
	</form>
		<table style='margin-bottom:0.5em;'>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>		
					<th>수정</th>
					<th>삭제</th>		
				</tr>
			</thead>
			<tbody>
			<c:forEach var='list' items='${selectNotice}'>
				<tr>
					<td>${list.idx }</td>
					<td><a href='noticeView.do?idx=${list.idx}'>${list.title} &nbsp;<i class="fa fa-edit"></i></a></td>
					<td>${list.name}</td>
					<td>${list.wdate }</td>
					<td><a href='noticeEdit.do?idx=${list.idx}'><i class="fa fa-edit"></i></a></td>
					<td><a href='noticeDelete.do?idx=${list.idx}'><i class="fa fa-trash"></i></a></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class='box'>
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