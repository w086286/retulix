<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/admin/adminTop" />
<!-- ------------------------------------------------------- -->


<!-- -------- -->

<div class='box'>
	<h2 class='head'>컨텐츠 목록</h2>
</div>
<form action="trailerSearch" name="searchForm" method="POST">
	<div class='box'>
		<select class='' name="selectBox">
			<option value='idx'>번호</option>
			<option value='title'>제목</option>
		</select> <input type='text' name="searchInput" class=''>
		<button type='button' onclick='goSearch()'>검색</button>
	</div>
</form>
<!-- ----------------------------------------------------- -->
<div class="outer">
	<div class='tableContainer'>
		<table class="table">
			<thead>
				<tr>
					<th>#</th>
					<th>인덱스</th>
					<th>제 목</th>
					<th>감 독</th>
					<th>개봉일</th>
					<th>소 개</th>
					<th>삭제</th>
				</tr>
			</thead>

			<tbody id='tbody'>
				<%--<c:forEach var="list" items="${listTrailer}">
					<tr>
						<td><a href='trailerEdit.do?idx=${list.idx}'><i class="fa fa-edit"></i></a></td>
						<!-- 컨텐츠 세부내용 보기는 저쪽으로 링크 이어줄거 -->
						<td><a href='movieView.do?idx=${list.idx}'>${list.idx}</a></td>
						<td>${list.title}</td>
						<td>감독</td>
						<td>개봉일</td>
				<c:if test='${function:length(list.title)<=40}'>	<!-- 너무길면 줄이기 -->
						<td title='${list.title}'>영화소개</td>
				</c:if>
				<c:if test='${function:length(list.title)>40}'>
						<td title='${list.title}'>${function:substring(list.title,0,40)}...</td>
				</c:if>
						<td><a href='javascript:goDel("${list.idx}")'><i class="fa fa-trash"></i></a></td>
					</tr>
				</c:forEach>--%>
			</tbody>
		</table>
		<div class='box'>${pageNavi}</div>
	</div>
</div>

<script>

function goSearch() {
	searchForm.submit();
}
function goDel(idx){
	var check= confirm("["+idx+"] 항목을 정말로 삭제하시겠습니까?");
	if(check){
		location.href="trailerDelete.do?idx="+idx;		
	}
	else {
		alert("삭제가 취소되었습니다");
		return;
	}
}

/* var director;
var release;
var info;
fetchMovie(${list.api_idx},'${list.divi}',function(result){
	director= result[2];
	release= result[5];
	info= result[1];
});
function getDirector(api_idx,divi){
	var director;
	fetchMovie(api_idx,divi,function(result){
		director=result[2];
		console.log(director);
	});
}
*/


function drawTable(){
	//alert('${jsonData}');			//string 형태
	var trData=JSON.parse('${jsonData}');	//json으로 파싱
	//alert(trData);
	var str="";
 	$.each(trData,function(i, list){
		str+="<tr>";
		str+="<td><a href='trailerEdit.do?idx="+list.idx+"'><i class='fa fa-edit'></i></a></td>";
		str+="<td><a href='movieView.do?idx="+list.idx+"'>"+list.idx+"</a></td>";
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

<%-- api함수 테스트 --%>
fetchMovie(94680,'D',function(result){
	console.log(result[2]);
})
</script>


<c:import url="/foot" />
