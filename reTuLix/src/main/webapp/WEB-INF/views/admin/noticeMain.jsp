<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/admin/adminTop.jsp"/>
<div class='box'>
	<h1 class='head'>공지사항</h1>
</div>
<div class='outer'>

	<div class='tableContainer'>
	<form action="noticeSearch.do" name="searchForm" method="POST">
		<div class='box right'>
			<select class='' name="selectBox">
				<option value='idx'>글번호</option>
				<option value='title'>제목</option>
			</select>
			<input type='text' name="searchInput" class=''>
			<button type='button' onclick='goSearch()'>검색</button>
			<%-- name파라미터 나중에 관리자 아이디 받아와야함 --%>
			<a href='noticeInsert.do?name=admin' class='button' style='margin-left:10px;'>등 록</a>
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
			<core:forEach var='list' items='${noticeList}'>
				<tr>
					<td>${list.idx }</td>
					<td><a href='noticeView.do?idx=${list.idx}'>${list.title}</a></td>
					<td>${list.name}</td>
					<td>${list.wdate }</td>
					<td>${list.click }</td>
					<td><a href='noticeEdit.do?idx=${list.idx}'><i class="fa fa-edit"></i></a></td>
					<td><a href='javascript:goDel(${list.idx})'><i class="fa fa-trash"></i></a></td>
				</tr>
			</core:forEach>
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
		location.href="noticeDelete.do?idx="+idx;		
	}
	else {
		alert("삭제가 취소되었습니다");
		return;
	}
}

</script>
<jsp:include page="/foot.jsp"/>