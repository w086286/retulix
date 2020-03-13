<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:import url="/admin/adminTop"/>

<!-- -------------------------------------------------------- -->

<div class='box'>
	<h1 class='head'>회원정보 수정 - 결과</h1>
</div>

<div class='outer'>
	<div class='tableContainer'>
		<table class='table'>
			<tr>
				<th>#</th>
				<th>기존</th>
				<th><b> → </b></th>
				<th>변경</th>
			</tr>
			<tr>
				<td>이름</td>
				<td>${oldMember.name }</td>
				<td><b> → </b></td>
				<td>${member.name }</td>
			</tr>
			<tr>
				<td>포인트</td>
				<td>${oldMember.point }</td>
				<td><b> → </b></td>
				<td>${member.point }</td>
			</tr>
			<tr>
				<td>상태</td>
				<td>${oldMember.stateStr }</td>
				<td><b> → </b></td>
				<td>${member.stateStr}</td>
			</tr>
		</table>		
	</div>
	<div class='box'>
		<button type='button' class='button' onclick='goMemberList()'>목록으로</button>
		<button type='button' class='button' onclick='goBack()'>이전으로</button>		
	</div>
	
</div>

<!-- -------------------------------------------------------- -->
<script>

function goMemberList() {
	location.href="memberList";
}
function goBack(){
	history.back();
}

</script>
<!-- -------------------------------------------------------- -->

<c:import url="/foot"/>