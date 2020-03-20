<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
	var options = {
		'legend':{
			names: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15',]
				},
		'dataset':{
			title:'Playing time per day', 
			values: [[56,76], [58,66], [60,62], [58,70], [85, 76], [86,83], [82, 73], [77,66], [87,66], [49,56], [58,76], [85, 76], [56,83], [56, 83], [45, 34]],
			colorset: ['#0072b2', '#cc79a7'],
			fields:['Company A', 'Company B']
		},
		'chartDiv' : 'Nwagon',
		'chartType' : 'line',
		'leftOffsetValue': 40,
		'bottomOffsetValue': 60,
		'chartSize' : {width:700, height:300},
		'minValue' :0,
		'maxValue' : 100,
		'increment' : 20,
		'isGuideLineNeeded' : true //default set to false
	};

	Nwagon.chart(options);
</script>

<div class="chEdit" style="position: relative; float: left; width:34%;">
<div class="myChannelHead">채널 추이</div>
	<div class="chTotal">
		<div id="Nwagon"></div>		
		<table>
			<tr>
				<td>총 조회수</td>
				<td>총 좋아요수</td>
				<td>총 찜수</td>
				<td>총 구독수</td>
			</tr>
			<tr>
				<td>${stat.click}회</td>
				<td>${stat.good}회</td>
				<td>${stat.subs}회</td>
				<td>${stat.zzim}회</td>
			</tr>
			
			<th colspan="4">가장 조회수가 많은 영상</th>
			<tr><td rowspan="4"><img src="${pageContext.request.contextPath}/resources/images/userIcon/${loginUser.icon}" alt="mostView"></td></tr>
			<tr><td colspan="3"><c:out value="${statMaxClick.title}" /></td></tr>
			<tr><td colspan="3"><fmt:formatDate value="${statMaxClick.wdate}" pattern="yyyy년 MM월 DD일"/></td></tr>
			<tr><td colspan="3"><c:out value="${statMaxClick.t_title}" /></td></tr>

			<th colspan="4">가장 좋아요가 많은 영상</th>
			<tr><td rowspan="4"><img src="${pageContext.request.contextPath}/resources/images/userIcon/${loginUser.icon}" alt="mostView"></td></tr>
			<tr><td colspan="3"><c:out value="${statMaxGood.title}" /></td></tr>
			<tr><td colspan="3"><fmt:formatDate value="${statMaxGood.wdate}" pattern="yyyy년 MM월 DD일"/></td></tr>
			<tr><td colspan="3"><c:out value="${statMaxGood.t_title}" /></td></tr>
		</table>
	</div>
</div>

<div style="position: relative; float: right; width:65%;">
<div class="myChannelHead">영상 관리</div>
<form name="statSearch" id="statSearch" role="form" action="chStat.do" method="post">
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
<c:if test="${reviewList==null || empty reviewList}">
	<b>업로드한 영상이 없습니다.</b>
</c:if>

<table>
	<c:if test="${reviewList!=null && not empty reviewList}">
		<tr>
			<th>영상 제목</th>
			<th>업로드 날짜</th>
			<th>조회수</th>
			<th>좋아요</th>
			<th>찜</th>
			<th>리뷰 영화</th>
			<th>수정 | 삭제</th>
		</tr>
		<c:forEach var="reviewList" items="${reviewList}">
		<tr>
			<td><a href="${reviewList.url}">
				<c:out value="${reviewList.title}" />
			</a></td>
			<td><fmt:formatDate value="${reviewList.wdate}" pattern="yyyy년 MM월 DD일"/></td>
			<td><c:out value="${reviewList.click}" /></td>
			<td><c:out value="${reviewList.good}" /></td>
			<td><c:out value="${reviewList.zzim}" /></td>
			<td><c:out value="${reviewList.t_title}" /></td>
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

<script>
	//[검색]리뷰 영상 목록 검색 폼 처리:ajax
	function statReviewSearch(){
		if(!statSearch.statKeyword.value){
			alert("검색어를 입력하세요");
			stat.Search.statKeyword.focus();
			return;
		}
		//statSearch.submit;
		
		var selectBox=$("statType").val();
		var searchInput=$("#statKeyword").val();
		$.ajax({
			url:"%{pageContext.request.contextPath}/user/chStat?selectBox="+selectBox+"&searchInput"+searchInput,
			type:"get",
			dataType:"text",
			cache:false,
			success:function(res){
				alert(res);
			},
			error:function(err){
				alert(err);
			}
		});
	}
</script>