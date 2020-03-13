<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/admin/adminTop.jsp"/>
<!-- ------------------------------------------------------- -->

<div class='box'>
	<h1 class='head'>컨텐츠 수정 [${trailer.title}]</h1>
</div>

<div class='box'>

	<form name='editForm' action='trailerEditPreview.do?idx=${trailer.idx}' method='POST' >
	<div class='box'>
		<span name='idx' class='button'>${trailer.idx}</span>
	</div>
	<div class='box'>
		<label>제  목</label>
		<input type='text' name='title' value='${trailer.title }'>
	</div>
	<div class='box'>
		<div class='left'>
			<label>감  독</label>
			<input type='text' name='director' value='감독'>	
			<label>개봉일</label>
			<input type='text' name='release' value='개봉일'>	
		</div>
		<div class='right'>
		</div>
	</div>
	<div class='box'>
		<label>소  개</label>
		<textarea name='info' style='resize: none; width: 95%; height: 15em; margin:0em 1em; overflow-x:auto;'><c:out value="영화소개"/></textarea>
	</div>
	<div class='box'>
		<label>포스터</label>
		<input type='file' name='img1'>	
	</div>
	<div class='box'>
		<label style='margin-right:11px;'>예  고</label>
		<input type='file' name='img1'>	
	</div>
	<div class='box right'>
		<button type='button' onclick='goPreview()'>미리보기</button>
		<button type='button' onclick='javascript:history.back()'>취  소</button>
	</div>
	</form>

</div><!-- /box outline -->

<script>
	function goPreview(){
		editForm.submit();
	}
</script>

<!-- ------------------------------------------------------- -->
<jsp:include page="/foot.jsp"/>