
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctx=request.getContextPath();
%>
<!--  오큘러스 재생 불가 -->
<c:import url="/top" />
   
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>

<!-- css api js -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/repage.css" />
<script src="${pageContext.request.contextPath}/resources/js/api.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/colResizable-1.6.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/youtube.js"></script>

<script> 


	$(function(){
		 $('#play_movie').click(function(){
	            $('.iframe').slideDown(500,playYoutube());
	         
	        });
		 
	        var iframe = $('#players')[0];
	        var player = $(iframe);
		 
	        $('#imbt3').click(function(){
	              $('.iframe').slideUp(500,stopYoutube()); 
	       
	        });
	        
	});
	

 //////////////////////////////////////////////////////////////////////////////////////////////
 
         $(document).ready(function() {
        	 
        	
        	 var substr='${mvo.idx}';
        	 
        	 substr= substr.substring(0,1)
        	 /* 드라마 영화 판단후 각자 실행 */
        		 fetchMovie('${mvo.api_idx}',substr,function(result){
        	             $('.poster_img').attr("src",result[3]);
        	        	 $('.ma').html("<h1 style ='display:inline'>"+result[0]+"</h1>"+"<h3 style ='display:inline;color:gray'>("+result[5]+")</h3>");
        	        	 $('.ma').append("<h3>개요</h3>"+"<p>"+result[1]+"</p>");
        	        	 if(result[2]!='')
        	        		 {
        	        	 		$('.ma').append("감독 : "+result[2]);
        	        		
        	        		 }
        	             document.documentElement.style.setProperty('--main_bg', result[4]);
        	             }) 
        	 var m_info='${m_info}';
        	 
        	       if(m_info=='true'){
        	    	  
        	    	   $('#lasttime').addClass('ch_color');
        	       }
        	  
    	});
     

	 function refresh_page(title){
		 var str;
		 str="title="+title;
		 $.ajax({
				type : 'GET',
				url : 'refresh_screen',
				data: str,
				dataType : 'json',
				cache : 'false',
				success : function(res) {
					 var substr=res.idx;
					 var api_idx=res.api_idx;
					 substr= substr.substring(0,1)
					
						 fetchMovie(api_idx,substr,function(result){
					             $('.poster_img').attr("src",result[3]);
					        	 $('.ma').html("<h1 style ='display:inline'>"+result[0]+"</h1>"+"<h3 style ='display:inline;color:gray'>("+result[5]+")</h3>");
					        	 $('.ma').append("<h3>개요</h3>"+"<p>"+result[1]+"</p>");
					        	 if(result[2]!='')
					        		 {
					        	 		$('.ma').append("감독 : "+result[2]);
					        		
					        		 }
					             document.documentElement.style.setProperty('--main_bg', result[4]);
					             }) 
				},
				error : function(e) {
					alert("e : " + e.status)
				}

			})
		 
	 }
	 
	 
	 
         function poster(pos,idxy){
        	 
        	 var str="";
        	 var img2="";
        	 var tmp=idxy.substring(0,1);
        		fetchMovie(pos,tmp,function(result){
	             	img2=result[3];
	             str='<a href='+"showMovie?idx="+idxy+">"
	             str+='<img src='+img2+' width = "150px" height="100%">'
	             str+='</a>';
	           $('.rev').append(str);
	             })

         }
         function review_poster(furl,surl,index_num){
        	 //alert(info);
        	   var str='<a id = review'+index_num +' '+'onclick=overlay_show(this) title="'+furl+'">'
	              str+='<img src=https://img.youtube.com/vi/'+surl+'/mqdefault.jpg width = "300px" height="100%">'
	              str+='</a>'; 
	      		
	      		
	          $('.botom_reviews').append(str);
	         
	   
	        
         }
  function overlay_show(event){
        	 var tmp=event.title
        	 $('#overlay').addClass('show')
             $('body').addClass("stop-scrolling");
        	var str= '<iframe id = "Overlay_players" src="'+tmp+'?controls=0&enablejsapi=1" width = "700px" height="450px"></iframe>'
        	$('.overtube').html(str);
        	
         }


  function overlay_close(){
	  $('#overlay').removeClass('show')
      $('.overtube').html("");
      $('body').removeClass("stop-scrolling");
	  
  }
  
  function change_info_show(event){
 	 var tmp=event.title
 	 $('#change_info').addClass('show')
 	 $('.find_api').val(event);
      resize_able_table();
      $('body').addClass("stop-scrolling");
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
		    
	
	}/////////////////////////////////////
	


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
	
	
	function change_last(){
		var str="idx="+'${mvo.idx}';
		$.ajax({
			type:'POST',
			url : 'ck_zzim',
			data:str,
			dataType : 'json',
			cache:'false',
			success:function(res){
				if(res.result==-1)
					{
						alert('로그인 해야함');
						return;
					}
				else if(res.result==0)
					$('#lasttime').removeClass('ch_color')
				else if(res.result==1)
					$('#lasttime').addClass('ch_color')


			},
			error:function (e){
				alert("e : " + e.status)
				
			}
		})
	}
</script>



<!-- 리뷰어들 영상 오버레이 -->
<div id="overlay">
	<div class="overtube"></div>
	<div class='close'>
		<i onclick=overlay_close() class="far fa-times-circle"></i>
	</div>
	<div id="rev_mun">
		 
	</div>
</div>
<!-- api_idx재검색 -->
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

<div class ="z_container">

	<div class='backgr' >
			<div class='fix_but' style="z-index:9;color:white"><i  onclick="change_info_show('${mvo.title}')" class="fas fa-wrench"></i></div>
		 	<div class="iframe" style="position:relative; display:none" >
			<iframe id ='players'src="${mvo.url}?controls=0&enablejsapi=1" width = "100%" height="600px"></iframe>
			
			<i id ='imbt3' class="fas fa-times"></i>
		
			
			</div>
		<div class="container"  >
		
			<div class='item1'>
				<img class='poster_img'>
				
			 <i id="play_movie" class="fas fa-play"></i>
			 	<div class="gudok"><!-- 구독 나중에 보기 -->
				<i id="likeit" style="padding-right: 25px; font-size:2em" class="fas fa-plus"></i>
				<i id="lasttime" onclick="change_last()" style="font-size:2em"  class="fas fa-heart"></i>		
	</div>
		</div>
			<div class="ma" style = "color : white;" >
				 <!--  본문-->
			</div>
			
		</div>
	
		<p></p>
		
		 <c:forEach var="pos" items="${arr}">
				 <script>
					poster('${pos.api_idx}','${pos.idx}');
				 </script>
		</c:forEach> 
		<h2 class ="text_head">관련 영상</h2>
		<div class="rev">
		</div>
		<p></p>
		
			<h2 class ="text_head">리뷰어 영상</h2>		
		<div class="botom_reviews">
			
		</div>
 <c:forEach var="review" items="${reviews}" varStatus="i">
				 <script>
				review_poster('${review.url}','${review.title}','${i.index}');
				 </script>
		</c:forEach> 
	</div>
	 </div>
<c:import url="/foot" />