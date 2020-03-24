
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review_repage.css" />
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
        	
        	 var substr='${review.t_idx}';
        	 substr= substr.substring(0,1)
     
         	
        	 /* 드라마 영화 판단후 각자 실행 */
        		 fetchMovie('${trailer.api_idx}',substr,function(result){
        	             document.documentElement.style.setProperty('--main_bg', result[4]);
        	        	 $('.ma').html("<h1 style ='display:inline'>"+'${review.title}'+"</h1>"+"<h3 style ='display:inline;color:gray'>("+result[5]+")</h3>");
        	        	 $('.ma').append("<h3>개요</h3>"+"<p>"+'${review.info}'+"</p>");
        	        	 if(result[2]!='')
        	        		 {
        	        	 		$('.ma').append("작성자 : "+'${member.name}');
        	        		
        	        		 }        	
        	        	 var str='https://img.youtube.com/vi/'+'${review.t_title}'+'/hqdefault.jpg'
        	        	$('.poster_img').attr("src",str);
        		 }) 
        	         
        	        	
        	 var m_info='${m_info}';
        	 
        	       if(m_info=='true'){
        	    	  
        	    	   $('#lasttime').addClass('ch_color');
        	       } 
        	  
    	});

	 
	 
	 
   

         function review_poster(furl,surl){
        	   var str='<a href='+"showReview?idx="+surl+">"
	              str +='<img src=https://img.youtube.com/vi/'+furl+'/mqdefault.jpg width = "300px" height="150px" style="margin-top:1em">'
	              str+='</a>'; 
   		
	         
	          $('#right_mv').append(str);
	         
	   
	        
         }


	
</script>



<div class ="z_container">

	<div class='backgr' >
			<%-- <div class='fix_but' style="z-index:9;color:white"><i  onclick="change_info_show('${mvo.title}')" class="fas fa-wrench"></i></div>
		 	--%><div class="iframe" style="position:relative; display:none" >
			<iframe id ='players'src="${review.url}?controls=0&enablejsapi=1" width = "85%" height="600px"></iframe>
			
			<i id ='imbt3' class="fas fa-times"></i>
		 
			
			</div> 
			
		<div class="container"  >
		
			<div class='item1'>
				<img class='poster_img'>
				
			 <i id="play_movie" class="fas fa-play"></i>
			 	<div class="gudok"><!-- 구독 나중에 보기 -->
			 	
				<i id="likeit" style="font-size:2em" class="fas fa-plus"></i>
				<i id="lasttime" onclick="change_last()" style="font-size:2em"  class="fas fa-heart"></i>		
	</div>

		</div>
			<div class="ma" style = "color : white;" >
				 <!--  본문-->
			</div>
			
		</div>
	
		<p></p>
		
		<%--  <c:forEach var="pos" items="${arr}">
				 <script>
					poster('${pos.api_idx}','${pos.idx}');
				 </script>
		</c:forEach>  --%>

	
	</div>
	<div class="right_tool">
				<h2 class ="text_head">다음 동영상</h2>
		<div class="rev" id="right_mv">
	
		</div>
	
		</div>
	 </div>
	 	 <c:forEach var="review" items="${review_multi}" varStatus="i">
				 <script>
				review_poster('${review.url}','${review.idx}');
				 </script>
		</c:forEach>
<c:import url="/foot" />