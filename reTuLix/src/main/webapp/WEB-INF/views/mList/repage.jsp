<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctx=request.getContextPath();
%>
<!--  오큘러스 재생 불가 -->

   
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<!-- css api js -->
<link rel = "stylesheet" href="./css/repage.css">
<script src="./js/api.js"></script>
<script src="./js/youtube.js"></script>

<script> 


	$(function(){
		 $('#play_movie').click(function(){
	            $('.iframe').slideDown(500,playYoutube());
	         
	        });
		 
	        var iframe = $('#players')[0];
	        var player = $(iframe);
		 
	        $('.imbt3').click(function(){
	              $('.iframe').slideUp(500,stopYoutube()); 
	       
	        });
	        
	});
	

 //////////////////////////////////////////////////////////////////////////////////////////////
 
         $(document).ready(function() {
        	 console.log("page on load")
        	
        	 var substr='${mvo.idx}';
        	 substr= substr.substring(0,1)
        	 /* 드라마 영화 판단후 각자 실행 */
        		 fetchMovie('${mvo.api_idx}',substr,function(result){
        	             $('.poster_img').attr("src",result[3]);
        	        	 $('.ma').html("<h1 style ='display:inline'>"+result[0]+"</h1>"+"<h3 style ='display:inline;color:gray'>("+result[5]+")</h3>");
        	        	 $('.ma').append("<h3>개요</h3>"+"<p>"+result[1]+"</p>");
        	        	 $('.ma').append("감독 : "+result[2]);
        	             document.documentElement.style.setProperty('--main_bg', result[4]);
        	             }) 
        	   	
    	});
         function poster(pos,idxy){
        	 
        	 var str="";
        	 var img2="";
        	 var tmp=idxy.substring(0,1);
        		fetchMovie(pos,tmp,function(result){
	             	img2=result[3];
	             str='<a href='+"movieView.do?idx="+idxy+">"
	             str+='<img src='+img2+' width = "150px" height="100%">'
	             str+='</a>';
	           $('.rev').append(str);
	             })

         }
         function review_poster(idx,url){
        	   var str='<a href='+"trailerView.do?idx="+idx+">"
	              str+='<img src=https://img.youtube.com/vi/'+url+'/mqdefault.jpg width = "300px" height="100%">'
	              str+='</a>'; 
	      	
	          $('.botom_reviews').append(str);
	   
	        
         }
     

</script>


<!-- js 함수 반복

	1. 지금한거 함수 1번을 5번 호출
 -->
 <div class ="z_container">

	<div class='backgr' >
	
		 	<div class="iframe" style="position:relative; display:none" >
			<iframe id ='players'src="${mvo.url}?controls=0&enablejsapi=1" width = "100%" height="600px"  ></iframe>
			
			<img class='imbt4' src="./images/exit2.png">
			<img class='imbt3' src="./images/exit.png"> 
			
			</div>
		<div class="container"  >
		
			<div class='item1'>
				<img class='poster_img'>
			 <i id="play_movie" class="fas fa-play"></i>
			
			
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
 <c:forEach var="review" items="${reviews}">
				 <script>
				review_poster('${review.idx}','${review.url}');
				 </script>
		</c:forEach> 
	</div>
	 </div>
