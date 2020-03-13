<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/admin/adminTop"/>

<div class='box' style='height:150px; background-color:lightgray;'>
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
			<%-- name파라미터 나중에 관리자 아이디 받아와야함 --%>
			<a href='noticeInsert' class='button' style='margin-left:20px; background-color:#d11;'>등 록</a>
		</div>
	</form>
		<table style='margin-bottom:0.5em;'>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>수정</th>
					<th>삭제</th>
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
					<td><a href='noticeEdit?idx=${list.idx }'><i class="fa fa-edit"></i></a></td>
					<td><a href='javascript:goDel(${list.idx})'><i class="fa fa-trash"></i></a></td>
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
function goDel(idx){
	var check= confirm("공지사항을 정말로 삭제하시겠습니까?");
	if(check){
		location.href="noticeDelete?idx="+idx;		
	}
	else {
		alert("삭제가 취소되었습니다");
		return;
	}
}

</script>
<c:import url="/foot"/>