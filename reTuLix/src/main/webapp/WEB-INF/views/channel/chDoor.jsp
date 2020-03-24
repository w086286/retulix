<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>

<c:import url="/top" />

<!-- 채널 이미지 ============================================== -->
<div class="channelImage">
	<img src="${pageContext.request.contextPath}/resources/images/channel/noChImg.png" alt="channelImage">
	<button class="button-active" id="changeChImg">이미지 변경</button>
</div>

<!-- 내비게이션 메뉴 버튼======================================== -->
<div class="channelMenu">
	<button class="button-active" onclick="chHome('${pageContext.request.contextPath}/user/chHome')" id="btChHome">홈</button>
	<button onclick="chStat('${pageContext.request.contextPath}/user/chStat')" id="btChStat">내 채널 및 영상</button>
	<button onclick="chInfo('${pageContext.request.contextPath}/user/chInfo')" id="btChInfo">내 정보 및 포인트</button>
	<button class="button-active" id="btChUpload">영상 업로드</button>
</div>

<!-- 화면 전환부============================================== -->
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
<!-- 트레일러 검색 -->
<div class="chUpload" id="chUpload">
<div class="findTrailer" id="findTrailer">
	<p>영상 업로드</p>
	<i class="fas fa-search"></i>&nbsp;
	<input type="text" id="inputFindApi" placeholder="리뷰한 영화 또는 드라마를 검색하세요.">
	<button onclick="findApi()">검색</button><br><br>
	
	<div>
		<table class='tables' id='tables' >
			<thead><tr class='success'>
				<th style='width: 15%'>트레일러 포스터</th>
				<th style='width: 20%'>트레일러 제목</th>
				<th style='width: 15%'>감독</th>
				<th style='width: 15%'>개봉일</th>
				<th style="display:none">api키</th>
				<th style="display:none">idx</th>
			</tr></thead>
			<tbody></tbody>
		</table>
	</div>
	
	<button id="btUploadNext">다음</button>
	<button id="chUploadClose" onclick="chUploadModalClose()">취소</button>
</div>
</div>

<!-- 트레일러 검색 후 파일 업로드 -->
<div class="chUploadNext" id="chUploadNext">
<div class="uploadReview" id="uploadReview">
	<p>영상 업로드</p>
	<img alt="" src="">
	
	<div>
		<table>
			<thead>
				<tr>
					<td>리뷰 제목</td>
					<td><input type="text" id="" name="" placeholder="업로드 할 리뷰 영상의 제목을 입력하세요."></td>
				</tr>
				<tr>
					<td>업로드</td>
					<td>
						<input type="text" id="chUploadUrl" name="chUploadUrl" placeholder="업로드 할 리뷰 영상의 주소을 입력하세요." style="float:left; width:60%">
						<input type="file" id="chUploadFile" name="chUploadFile" style="float:right; width:38%">
					</td>
				</tr>
				<tr>
					<td>리뷰 소개</td>
					<td><textarea rows="" cols="" type="text" id="" name="" placeholder="업로드 할 리뷰 영상의 제목을 입력하세요."></textarea></td>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	
	<!-- <button id="" onclick="submit_idx_change()">업로드</button> -->
	<button id="chReviewUpload" onclick="chReviewUpload()">업로드</button>
	<button id="chUploadClose" onclick="chUploadModalClose()">취소</button>
</div>
</div>

<c:import url="/foot" />

<script type="text/javascript">
$(function(){//==window.onload
	chHome('${pageContext.request.contextPath}/user/chHome');
})

//영상 업로드=====================================
$("#btChUpload").on("click", function(){	//모달 켜기
	$("#chUpload").css("display", "block");
	$("#inputFindApi").focus();
})
$("#chUploadClose").on("click", function(){	//모달 끄기
	$("#chUpload").css("display", "none");
})
//검색 버튼 이벤트 처리
var str="";	//선택한 행 str

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
//엔터키로 검색 처리
$("#inputFindApi").keydown(function(key){
	if(key.keyCode==13) findApi();
})

//검색값 출력
function showList(arr) {
	var str=""
	$.each(arr, function(i, list){
		var posterUrl="https://image.tmdb.org/t/p/w500"+list.poster_path;
		if(list.poster_path==null || list.poster_path=="null" || list.poster_path=="" || list.poster_path=="NULL"){
			posterUrl="${pageContext.request.contextPath}/resources/images/noUserIcon.png";
		}
		//드라마 장르일 때
		if(list.media_type=='tv'){
			str += "<tr onclick='row_click(this)'><td style='width:15%'>" + list.title + "</td>";
			str += "<td style='width:20%'><img src='" + posterUrl + "' style='height:8em'></td>";
			str += "<td style='width:15%'>" + list.original_name + "</td>";
			str += "<td style='width:20%'>" + list.first_air_date + "</td>";
			str += "<td style='display:none'>" + list.id + "</td>";
			str += "<td style='display:none'>" + '${mvo.idx}' + "</td>";
			str += "</tr>";	
		}
		//영화 장르일 때
		else{
			str += "<tr onclick='row_click(this)'><td style='width:15%'>" + list.title + "</td>";
			str += "<td style='width:20%'><img src='" + posterUrl + "' style='height:8em'></td>";
			str += "<td style='width:15%'>" + list.original_title + "</td>";
			str += "<td style='width:20%'>" + list.release_date + "</td>";
			str += "<td style='display:none'>" + list.id + "</td>";
			str += "<td style='display:none'>" + '${mvo.idx}' + "</td>";
			str += "</tr>";	
		}
	})
	$('#tables>tbody').html(str);
	table_paging($('#tables'));
}

//페이징 처리
function table_paging(arr) {
	$('#nav').remove();
	var $products = arr;
	$products.after('<div id="nav">');
	var $tr = $($products).find('tbody tr');
	var rowTotals = $tr.length;
	var rowPerPage = 5; //보여줄 갯수
	var pageTotal = Math.ceil(rowTotals / rowPerPage);
	var i = 0;
	for (; i < pageTotal; i++) {
		$('<a href="#"></a>').attr('rel', i).html(i + 1).appendTo('#nav');
	}
	$tr.addClass('off-screen').slice(0, rowPerPage).removeClass(
			'off-screen');
	var $pagingLink = $('#nav a');
	$pagingLink.on('click', function(evt) {
		evt.preventDefault();
		var $this = $(this);
		if ($this.hasClass('active')) {
			return;
		}
		$pagingLink.removeClass('active');
		$this.addClass('active');
		// 0 => 0(0*4), 4(0*4+4)
		// 1 => 4(1*4), 8(1*4+4)
		// 2 => 8(2*4), 12(2*4+4)
		// 시작 행 = 페이지 번호 * 페이지당 행수
		// 끝 행 = 시작 행 + 페이지당 행수
		var currPage = $this.attr('rel');
		var startItem = currPage * rowPerPage;
		var endItem = startItem + rowPerPage;
		$tr.css('opacity', '0.0').addClass('off-screen').slice(startItem,
				endItem).removeClass('off-screen').animate({
			opacity : 1
		}, 300);
	});
	$pagingLink.filter(':first').addClass('active');
}

//
function row_click(obj){ //1개만 선택되게하기
	$('tbody > tr').removeClass("highlight");
	var tmp=obj
			var tr = $(obj)
			var td = tr.children();
			var arr= new Array();
		    td.each(function(i){
		        if(i==td.length-1)
		        	str+="tdArr="+td.eq(i).text();	//i번 째 
		        else
		       		 str+="tdArr="+td.eq(i).text()+"&";
		    });   
		        var selected = $(obj).hasClass("highlight");
		        $(obj).removeClass("highlight");
		        if(!selected)
		        $(obj).addClass("highlight");
		    
	
	}

//검색 후 다음 버튼 클릭시
function submit_idx_change(){
	//alert(str);
	$.ajax({
		type : 'POST',
		url : 'movie_changeInfo',
		data: str,
		dataType : 'json',
		cache : 'false',
		/* async: false, */
		success : function(res) {
				alert('정보 변경 성공')
				change_info_close()
				refresh_page('${mvo.idx}')
		},
		error : function(e) {
			alert("e : " + e.status)
		}
	})
}

//다음 버튼 클릭시 다음 화면 출력
$("#btUploadNext").on("click", function(){	//모달 켜기
	$("#chUploadNext").css("display", "block");
	$("#chUpload").css("display", "none");
	$("#inputFindApi").focus();
})
$("#chUploadClose").on("click", function(){	//모달 끄기
	$("#chUploadNext").css("display", "none");
})

//리뷰 영상 주소 or 첨부 둘 중 하나만 가능하도록 처리
$("#chUploadFile").on("click", function(){
	if($("#chUploadUrl").val()!=""){
		alert("URL 또는 파일 첨부 중 한 방법으로만 업로드 가능합니다.");
		$("#chUploadFile").prop("disabled", true);
		$("#chUploadUrl").focus();
	}
})
$("#chUploadUrl").blur(function(){
	if($("#chUploadFile").val()!=""){
		alert("URL 또는 파일 첨부 중 한 방법으로만 업로드 가능합니다.");
		$("#chUploadFile").prop("disabled", false);
		$("#chUploadUrl").val("");
	}else if($("#chUploadUrl").val()==""){
		$("#chUploadFile").prop("disabled", false);
	}
})

//업로드 버튼 클릭시
function chReviewUpload(){
	$("#chReviewUpload").on("click", function(){
		var upUrl=$("#chUploadUrl").val();
		var upFile=$("#chUploadFile").val();
	})
	
}

//메뉴 버튼 처리===================================
//홈
function chHome(url) { //url을 click이벤트 파라미터로 넘겨받아 처리
	$.ajax({
		type : "post",
		url : url,
		dataType : "text",
		cache : false,
		success : function(res) {
			$("#chArticle").html(res);
		},
		error : function(err) {
			console.log("error @chDoor.jsp/chInfo(): " + err.status);
		}
	});
}

//내 채널 및 영상
function chStat(url) {
	$.ajax({
		type : "get",
		url : url,
		dataType : "text",
		cache : false,
		success : function(res) {
			$("#chArticle").html(res);
		},
		error : function(err) {
			console.log("error @chDoor.jsp/chInfo(): " + err.status);
		}
	});
}

//내 정보 및 포인트
function chInfo(url) {
	$.ajax({
		type : "get",
		url : url,
		dataType : "text",
		cache : false,
		success : function(res) {
			$("#chArticle").html(res);
		},
		error : function(err) {
			console.log("error @chDoor.jsp/chInfo(): " + err.status);
		}
	});
}

//이미지 변경 모달 처리=============================
$(function() {
	//"내 채널 및 영상" 진입시만 <이미지 변경> 버튼 보임
	$("#btChStat").on("click", function() {
		$("#changeChImg").css("display", "block");
	})
	$("#btChHome").on("click", function() {
		$("#changeChImg").css("display", "none");
	})
	$("#btChInfo").on("click", function() {
		$("#changeChImg").css("display", "none");
	})
	$("#btChUpload").on("click", function() {
		$("#changeChImg").css("display", "none");
	})

	//이미지 변경 버튼 클릭시 모달 팝업
	$("#changeChImg").on("click", function() {
		$("#chImgModal").css("display", "block");
	})

	$("#chImgModalClose").click(function() {
		$("#chImgModal").css("display", "none");
	})
})
function chImgModalClose() {
	chImgModal.style.display = "none";
}
function chUploadModalClose(){
	chUploadNext.style.display = "none";
}
</script>