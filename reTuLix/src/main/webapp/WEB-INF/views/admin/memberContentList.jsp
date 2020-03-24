<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/admin/adminTop"/>
<!-- ----------------------------------------------------------- -->

<%--모달 css --%>
<style>
.adm-modal {
	display: none;
	position: absolute;
	z-index: 10009;
	padding-top: 100px;
	padding-left: 200px; top : 0;
	left: 0;
	width: auto;
	height: 600px;
	overflow: none;
	background-color: rgba(0, 0, 0, 0);
	top: 0;
}


#reviewModal .modal-layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
}
</style>

<!-- ------------------------------------------------------- -->
<div class='box adm-title adm-bg-035'>
		<h2 class='head'><i class="fas fa-magic" style='margin-right:0.5em;'></i>[${memberContent[0].email}] 의 업로드 목록</h2>
</div>
<div class="outer">
<div class="tableContainer">
	<form action="contentSearch" name="searchForm" method="GET">
		<div class='box right'>
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
	<table class='adm-table'>
		<thead>
			<tr>
				<th>IDX</th>
				<th>이메일</th>
				<th>이름</th>
				<th>영화명</th>
				<th>리뷰제목</th>
				<%-- <th>소개</th> --%>
				<%-- <th>수정</th> --%>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="member" items="${memberContent}">
				<tr>
					<td><a href="showReview?idx=${member.idx}">${member.idx}</a></td>
					<td>${member.email}</td>
					<td>${member.name}</td>
					<td>${member.trailerTitle}</td>
					<td>${member.reviewTitle}</td>
			<%-- <c:if test='${function:length(member.info)<=40}'>	<!-- 너무길면 줄이기 -->
					<td title='${member.info}'>${member.info}</td>
			</c:if>
			<c:if test='${function:length(member.info)>40}'>
					<td title='${member.info}'>${function:substring(member.info,0,40)}...</td>
			</c:if> --%>
					<%-- <td><i class="fa fa-edit"></i></td> --%>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class='box'>
		${pageNavi}
	</div>
</div>
</div>


<!-- 회원콘텐츠 세부정보 팝업 -->
<div id='reviewModal' class='adm-modal'>
	<div class='box' style='background-color:#000;'>
	<div class='box adm-title adm-bg-035'>
		<div class='box adm-title'>
			<label>영화명</label>
			<span>영화제목 들어가야함</span>
		</div>
	</div>
		<div class='box'>
			<div class='box adm-title'>
				<label>제  목</label>
				<span>리뷰제목 들어가야함</span>
			</div>
			<div class='box adm-title'>
				<label>내  용</label>
				<div>
					영화내용 들어가야함
				</div>
			</div>
			<div class='box'>
				<label>좋아요 : </label>
				<span>a</span>
				<label>조회수 : </label>
				<span>a</span>
				<label>찜 : </label>
				<span>a</span>
			</div>
			<div class='box'>
				<label>영상 경로 : </label>
				<span>영상 url 들어갈 자리</span>
			</div>
		</div>
		<div class='modal-layer'></div>
	</div>

</div>
<!-- -------------------------------------------------------------- -->

<%--스크립트 시작 --%>
<script>


//링크 누르면 영상 세부정보 보여주기
function popup(idx){
	
	
	$("#reviewModal").css("display","block");
}

//ajax
$.ajax({
	type="POST",
	url="admin/contentDesc",
	dataType:"text",
	success:function(res){
		alert(res.data);
	},
	error:function(err){
		err.status();
	}
})



goSearch= function(){
	searchForm.submit();
}
</script>

<c:import url="/foot"/>