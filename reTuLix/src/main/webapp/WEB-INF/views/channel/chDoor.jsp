<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/top" />

<style>
.chUpload{
	display:none;
	position: absolute;
    z-index: 10009;
    padding-top: 100px;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: none;
    background-color: rgba(0,0,0,0.7);
}
.findTrailer{
	width: 700px;
	height: 250px;
	display: flex-direction:row;
	position: absolute;
	top:130px;
    text-align: center;
}
</style>

<div class="channelImage">
	<img src="${pageContext.request.contextPath}/resources/images/channel/noChImg.png" alt="channelImage">
	<button class="button-active" id="changeChImg">이미지 변경</button>
</div>

<div class="channelMenu">
	<button class="button-active" onclick="chHome('${pageContext.request.contextPath}/user/chHome')" id="btChHome">홈</button>
	<button onclick="chStat('${pageContext.request.contextPath}/user/chStat')" id="btChStat">내 채널 및 영상</button>
	<button onclick="chInfo('${pageContext.request.contextPath}/user/chInfo')" id="btChInfo">내 정보 및 포인트</button>
	<button class="button-active" id="btChUpload">영상 업로드</button>
</div>

<div id="chArticle"></div>

<!-- 채널 이미지 변경 모달======================================== -->
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

<!-- 영상 업로드 모달=========================================== -->
<div class="chUpload" id="chUpload">
<div class="findTrailer" id="findTrailer">
	<p>영상 업로드</p>
	<i class="fas fa-search"></i>&nbsp;
	<input type="text" id="inputFindApi" placeholder="업로드 영화 또는 드라마를 검색하세요.">
	<button onclick="findApi()">검색</button><br>
	
	<div>
		<table class='tables' id='tables' >
		<thead><tr class='success'>
			<th style='width: 15%'>제목</th>
			<th style='width: 55%'>요약</th>
			<th style='width: 20%'>개봉일</th>
			<th style='width: 15%'>원제목</th>
			<th style="display:none">api키</th>
			<th style="display:none">idx</th>
		</tr></thead>
		<tbody>
		
		</tbody>
		</table>
	</div>
	
	<button id="" onclick="submit_idx_change()">확인</button>
	<button id="chUploadClose" onclick="change_info_close()">취소</button>
</div>
</div>

<c:import url="/foot" />

<script type="text/javascript">
//영상 업로드=====================================
$(function(){
	$("#btChUpload").on("click", function(){	//모달 켜기
		$("#chUpload").css("display", "block");
	})
	$("#chUploadClose").on("click", function(){	//모달 끄기
		$("#chUpload").css("display", "none");
	})
})
//검색
function findApi() {
	const key="f6ef5ee7d41f7b86d5ea2c50796a6dfc";
	var keyword=$('#inputFindApi').val();
	const url="https://api.themoviedb.org/3/search/multi?api_key="+key+"&language=ko-KR&query="+keyword+"&page=1";
	
	$.ajax({
		type:'GET',
		url:url,
		dataType:'json',
		cache:'false',
		success:function(res){
			var searchResult=res.results;
			showList(searchResult);
		},
		error:function(err){
			alert("error: "+err.status);
		}
	});
}
//검색값 출력
function showList(arr) {
	var str=""
		$.each(arr, function(i, list){
			//드라마 장르일 때
			if(list.media_type=='tv'){
				str += "<tr onclick='row_click(this)'><td style='width:15%'>" + list.name + "</td>";
				str += "<td style='width:55%'>" + list.overview + "</td>";
				str += "<td style='width:20%'>" + list.first_air_date + "</td>";
				str += "<td style='width:15%'>" + list.original_name + "</td>";
				str += "<td style='display:none'>" + list.id + "</td>";
				str += "<td style='display:none'>" + '${mvo.idx}' + "</td>";
				str += "</tr>";	
			}
			//영화 장르일 때
			else{
				str += "<tr onclick='row_click(this)'><td style='width:15%'>" + list.title + "</td>";
				str += "<td style='width:55%'>" + list.overview + "</td>";
				str += "<td style='width:20%'>" + list.release_date + "</td>";
				str += "<td style='width:15%'>" + list.original_title + "</td>";
				str += "<td style='display:none'>" + list.id + "</td>";
				str += "<td style='display:none'>" + '${mvo.idx}' + "</td>";
				str += "</tr>";	
			}
		})
	
	$('#tables>tbody').html(str);
	table_paging($('#tables'));
}
	
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
		type:"get",
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
		type:"get",
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