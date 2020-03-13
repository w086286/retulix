<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/admin/adminTop"/>

<!-- ------------------------------------------------------- -->
<div class='box'>
		<h2 class='head'>회원 목록</h2>
</div>
<div class="outer">
<form action="memberSearch" name="searchForm" method="GET">
	<div class='box right'>
		<select class='' name="selectBox">
			<option value='email'>이메일</option>
			<option value='name'>이름</option>
			<option value='state'>회원상태</option>
		</select>
		<input type='text' name="searchInput" class=''>
		<button type='button' onclick='goSearch()'>검색</button>
	</div>
</form>
<!-- ----------------------------------------------------- -->
<div class="tableContainer">
	<table class="table">
		<thead>
			<tr>
				<th>#</th>
				<th>이메일</th>
				<th>이름</th>
				<th>비밀번호</th>
				<th>나이</th>
				<th>포인트</th>
				<th>상태</th>
				<th>업로드</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${listMember}">
				<tr>
					<td><a href='memberEdit?email=${list.email}'><i class="fa fa-edit"></i></a></td>
					<td>${list.email}</td>
					<td>${list.name}</td>
					<td>${list.pwd}</td>
					<td>${list.age}</td>
					<td>${list.point}</td>
					<!-- 회원상태 문자로 출력 -->
					<td>${list.stateStr}</td>
					<td><a href='memberContent?email=${list.email}'><i class="fa fa-eye"></i></a></td>
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
function goSearch() {
	searchForm.submit();
}

</script>

<c:import url="/foot" />