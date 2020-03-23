<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/admin/adminTop" />

<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>
<style>
.right {
	margin-right: 6em;
}
</style>
<!-- -------------------------------------------------------- -->
<div class='outer'>
	<div class='left'>
		<!-- 컨텐츠 테이블 -->
		<table class='table'>
			<thead>
				<tr>
					<th colspan='3' style='text-align: right; padding-right: 7em;'>Content</th>
					<th style='text-align: right;'><a href="trailer"> <i
							class="fa fa-info-circle"></i></a></th>
				</tr>
			</thead>
			<tbody id='tbody'>
				<!-- 반복문 -->

				<!-- ------ -->
			</tbody>

		</table>
		<!-- ------ -->
	</div>
	
	<div class='right'>
		<!-- 회원관리 테이블 -->
		<table class='table'>
			<thead>
				<tr>
					<th colspan='3' style='text-align: right; padding-right: 10em;'>회원</th>
					<th style='text-align: right;'><a href="member"> <i
							class="fa fa-info-circle"></i></a></th>
				</tr>
			</thead>
			<tbody>
				<!-- 반복문 -->
				<c:forEach var='member' items='${memberList}' begin='0' end='3'>
					<tr>
						<td>${member.email}</td>
						<td>${member.name}</td>
						<td>${member.age}</td>
						<td>${member.stateStr}</td>
					</tr>
				</c:forEach>
				<!-- ------ -->
			</tbody>

		</table>
		<!-- ------ -->
	</div>
</div>


<div class='outer'>
	<div class='left'>
		<!-- 사용자컨텐츠 테이블 -->
		<table class='table'>
			<thead>
				<tr>
					<th colspan='3' style='text-align: right; padding-right: 8em;'>회원업로드</th>
					<th style='text-align: right;'><a href="contents"> <i
							class="fa fa-info-circle"></i></a></th>
				</tr>
			</thead>
			<tbody>
				<!-- 반복문 -->
				<c:forEach var='userContent' items='${contentList}' begin='0'
					end='3'>
					<tr>
						<td>${userContent.idx}</td>
						<td style='width: 50%;'>${userContent.reviewTitle}</td>
						<td>${userContent.trailerTitle }</td>
						<td>${userContent.name }</td>
					</tr>
				</c:forEach>
				<!-- ------ -->
			</tbody>
		</table>
		<!-- ------ -->
	</div>
	
	<div class='right'>
		<!-- 공지사항 테이블 -->
		<table class='table'>
			<thead>

				<tr>
					<th colspan='3' style='text-align: right; padding-right: 7em;'>공지사항</th>
					<th style='text-align: right;'><a href="notice"> <i
							class="fa fa-info-circle"></i></a></th>
				</tr>
			</thead>
			<tbody>
				<!-- 반복문 -->
				<c:forEach var='notice' items='${noticeList}' begin='0' end='3'>
					<tr>
						<td>${notice.idx }</td>
						<td style='width: 50%;'>${notice.title }</td>
						<td>${notice.name }</td>
						<td>${notice.wdate }</td>
					</tr>
				</c:forEach>
				<!-- ------ -->
			</tbody>
		</table>
		<!-- ------ -->
	</div>
</div>

<script>
/*
<c:forEach var='trailer' items='${trailerList}' begin='0' end='3'>
<tr>
	<td>${trailer.idx}</td>
	<td>${trailer.title}</td>
	<td>감독</td>
	<td>개봉일</td>
</tr>
</c:forEach>
*/
function drawTrailer(){
	//alert('${jsonTrailer}');
	var trailer= JSON.parse('${jsonTrailer}');
	var str="";
	
	$.each(trailer, function(i, list){
		str+="<tr>";
		str+="<td>"+list.idx+"</td>";
		str+="<td>"+list.title+"</td>";
		str+="<td id='director"+i+"'></td>";
		str+="<td id='release"+i+"'></td>";
		str+="</tr>"
		
		fetchMovie(list.api_idx, list.divi, function(result){
			$("#director"+i).text(result[2]);
			$("#release"+i).text(tmp);
		})
	})
	$("#tbody").append(str);
}
drawTrailer();

</script>

<c:import url="/foot" />