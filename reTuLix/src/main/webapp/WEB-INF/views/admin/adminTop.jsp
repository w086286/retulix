<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/top.jsp"/>
<!-- admintop-------------------------------------------------------- -->
<% String myctx= request.getContextPath(); %>
<div class="box">
	<div class="head"><h1>- Admin Page -</h1></div>
</div>
<div id="" class="box">
	<div class="" style='display:inline-block; float:left'>
		<a href="<%=myctx %>/memberList.do" class='button'>회원정보</a> 
		<a href="<%=myctx %>/trailerList.do" class='button'>컨텐츠목록</a> 
		<a href="<%=myctx %>/memberAllContent.do" class="button">회원컨텐츠</a> 
		<a type="button" class="">결제내역</a>
	</div>
	<div class='' style='display:inline-block; float:right;'>
		<a href='trailerInsert.do' class='button' style='margin-left:2em;'>등록</a>
	</div>
</div>

<hr color='gray'>
