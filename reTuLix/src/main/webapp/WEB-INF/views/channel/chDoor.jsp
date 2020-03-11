<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/top" />

<div class="channelImage">
	<img src="${pageContext.request.contextPath}/resources/images/channel/noChImg.png" alt="channelImage">
	<button class="button-active" id="changeChImg">이미지 변경</button>
</div>

<div class="channelMenu">
	<button class="button-active" onclick="chHome('${pageContext.request.contextPath}/user/chHome')" id="btChHome">홈</button>
	<button onclick="chStat('${pageContext.request.contextPath}/user/chStat')" id="btChStat">내 채널 및 영상</button>
	<button onclick="chInfo('${pageContext.request.contextPath}/user/chInfo')" id="btChInfo">내 정보 및 포인트</button>
	<button class="button-active" onclick="chUpload()"  id="btChUpload">영상 업로드</button>
</div>

<div id="chArticle"></div>

<!-- 채널 이미지 변경 모달 -->
<div id="chImgModal" class="chImgModal">
	<div class="chImgModal-content">
		<p>
			사진 업로드
			<i class="chImgModalClose fa fa-times" id="chImgModalClose"></i>
		<p>
		<div>
			사진을 여기로 드래그합니다.<br>
			<br>
			드래그 앤 드롭이 싫으시면...<br>
			<button>컴퓨터에서 사진 찾기</button>
		</div>
		<br>
		<button class="button-active">적용</button>
		<button class="button-inactive" onclick="chImgModalClose()">취소</button>
		<span>
			채널 이미지 권장 크기: 1650 X 200 픽셀<br>
			최대 파일 크기 : 6MB
		</span>
	</div>
</div>

<c:import url="/foot" />

<script type="text/javascript">
//메뉴 버튼 처리===================================
//홈
function chHome(url){	//url을 click이벤트 파라미터로 넘겨받아 처리
	$.ajax({
		type:"post",
		url:url,
		dataType:"text",
		cache:false,
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chInfo(): "+err.status);
		}
	});
}

//내 채널 및 영상
function chStat(url){
	$.ajax({
		type:"post",
		url:url,
		dataType:"text",
		cache:false,
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chInfo(): "+err.status);
		}
	});
}

//내 정보 및 포인트
function chInfo(url){
	$.ajax({
		type:"post",
		url:url,	//channel/chInfo
		dataType:"text",
		cache:false,
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chInfo(): "+err.status);
		}
	});
}

//영상 업로드===================================
function chUpload(){
	
}

//이미지 변경 모달 처리=============================
$(function() {
	//"내 채널 및 영상" 진입시만 <이미지 변경> 버튼 보임
	$("#btChStat").on("click", function(){
		$("#changeChImg").css("display", "block");
	})
	$("#btChHome").on("click", function(){
		$("#changeChImg").css("display", "none");
	})
	$("#btChInfo").on("click", function(){
		$("#changeChImg").css("display", "none");
	})
	$("#btChUpload").on("click", function(){
		$("#changeChImg").css("display", "none");
	})

	//이미지 변경 버튼 클릭시 모달 팝업
	$("#changeChImg").on("click", function(){
		$("#chImgModal").css("display","block");
	})
	
	$("#chImgModalClose").click(function(){
		$("#chImgModal").css("display","none");
	})
})
function chImgModalClose(){
	chImgModal.style.display="none";
}
</script>