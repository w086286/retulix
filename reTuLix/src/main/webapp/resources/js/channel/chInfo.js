$(function(){
	//로그인한 회원 정보
	var email=$("#email").val();
	var pwd=$("#pwd").val();

	//[수정]수정 버튼 이벤트
	$("#btInfoEdit").click(function(){
		var originPwd=$("#originPwd").val();
		var editPwd=$("#editPwd").val();
		var editPwdCheck=$("#editPwdCheck").val();
		
		if(originPwd==""){
			alert("현재 비밀번호를 입력해야 정보 수정이 가능합니다");
			reqReject("originPwd")
			return;
		}
		var comp=(pwd==originPwd);
		if(comp==false){
			alert("현재 비밀번호와 일치하지 않습니다");
			reqReject("originPwd");
			return;
		}
		if(editPwd!="" || editPwdCheck!=""){
			if(editPwd==""){
				alert("변경할 비밀번호를 입력하세요");
				reqReject("editPwd");
				return;
			}
			else if(editPwd!=editPwdCheck){
				alert("변경할 비밀번호와 동일하게 입력하세요");
				reqReject("editPwdCheck");
				return;
			}
			var yn=confirm("정말 비밀번호를 변경하시겠습니까?");
			if(yn==true) $("#infoEdit").submit();
			else return;
		}
		$("#infoEdit").submit();
	})
	
	//[수정]생년월일 정규식 검사
	$("#age").blur(function(){
		var check=checkAge($("#age").val());
		if(check==false) {
			alert("2자리수로 입력하세요");
			reqReject("age");
			return;
		}
	})
	
	//[아이콘변경]아이콘 변경 버튼 클릭시 모달 팝업
	$("#btEditUserIcon").on("click", function(){
		$("#EditUserIcon").css("display","block");
	})
	
	//[아이콘변경]적용 버튼 클릭시
	$("#userIconEdit").click(function(){
		
		$("#iconEdit").submit();
	})
	
	//[탈퇴]
	$("#btUserDrop").click(function(){
		var originPwd=$("#originPwd").val();		
		if(originPwd==""){
			alert("탈퇴하시려면 현재 비밀번호를 입력하세요");
			reqReject("originPwd")
			return;
		}
		var comp=(pwd==originPwd);
		if(comp==false){
			alert("현재 비밀번호와 일치하지 않습니다");
			reqReject("originPwd");
			return;
		}
		
		var yn=confirm("정말 탈퇴하시겠습니까? 탈퇴 후에는 재가입해야 이용할 수 있습니다");
		if(yn){	//y==true
			$("#userDrop").submit;
		}else{
			return;
		}
	})
	
});

//[아이콘변경]드래그앤드롭
function dragDrop(evt) {
	var dt=event.dataTransfer;
	var files=dt.files;
	var iCount=files.length;
	var iType, iName, iSize;
	
	if(iCount>1) {
		alert("파일 1개만 업로드 할 수 있습니다");
		return;
	}

	for (var i=0; i<iCount; i++) {
		iName=files[i].name;	//파일명
		iSize=files[i].size;	//파일크기
	}
}
/*function output(text) {
  document.getElementById("dndUserIcon").textContent += text;
}*/

//[수정]나이 유효성 체크: val != pattern --> F 반환
function checkAge(val){
	if(val.length==1) val="0"+val;
	var pattern=/\b[0-9]{1,2}\b/;
	return pattern.test(val);
}
//[수정]유효성 체크 F시 포커스
function reqReject(obj){
	$("#"+obj).val("");
	
	if($("#"+obj).val()=="") $("#"+obj).css("border", "2px solid red");
	$("#"+obj).keydown(function(){
		if($("#"+obj).val()!="") {
			$("#"+obj).css("border", "none");
		}
	})
	setTimeout(function(){		//blur 이벤트 처리시 focus() 무한루프 에러 --> setTimeOut()으로 처리
		$("#"+obj).focus();
	})
}