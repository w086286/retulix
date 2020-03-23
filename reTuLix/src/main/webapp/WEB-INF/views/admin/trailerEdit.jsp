<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/admin/adminTop"/>
<!-- ------------------------------------------------------- -->
<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>
<!-- 검색폼 css -->
<style>
#change_info_tab {
	width: 700px;
	height: 250px;
	display: flex-direction:row;
	position: absolute;
	top: 130px;
}
/* 오버레이 설정 */
#change_info {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.8);
	z-index: 999;
	/* 시작시 보이지 않게 처리 */
	visibility: hidden;
	opacity: 0;
	transition: all 0.5s;
	text-align: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

/* 오버레이를 보여 줄때 사용 */
#change_info.show {
	visibility: visible;
	opacity: 1;
}
/*오버레이시 스크롤링 금지*/
.stop-scrolling {
	/* height: 100%; */
	overflow: hidden;
}

.success{
	overflow: hidden;
	 text-overflow: clip;
	 white-space: nowrap;
	  text-overflow: ellipsis;
} 


/* 검색 오버레이 */
 .tables{
	width :100%;
	height :100%;
	table-layout: fixed;
	overflow: hidden;
	
}

.tables td{
	 overflow: hidden;
	 text-overflow: ellipsis;
	 white-space: nowrap;
	table-layout: fixed;
	
	
}
 th{
	border:1px solid black;
} 

.off-screen {
	display: none;
}
#nav {
	width: 100%;
	text-align: center;
}
#nav a {
	display: inline-block;
	padding: 3px 5px;
	margin-right: 10px;
	font-family:Tahoma;
	background: #ccc;
	color: #000;
	text-decoration: none;
}
#nav a.active {
	background: #333;
	color: #fff;
}
.highlight{
	background: red! important;
}

</style>
<!-- //검색폼 css -->




<!-- -------------------------------------------------------- -->

<div class='box adm-title adm-bg-035'>
	<h1 class='head'><i class="fas fa-bullhorn" style='margin-right:0.5em;'></i>
		컨텐츠 수정 [${trailer.title}]
		&nbsp;&nbsp;${trailer.idx}
	</h1>
</div>

<div class='box'>

	<!-- 전송폼 -->
	<form name='editForm' action='trailerEdit' method='POST' >
	<div class='box adm-title' >
		<div style='float:left;'>
			<label for='divi' class='adm-bg-035'>구  분</label>
			<span id='diviStr' style='margin-left:2em; margin-right:4em; color:white;'></span>
			<label for='genre' class='adm-bg-035'>장 르</label>
			<span id='genreStr' style='margin-left:2em; color:white;'></span>
			<br>
			<span style='color:red; text-shadow:none;'>※ 원래 구분과 수정하고자 하는 구분이 일치하지 않을 경우 정보가 제대로 표시되지 않을 수 있습니다</span>
		</div>
		<div style='float:right; margin-right:2em;'>
			<!-- 트레일러 검색버튼 -->
			<label onclick='change_info_show()' class='button' style='background-color:darkred; font-weight:bolder;'>
				찾아보기</label>
		</div>
	</div>
	<div class='adm-title adm-bg-035' style='font-size:1.3em;'>
		<label>제  목</label>
		<span id='titleInsert'>${trailer.title}</span>
	</div>
	<div style='margin-left:1em;'>
		<label>감  독</label>
		<span id='directorInsert'></span>
		<label style='margin-left:4em;'>개봉일</label>
		<span id='releaseInsert'></span>
	</div>
	
	<div class='box adm-title'>
		<div class='adm-title'>
			<label>소  개</label>
		</div>
		<textarea id='info' name='info' style='resize: none; width: 90%; height: 15em; margin:0em 1em; overflow-x:auto;'><c:out value="영화소개"/></textarea>
	</div>
	<div class='box' style='margin-left:3em;'>
		<label for='img1Insert' id='imgPathLabel' style='background-color:#035;'>
			<a href='#' id='imgLink'>포스터 미리보기</a></label>
	</div>
	<!-- 히든인풋 -->
	<input type='hidden' id='divi' name='divi' value='${trailer.divi }'>
	<input type='hidden' id='title' name='title' value='${trailer.title }'>
	<input type='hidden' id='api_idx' name='api_idx' value='${trailer.idx}' readonly>
	<input type='hidden' id='genre' name='genre' value='${trailer.genre}' readonly>
	<input type='hidden' id='idx' name='idx' value='${trailer.idx}' readonly>
	</form>
	<!-- //전송폼.끝 -->
	<div class='box right'>
		<button type='button' onclick='goEdit()'>수  정</button>
		<button type='button' onclick='javascript:history.back()'>취  소</button>
	</div>

</div><!-- /box outline -->


<!-- 트레일러 검색(히든)---------------------- -->
<div id="change_info">
	<div
		id="change_info_tab">
		<p>정보 수정 인터넷 검색</p>
		<i style="color: white" class="fas fa-search"></i>&nbsp;<input
			onkeypress="inputEnter(event)" class="find_api" type="text">
		<button onclick="send_ajax()">검색</button>
		<br>
		<div>
			<table class='tables' id='tables' >
			<thead>
				<tr class='success'>
					<th style='width: 15%'>타이틀</th>
					<th style='width: 55%'>요약</th>
					<th style='width: 20%'>개봉일</th>
					<th style='width: 15%'>원제목</th>
					<th style="display:none">api키</th>
					<th style="display:none">idx</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>


		</div>
		<button onclick="submit_idx_change()">확인</button>
		<button onclick="change_info_close()">취소</button>
	</div>

</div>
<!-- ---------------------------------- -->


<script>
	function goEdit(){
		editForm.submit();
	}
	
	<%-- 검색하기 ---------------------- --%>
	/* 검색폼 스크립트 */
	//엔터치면 검색
	function inputEnter(e){
		if(e.keyCode==13){
			send_ajax();
		}
	}
	function change_info_show() {
		//var tmp = event.title
		$('#change_info').addClass('show')
		$('.find_api').val();
		resize_able_table();
		$('body').addClass("stop-scrolling");
	}
	
	//구분과 장르 제대로 출력해주기
	function reprintDiviGenre(){
		var diviChar=$("#divi").val();
		var genreChar=$("#genre").val();
		
		var diviStr= (diviChar=="D")? "드라마":"영화";
		var genreStr;
		if(genreChar=="A") genreStr="액션";
		else if(genreChar=="C") genreStr="코미디";
		else if(genreChar=="H") genreStr="호러/스릴러";
		else if(genreChar=="R") genreStr="멜로/로맨스";
		else if(genreChar=="S") genreStr="SF/판타지";
		
		$("#diviStr").text(diviStr);
		$("#genreStr").text(genreStr);
	}
	reprintDiviGenre();

	var trailerDesc = new Array();	//트레일러 정보 담을 배열
	//확인버튼
	function submit_idx_change() {
		//alert(trailerDesc);
		var title= trailerDesc[0];
		var info= trailerDesc[1];
		var release= trailerDesc[2];
		var originTitle= trailerDesc[3];
		var api_idx= trailerDesc[4];
		var imgPath= trailerDesc[5];
		
		fetchMovie(api_idx,$("#divi").val(), function(result){
			$("#directorInsert").text(result[2]);
			$("#info").html(info);
		})
		
		$("#titleInsert").text(title);
		$("#title").val(title);
		$("#info").html(info);
		$("#api_idx").val(api_idx);
		$("#releaseInsert").text(release);
		$("#imgLink").attr("href", imgPath);
		$("#imgPathLabel").attr("style", "background-color:darkred;");
		
		change_info_close();
	}

	

	function change_info_close() {
		$('#change_info').removeClass('show')
		$('body').removeClass("stop-scrolling");

	}

	function send_ajax() {
		const key = "f6ef5ee7d41f7b86d5ea2c50796a6dfc";
		var name = $('.find_api').val();
		const url = "https://api.themoviedb.org/3/search/multi?api_key=" + key
				+ "&language=ko-KR&query=" + name + "&page=1"
		$.ajax({
			type : 'GET',
			url : url,
			dataType : 'json',
			cache : 'false',
			success : function(res) {
				var newArray = res.results;
				newArray.sort(function(a, b) {
					return b["vote_average"] - a["vote_average"];
				})
				showList(newArray);
			},
			error : function(e) {
				alert("e : " + e.status)
			}

		})

	}
	
	function showList(arr) {
		var str = ""
		$.each(	arr,function(i, list) {
			if (list.media_type == 'tv') {

				str += "<tr onclick='row_click(this)'><td style='width:15%'>"
						+ list.name + "</td>";
				str += "<td style='width:55%'>" + list.overview
						+ "</td>";
				str += "<td style='width:20%'>"
						+ list.first_air_date + "</td>";
				str += "<td style='width:15%'>"
						+ list.original_name + "</td>";
				str += "<td style='display:none'>" + list.id
						+ "</td>";
				str += "<td style='display:none'>" + list.poster_path
						+ "</td>";
				str += "<td style='display:none'>" + list.media_type
						+ "</td>";
				str += "</tr>";
			} else {
				str += "<tr onclick='row_click(this)' ><td style='width:15%'>"
						+ list.title + "</td>";
				str += "<td style='width:55%'>" + list.overview
						+ "</td>";
				str += "<td style='width:20%'>"
						+ list.release_date + "</td>";
				str += "<td style='width:15%'>"
						+ list.original_title + "</td>";
				str += "<td style='display:none'>" + list.id
						+ "</td>";
				str += "<td style='display:none'>" + list.poster_path
						+ "</td>";
				str += "<td style='display:none'>" + list.media_type
						+ "</td>";
				str += "</tr>";

			}
		})

		$('#tables>tbody').html(str);
		table_paging($('#tables'));
	}

	var str = "";
	function row_click(obj) { //1개만 선택되게하기
		$('tbody > tr').removeClass("highlight");
		const base_url = "https://image.tmdb.org/t/p/original";	//이미지파일 경로
		var tr = $(obj)
		var td = tr.children();
		td.each(function(i) {
			trailerDesc[i]=td.eq(i).text();
		});
		trailerDesc[5]= base_url+trailerDesc[5];
		//[0]: 타이틀
		//[1]: 소개
		//[2]: 개봉일
		//[3]: 원제목
		//[4]: api_idx
		//[5]:이미지
		//[6]:드라마/영화 여부
		
		/* 드라마인지 영화인지 구분해주기 */
		var mediaType= $("#divi").val();	//드라마인지 영화인지?
		if($("#divi").val()=="D"){
			mediaType="tv";
		}
		else if($("#divi").val()=="M"){
			mediaType="movie";
		}
		if(trailerDesc[6] != mediaType){
			alert("구분이 다릅니다. 다시 선택해주세요");
			return;
		}
		
		
		var selected = $(obj).hasClass("highlight");
		$(obj).removeClass("highlight");
		if (!selected)
			$(obj).addClass("highlight");
		
	}
	
	
	////////////페이징
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

	/////////////////////////////////////////

	function resize_able_table() {

		$("#tables").colResizable({
			fixed : false,
			liveDrag : true,

		});
	}/////////////////////////////////////////////////////////////
</script>

<!-- ------------------------------------------------------- -->
<c:import url="/foot"/>