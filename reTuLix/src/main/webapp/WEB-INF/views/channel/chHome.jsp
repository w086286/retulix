<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="myChannelHead">최근 업로드</div>
<div id="reviewList" name="reviewList">
	<!--
	<c:forEach var="review" items="${reviewList}">
		<img onload="findThumbs(${review.trailer[0].api_idx}, ${review.idx})" src="" id="reviewThumbs">
		<span>
			${review.title}<br>
			${review.wdate}<br>
			${review.idx}<br>
			${review.click}<br>
			${review.trailer[0].api_idx}<br>
			 join한 trailer의 api_idx를 참조하려면 "forEach문에서 선언한 변수.trailer.api_idx" 로 출력한다
			단, 지금처럼 ReviewVO에서 trailer를 ArrayList로 선언한 경우 반복문을 돌려 출력해야하므로 for문을 내부에서 또 돌리거나 위처럼 [0]인덱스를 지정해 출력한다.
			따라서 지금 경우는 사실 VO에서 ArrayList로 변수 선언을 하지 않고 단일로 선언했어야 함=>출력시 "review.trailer.api_idx" 로 출력
		</span>
	</c:forEach>
	-->
</div>

<script>
function findThumbs(){
	//1)string 형태로 파싱
	var reviewData=JSON.parse('${reviewListJson}');
	
	var str="";
	//2)반복문 돌려서 div에 리스트 출력하기
	$.each(reviewData, function(i, review){		//i=반복문 i, review=reviewData의 별칭
		str+="<a href='showReview?idx="+review.idx+"'>";
		str+="<img id='reviewThumbs"+i+"' style='height:12em'>";	//id가 중복되서 반복문이 중복으로 돌지 않도록 index값 붙여서 id 선언해줌
		str+="<span>"+review.title+"<br>"+review.wdate+"<br>"+review.click+"<br></span>";
		
		var api_idx=review.trailer[0].api_idx;
		var idx=review.idx.substring(0,1);
		fetchMovie(api_idx, idx, function(result){
			//result[0] 제목
			//result[1] 개요
			//result[2] 감독
			//result[3] 포스터
			//result[4] 배경
			//result[5] 개봉일
			$("#reviewThumbs"+i).attr("src", result[3]);
		}) 
	});
	$("#reviewList").append(str);
}
findThumbs();
</script>