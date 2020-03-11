<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!--  /*
       		정보가 정확하지 않음 미리 페이징 하고싶음 자바 모르겟고
       		java db=> 이름 idx 다가져와 배열로
       		그걸 jsp받아서 js로 하나씩 리퀘를 보내고 응답받되
       		받는건 영화의 idxnum
       		이걸 위에서 받은 java db배열과 비교해서
       		다시 java로 보내서 db에 써
       		이과정을  페이징이라하고
       		관리자만 접근이 가능하며
       		첫 한번만 하게
       		 js 실행순서 문제발생 핼프 시반ㅁ이ㅏ;ㅓ티처ㅗ미너ㅗ이ㅓㅗㅁㄴ이ㅓ미너
       		1) 그거처럼 페이징 하고 상태저장(페이징 했는지 안했는지 db에 boolean으로)  =>자스로 가능할 까?
       		2) 무시하고 수동도 가능
       		3) db에 추가정보는 영화면 그 영화의 id키값
       		4) id키값을 가져와서 상세정보 띄우는것이 가능하다
       		5) 영화 db에서 키값인출후 요청보내서 결과띄우기
       		
       */ -->
    
     <body>
    
 	<form name='input' id ='input' action="jsonfinal.do" method='post'>
 	 <button id ='button' type="submit" >눌러라 전송</button>
 	<div>
 	<input type="text" name="test" id="test" readonly>
 
  	</div>
 	</form>

 </body>
    <script>
    var json_data = JSON.parse('${vo}'); 
   
	var mv_name=new Array();
	var mv_apicode=new Array(); 
    const key = "f6ef5ee7d41f7b86d5ea2c50796a6dfc";  
    const base_url = "https://image.tmdb.org/t/p/original";//w300자리를 오리진으로 하면 원본사이즈
   
    function fetchMovies(name,num){
    	/////////////////////////////////////////////////////////////////
        const url = "https://api.themoviedb.org/3/search/multi?api_key="+key+"&language=ko-KR&query="+name+"&page=1&"
        fetch(url)  
        .then(res => res.json())
        .then(function(res){
             const movies = res.results; //앞으로 계획 api결과 리턴중에 결과 갯수를 표현해 주는것이 있음 그것과 비교해서 3개보다 크면 아래 작으면 그냥 ㄱ
             var newArray = movies.filter(function(x,index,ar){// 결과가 많을걸 필터링해서 3가지만 가져옴 0~2까지    	 
                 return index <=2;
             });
        		//추천수? 많은 순으로 정렬됨vote_average: 6.6
			newArray.sort(function(a,b){
				return b["vote_average"]-a["vote_average"];
			})

				    if(newArray[0]!=null)
			 			json_data[num].title=newArray[0].id
			 		else
			 			json_data[num].title=''
			 		
        })  
        .catch(erro => console.log(erro));
        ///////////////////////////////////////////// 
    };
    $(document).ready(function() {
    	
	     	for(var i =0;i<json_data.length;i++){
	    		fetchMovies(json_data[i].title,i)
	    	}
    	});
    $('#button').click(function(){
    	
    	var jsonString = JSON.stringify(json_data);
     	alert(jsonString);
     	 
     	var jsonData = JSON.parse(jsonString);
     	
     	console.log(jsonData)
     	$('#test').val(jsonString)
    })
  
    </script> 