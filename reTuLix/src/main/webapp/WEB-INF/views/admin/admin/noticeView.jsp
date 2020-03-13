<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/admin/adminTop" />

<!-- ------------------------------------------- -->
<div class='box'>
	<h1 class='head'>공지사항 읽기</h1>
</div>

<div class='box'>
	<div class='box' style='background-color:#035; border-bottom: 2px solid #999'>
		<label for='title' style='margin:0 0.5em;; font-size:1.5em; font-weight:bolder;'>${notice.title}</label>
	</div>
	<div class='box'>
		<div class='box' style='border-bottom:2px solid #999;'>
			<div class='left'>
				<label for='wdate' style='margin-left:0px;'>작성일 : ${notice.wdate}</label>
			</div>
			<div class='right' style='margin-right:100px;'>
				<label>조회수 : ${notice.click}</label>
			</div>
		</div>
	</div>
	<div class='box'>
		<label for='info' style='font-size=2em;' >내     용</label>
		<hr color='#999' style='margin:0em 1em;'>
		<div class='box' style='padding:0 0.5em;'>
			<pre><c:out value='${notice.info}'/></pre>
		</div>
		<hr color='#999' style='margin:0em 1em;'>
	</div>
<!-- 전송폼 -------------------------- -->
<form action='noticeEdit' name='noticeEditForm' method='GET'>
	<!-- 히든인풋 전송용-->
	<input type='hidden' name='idx' id='idx' value='${notice.idx}' readonly placeholder='히든으로 idx 보낼거임'>
	<!-- ////히든인풋 -->
</form>
<!-- //--전송폼 ------------------------ -->

	<div class='box right'>
		<button type='button' id='edit' onclick='goEdit(${notice.idx})' class='button'>수  정</button>
		<button type='button' id='delete' onclick='goDel(${notice.idx})' class='button' style='background:darkred;'>삭  제</button>
		<button type='button' onclick='goList()' class='button bg-list'>목록으로</button>
	</div>
</div>

<!-- ------------------------------------------- -->

<!-- script -->
<script>
//매개변수로 idx를 줘서 폼에 함께 보낸다
function goEdit(idx){
	noticeEditForm.action="noticeEdit";
	noticeEditForm.submit();
	
}
function goDel(idx) {
	var check= confirm("정말로 삭제하시겠습니까?");
	if(check==true){
		noticeEditForm.action="noticeDelete";
		noticeEditForm.submit();		
	}
	else {
		alert("삭제가 취소되었습니다");
		return;
	}
}
function goList(){
	location.href="notice";
}
</script>
<!-- //script -->

<c:import url="/foot"/>