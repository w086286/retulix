        function fetchMovie(qu,cking,callback){
        	const key = "f6ef5ee7d41f7b86d5ea2c50796a6dfc";
        	const base_url = "https://image.tmdb.org/t/p/original";
        	if(cking=='M')
        		{
                const url = "https://api.themoviedb.org/3/movie/"+qu+"?api_key="+key+"&language=ko-KR&append_to_response=casts"
                fetch(url) 
                .then(res => res.json())
                .then(function(res){
                	const movies = res
                	var result = new Array();
                result[0]=movies.title
                result[1]=movies.overview;
              	result[3]=base_url+movies.poster_path;
                result[4]="url("+base_url+movies.backdrop_path+")";
                tmp=movies.release_date;
                result[5]= tmp.split('-')[0];
                 for(var i in movies.casts.crew){
                	 if(movies.casts.crew[i].job=="Director")
                		 {
                		 	result[2]=movies.casts.crew[i].name;
                		 	break;
                		 }
        
                 }
            if(result[2]=='null'){
            	result[2]='null';
            }
                callback(result);
                })  
                .catch(erro => console.log(erro)); 
         
        		
        		}//if
        	else
        		{
        		 const url = "https://api.themoviedb.org/3/tv/"+qu+"?api_key="+key+"&language=ko-KR"
                 fetch(url) 
                 .then(res => res.json())
                 .then(function(res){
                 	const TV = res
                 	var result = new Array();
                 result[0]=TV.name
                 result[1]=TV.overview;
               
                 if(TV.created_by.length>0){
                	 result[2]=TV.created_by[0].name;	 
                 }
                 else{
                	 result[2]='null';
                 }
               	result[3]=base_url+TV.poster_path;
                 result[4]="url("+base_url+TV.backdrop_path+")";
                 tmp=TV.first_air_date;
                 result[5]= tmp.split('-')[0];

                 callback(result);
                 })  
                 .catch(erro => console.log(erro)); 
        		}
        	
        };  ///////////////////fe
     // result[0] 제목
     // result[1] 개요
     // result[2] 감독
     // result[3] 포스터
     // result[4] 배경
     // result[5] 개봉일
        
       
        	
           
  
