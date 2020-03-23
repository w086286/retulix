<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/admin/adminTop"/>
<!-- ---------------------------------------------- -->
<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>
<!-- ------------------------------------------------------- -->
<div class='box adm-title adm-bg-035'>
		<h2 class='head'><i class="fas fa-bullhorn" style='margin-right:0.5em;'></i>트레일러 검색 결과 [검색어 : ${paging.searchInput }]</h2>
</div>
<div class="outer">
	<div class='tableContainer'>
	<form action="trailerSearch" name="searchForm" method="GET">
		<div class='box right'>
			<select class='' name="selectBox">
				<option value='idx'>번호</option>
				<option value='title'>제목</option>
			</select>
			<input type='text' name="searchInput" class=''>
			<button type='button' onclick='goSearch()'>검색</button>
		</div>
	</form>
<!-- ----------------------------------------------------- -->
		<table class="adm-table">
			<thead>
				<tr>
					<th>#</th>
					<th>인덱스</th>
					<th>제목</th>
					<th>감독</th>
					<th>개봉일</th>
					<th>소개</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id='tbody'>
<%-- 				<c:forEach var="search" items="${searchTrailer}">
					<tr>
						<td><a href='trailerEdit.do?idx=${search.idx}'><i class="fa fa-edit"></i></a></td>
						<td>${search.idx}</td>
						<td>${search.title}</td>
						<td>감독</td>
						<td>개봉일</td>
						<!-- 컨텐츠 세부내용 보기는 저쪽으로 링크 이어줄거 -->
				<c:if test='${function:length(search.title)<=40}'>	<!-- 너무길면 줄이기 -->
						<td title='${search.title}'>영화소개</td>
				</c:if>
				<c:if test='${function:length(search.title)>40}'>
						<td title='${search.title}'>${function:substring(search.title,0,40)}...</td>
				</c:if>
						<td><a href='javascript:goDel("${search.idx}")'><i class="fa fa-trash"></i></a></td>
					</tr>
				</c:forEach> --%>
			</tbody>
		</table>
		<div class='box' align='center'>
			${pageNavi}
		</div>
	</div>
</div>

<script>
function goSearch() {
	searchForm.submit();
}
function goDel(idx){
	var check= confirm("["+idx+"] 항목을 정말로 삭제하시겠습니까?");
	if(check){
		location.href="trailerDelete?idx="+idx;		
	}
	else {
		alert("삭제가 취소되었습니다");
		return;
	}
}

//테이블 그리기
function drawTable(){
	//alert('${jsonData}');			//string 형태
	var trData=JSON.parse('${jsonData}');	//json으로 파싱
	//alert(trData);
	var str="";
 	$.each(trData,function(i, list){
		str+="<tr>";
		str+="<td><a href='trailerEdit?idx="+list.idx+"'><i class='fa fa-edit'></i></a></td>";
		str+="<td><a href='movieView?idx="+list.idx+"'>"+list.idx+"</a></td>";
		str+="<td style='max-width:18%;'>"+list.title+"</td>";
		str+="<td id='director"+i+"' style='width:15%;'></td>";
		str+="<td id='release"+i+"' style='width:10%;'></td>";
		str+="<td id='info"+i+"' style='width:40%; '></td>";
		str+="<td><a href='javascript:goDel(\""+list.idx+"\")'><i class='fa fa-trash'></i></a></td>";
		str+="</tr>";
		fetchMovie(list.api_idx,list.divi,function(result){
			//소개 길면 줄이기
			var info= result[1];
			if(info.length>40){
				//40자 초과
				info= info.substring(0,40);
			}
			
			$("#info"+i).attr("title",result[1]);
			$("#director"+i).text(result[2]);
			$("#release"+i).text(tmp);
			$("#info"+i).text(info+"...");
		})
		
 	});
	
	$("#tbody").append(str);
}
drawTable();

</script>

<c:import url="/foot"/>