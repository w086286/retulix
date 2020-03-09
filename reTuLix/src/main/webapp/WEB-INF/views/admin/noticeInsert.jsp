<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/admin/adminTop.jsp"/>

<!-- ------------------------------------------- -->
<div class='box'>
	<h1 class='head'>공지사항 작성</h1>
</div>

<div class='box'>

<!-- 전송폼 -------------------------- -->
<form action='noticeInsertEnd.do' name='noticeInsertForm' method='POST'>
	<div class='box'>
		<label for='title'>제  목</label>
		<input type='text' name='title' id='title' required>
	</div>
	<div class='box'>
		<label for='info'>내  용</label>
		<textarea name='info' required style='resize: none; width: 95%; height: 15em; margin:0em 1em; overflow-x:auto;' ></textarea>
	</div>
	<!-- 히든인풋으로 작성자도 같이 폼에 보낼거임 -->
	<input type='text' name='name' id='name' value=${name } required placeholder='히든으로 작성자 보낼거임'>
</form>
<!-- //전송폼 -------------------------- -->

	<div class='box right'>
		<button type='button' onclick='goInsert()' class='button'>등  록</button>
		<button type='button' onclick='goBack()' class='button'>취  소</button>
	</div>
</div>

<!-- ------------------------------------------- -->

<!-- script -->
<script>
function goInsert(){
	noticeInsertForm.submit();
}
function goBack(){
	history.back();
}
</script>
<!-- //script -->

<jsp:include page="/foot.jsp"/>