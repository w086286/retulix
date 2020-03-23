<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/top" />

<!-- ------------------------------------------- -->
<div class='box adm-title adm-bg-035'>
	<h1 class='head'><i class="fas fa-exclamation-circle" style='margin-right:0.5em;'></i>공지사항</h1>
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

	<div class='box right' style='margin-right:3em;'>
		<button type='button' onclick='goList()' class='button bg-list'>목록으로</button>
	</div>
</div>

<!-- ------------------------------------------- -->

<!-- script -->
<script>
function goList(){
	location.href="notice";
}
</script>
<!-- //script -->

<c:import url="/foot"/>