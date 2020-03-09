<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/admin/adminTop.jsp"/>

<!-- ------------------------------------------- -->
<div class='box'>
	<h1 class='head'>공지사항 수정</h1>
</div>

<div class='box'>

<!-- 전송폼 -------------------------- -->
<form action='noticeEditEnd.do' name='noticeEditForm' method='POST'>
<div class='box'>
	<div class='left'>
		<label for='title'>제  목</label>
		<input type='text' name='title' id='title' value='${notice.title}' required>
	</div>
	<div class='right' style='margin-right:100px;'>
		<label class='label'>조회수 :</label>
		<a href='#noticeEditForm'>${notice.click}</a>
	</div>
</div>
	<div class='box'>
		<label for='info'>내  용</label>
		<textarea name='info' style='resize: none; width: 95%; height: 15em; margin:0em 1em; overflow-x:auto;' required>${notice.info}</textarea>
	</div>
		<!-- 히든인풋으로 글번호,작성자도 같이 폼에 보낼거임 -->
		<input type='text' name='idx' id='idx' value='${notice.idx}' readonly>
		<input type='text' name='name' id='name' value='${notice.name}' readonly>
		<input type='text' name='click' id='click' value='${notice.click}' readonly>
</form>
<!-- //전송폼 -------------------------- -->

	<div class='box right'>
		<button type='button' onclick='goEdit()' class='button'>수  정</button>
		<button type='button' onclick='goBack()' class='button'>취  소</button>

	</div>
</div>

<!-- ------------------------------------------- -->

<!-- script -->
<script>
function goEdit(){
	noticeEditForm.submit();
}
function goBack(){
	history.back();
}

</script>
<!-- //script -->

<jsp:include page="/foot.jsp"/>