<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="change_info">
	<div
		id="change_info_tab">
		<p>정보 수정 인터넷 검색</p>
		<i style="color: white" class="fas fa-search"></i>&nbsp;<input
			class="find_api" type="text">
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



<style>

#change_info_tab {
	width: 700px;
	height: 250px;
	display: flex-direction:row;
	
	position: absolute;
	top:130px;
}
/* 오버레이 설정 */
	#change_info{
            position: fixed;
            top:0; left:0;
            width: 100%; height: 100%;
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


</style>


<script>

  function change_info_show(event){
 	 var tmp=event.title
 	 $('#change_info').addClass('show')
 	 $('.find_api').val(event);
      resize_able_table();
      $('body').addClass("stop-scrolling");
  }


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
  
  
function change_info_close(){
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
		$.each(arr, function(i, list) {
			if(list.media_type=='tv'){
				
			str += "<tr onclick='row_click(this)'><td style='width:15%'>" + list.name + "</td>";
			str += "<td style='width:55%'>" + list.overview + "</td>";
			str += "<td style='width:20%'>" + list.first_air_date + "</td>";
			str += "<td style='width:15%'>" + list.original_name + "</td>";
			str += "<td style='display:none'>" + list.id + "</td>";
			str += "<td style='display:none'>" + '${mvo.idx}' + "</td>";
			str += "</tr>";	
			}
			else
				{
				str += "<tr onclick='row_click(this)' ><td style='width:15%'>" + list.title + "</td>";
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

////////////페이징
function table_paging(arr){
	
$('#nav').remove();
var $products = arr;

$products.after('<div id="nav">');


var $tr = $($products).find('tbody tr');
var rowTotals = $tr.length;
var rowPerPage =5; //보여줄 갯수

var pageTotal = Math.ceil(rowTotals/ rowPerPage);
var i = 0;

for (; i < pageTotal; i++) {
	$('<a href="#"></a>')
			.attr('rel', i)
			.html(i + 1)
			.appendTo('#nav');
}
$tr.addClass('off-screen')
		.slice(0, rowPerPage)
		.removeClass('off-screen');

var $pagingLink = $('#nav a');
$pagingLink.on('click', function (evt) {
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

	$tr.css('opacity', '0.0')
			.addClass('off-screen')
			.slice(startItem, endItem)
			.removeClass('off-screen')
			.animate({opacity: 1}, 300);

});

$pagingLink.filter(':first').addClass('active');

}

/////////////////////////////////////////

function resize_able_table(){
	
   	$("#tables").colResizable({
   	  fixed:false,
      liveDrag:true,
     
	  });  
}/////////////////////////////////////////////////////////////
var str="";
function row_click(obj){ //1개만 선택되게하기
	$('tbody > tr').removeClass("highlight");
	str='';
var tmp=obj
		var tr = $(obj)
		var td = tr.children();
	    td.each(function(i){
	        if(i==td.length-1)
	        	str+="tdArr="+td.eq(i).text();
	        else
	       		 str+="tdArr="+td.eq(i).text()+"&";
	      
	    });   
	  
	        var selected = $(obj).hasClass("highlight");
	        $(obj).removeClass("highlight");
	        if(!selected)
	        $(obj).addClass("highlight");
	    

}

</script>