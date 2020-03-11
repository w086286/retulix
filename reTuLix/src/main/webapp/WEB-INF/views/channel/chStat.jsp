<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctx=request.getContextPath(); %>

<div class="myChannelHead">채널 추이</div>
<div class="chEdit">

	<!-- 차트 -->
	<div style="border: 1px red solid; position: relative; float: left; width: 49.5%;">
		<div id="curve_chart" style="width:100%"></div>
	</div>

	<!-- 집계 -->
	<div class="chTotal" style="border: 1px red solid; position: relative; float: left; width: 49.5%;">
		<table>
			<tr>
				<td>조회수</td>
				<td>좋아요</td>
				<td>구독</td>
				<td>찜</td>
			</tr>
			<tr>
				<td>회</td>
				<td>회</td>
				<td>회</td>
				<td>회</td>
			</tr>
			<tr>
				<td colspan="2">
					가장 조회수가 많은 영상<br>
					<img src="<%=ctx%>/images/channel/channel_image.png" alt="mostView">
					<span>영상 제목</span><br>
					<span>업로드일</span><br>
				</td>
				<td colspan="2">
					가장 좋아요가 많은 영상<br>
					<img src="<%=ctx%>/images/channel/channel_image.png" alt="mostLike">
					<span>영상 제목</span><br>
					<span>업로드일</span><br>
				</td>
			</tr>
		</table>
	</div>

	<div class="myChannelHead">영상 관리</div>
	<form name="statSearch" id="statSearch" role="form" action="chStat.do" method="post">
	<!-- 진입 테스트 회원 정보:::::::::::나중에 삭제 -->
	<div style="display:none">
	<input id="email" name="email" value="nofootbird@gmail.com">
	<input id="pwd" name="pwd" value="123">
	</div>
	<!-- :::::::::::::::::::::::::::::::::::::::: -->
		<div class="chHomeHead">
			<div class="channelAlign">
				<select name="statType" id="statType">
					<option value="1">제목</option>
					<option value="2">날짜</option>
				</select>
			</div>
			<div class="channelSearch">
				<input name="statKeyword" id="statKeyword" placeholder="검색어를 입력하세요">
				<i class="fa fa-search" type="button" onclick="statReviewSearch()" style="cursor:pointer"></i>
			</div>
		</div>
	</form>
	<div>
	<c:if test="${statArr==null || empty statArr}">
		<b>업로드한 영상이 없습니다.</b>
	</c:if>

	<table>
		<c:if test="${statArr!=null && not empty statArr}">
			<tr>
				<th>영상 제목</th>
				<th>업로드 날짜</th>
				<th>조회수</th>
				<th>좋아요</th>
				<th>찜</th>
				<th>리뷰 영화</th>
				<th>수정 | 삭제</th>
			</tr>
			<c:forEach var="stat" items="${statArr}">
			<tr>
				<td><c:out value="${stat.title}" /></td>
				<td><c:out value="${stat.wdate}" /></td>
				<td><c:out value="${stat.click}" /></td>
				<td><c:out value="${stat.good}" /></td>
				<td><c:out value="${stat.zzim}" /></td>
				<td><c:out value="${stat.t_title}" /></td>
				<td>
					<a href="#"><i class="fas fa-pen"></i></a>&nbsp; | &nbsp;
					<a href="#"><i class="fas fa-trash"></i></a> 
				</td>
			</tr>
		</c:forEach>
	</table>
		
	<ul style="text-align:center">
		<c:set var="query" value="type=${type}&search=${search}" />
		<c:forEach var="page" begin="1" end="${pageCount}" step="1">
			<li style="display:inline">
				<c:if test="${page eq crtPage}">
					<a href="boardList.do?crtPage=${page}&${query}" style="color:red"><b>${page}</b></a>
				</c:if>
				<c:if test="${page ne crtPage}">
					<a href="boardList.do?crtPage=${page}&${query}">${page}</a>
				</c:if>
			</li>
		</c:forEach>		
	</ul>
	</c:if>
	</div>
	
</div>
	
<%-- <script type="text/javascript" src="<%=ctx%>/js/channel/loader.js"></script>
<script type="text/javascript" src="<%=ctx%>/js/channel/charts.js"></script> --%>

<script type="text/javascript">
/*$(function(){
$("#btSearch").click(function(){
	if($("#search").val()==""){
		alert('검색어를 입력하세요');
		return;
	}
	$("#statSearch").submit;
})
})
*/
function statReviewSearch(){
if(!statSearch.statKeyword.value){
	alert("검색어를 입력하세요");
	stat.Search.statKeyword.focus();
	return false;
}
statSearch.submit;
}
</script>