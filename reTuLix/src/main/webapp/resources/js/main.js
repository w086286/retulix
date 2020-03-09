	//라이트 슬라이더 반응형 사진 개수 조절
           $(document).ready(function() {
            $(".content-slider").lightSlider({
            item:9,
            loop:true,
            keyPress: true,
            easing: 'cubic-bezier(0.25, 0, 0.25, 1)',
            responsive : [
            	{
                    breakpoint:1845,
                    settings: {
                        item:10,
                      }
                },
                {
                    breakpoint:1760,
                    settings: {
                        item:8,
                      }
                },
                {
                    breakpoint:1565,
                    settings: {
                        item:7,
                      }
                },
                {
                    breakpoint:1410,
                    settings: {
                        item:6,
                      }
                },
                {
                    breakpoint:1350, 
                    settings: {
                        item:5,
                      }
                },
                {
                    breakpoint:1085,
                    settings: {
                        item:4,
                      }
                },
                {
                    breakpoint:930,
                    settings: {
                        item:3,
                      }
                },
                {
                    breakpoint:780,
                    settings: {
                        item:2,
                      }
                },
                {
                    breakpoint:650,
                    settings: {
                        item:1,
                      }
                }
            ]
        });  
      });
/* var SF=['2001 스페이스 오디세이.jpg',
'그래비티.jpg',
'레디 플레이어 원.jpg',
'마션.jpg',
'배틀쉽.jpg',
'아이 로봇.jpg',
'애드아스트라.jpg',
'엘리시움.jpg',
'엣지 오브 투모로우.jpg',
'오블리비언.jpg',
'인디펜던스 데이 리써전스.jpg',
'인타임.jpg',
'인터스텔라.jpg',
'터미네이터 다크 페이트.jpg',
'투모로우.jpg',
'패신저스.jpg',
'퍼스트맨.jpg',
'프로메테우스.jpg',
'픽셀.jpg',
'혹성탈출 종의전쟁.jpg',
];

$(function(){
    const movies = [];
    let n=''
    var str='';
    *//**중복없는 랜덤(공통)--------------------------------------------------------- *//*
    function moviesNum () {
    
    function makeNum () {
    if (movies.length < 20) {
    n = Math.floor(Math.random() * 20);
    if (notSame(n)) {
    movies.push(n);
    }
    makeNum();
    }
    function notSame (n) {
    return movies.every((e) => n !== e);
    }
    }
    makeNum();
    return movies;
    
    }
    moviesNum();
    *//**중복없는 랜덤(공통)--------------------------------------------------------- *//*

    *//**분류별로--------------------------------------------------------------- *//*
  
    for(var i=0;i<SF.length;i++){
        str+='<div class="col-6 col-lg-2 animate-in-down"><a href="'+[movies[i]]+'"><img src="포스터/SF 영화/'
        +SF[movies[i]]+'" class="center-block img-fluid my-3" height="230px"></a></div>';
    console.log(movies[i])
    $('#mvs').html(str);
    }
    })
    
 */



    


