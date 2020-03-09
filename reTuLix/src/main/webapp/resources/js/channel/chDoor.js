//내 채널 페이지 진입시 chHome() 우선호출===========
$(function(){
	chHome();
})

//메뉴 버튼 처리===================================
var req=false;
var init=function(){
	try{
		req=new XMLHttpRequest();
	}catch(evt){
		try {
			req=new ActiveXObject("Mszm12.XMLHTTP");
		}
		catch(evt2)	{
			req=false;
		}
	}
	if(!req) console.log("req객체 생성 실패");
}

//홈
function chHome(){
	$.ajax({
		type:"post",
		url:"chHome.do",	//do로 보내면 properties에서 받아 controller에서 처리
		dataType:"text",
		cache:false,
		data:$("#email").serialize()+"&"+$("#pwd").serialize(),
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chHome(): "+err.status);
		}
	});
}

//내 채널 및 영상
function chStat(){
	$.ajax({
		type:"post",
		url:"chStat.do",
		dataType:"text",
		data:$("#email").serialize()+"&"+$("#pwd").serialize(),
		cache:false,
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chStat(): "+err.status);
		}
	});
}

//내 정보 및 포인트
function chInfo(){
	$.ajax({
		type:"post",
		url:"chInfo.do",
		dataType:"text",
		data:$("#email").serialize()+"&"+$("#pwd").serialize(),
		cache:false,
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chInfo(): "+err.status);
		}
	});
}

//영상 업로드
function chUpload(){
	
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

window.onload=init;