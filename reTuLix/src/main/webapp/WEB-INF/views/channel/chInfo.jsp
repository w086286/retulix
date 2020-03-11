<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<div class="infoAndPoint">
	<div class="myChannelHead">내 정보</div>
	<div>
		<form name="infoEdit" id="infoEdit" role="form" action="${pageContext.request.contextPath}/user/chInfoEdit" method="post">
		<table>
			<tr><td rowspan="4">
				<img src="${pageContext.request.contextPath}/resources/images/noUserIcon.png" style="width:120px; height:120px; border-radius:0.2em"><br>
			</td></tr>
			<tr>
				<td>이메일</td>
				<td><input class="input-readonly" type="text" readonly value="${userInfo.email}"></td>
				<td>기존 비밀번호</td>
				<td><input type="password" id="originPwd" name="originPwd"></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input class="input-readonly" type="text" readonly value="${userInfo.name}" id="name" name="name"></td>
				<td>변경 비밀번호</td>
				<td><input type="password" id="pwd" name="pwd"></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="text" style="width: 7em;" id="age" name="age" value="${userInfo.age}"> 세</td>
				<td>변경 비밀번호 확인</td>
				<td><input type="password" id="pwdCheck" name="pwdCheck"></td>
			</tr>
			<tr>
				<td><button type="button" id="btEditUserIcon" name="btEditUserIcon">내 아이콘 변경</button></td>
				<td colspan="4">
					<button type="button" class="button-active" id="btInfoEdit" name="btInfoEdit">내 정보 수정</button>
					<button type="button" class="button-inactive" id="btUserDrop" name="btUserDrop">탈퇴</button>
				</td>
			</tr>
		</table>
		</form>
	</div>
	
	<div class="myChannelHead">내 포인트</div>
	<div>
		<table>
			<tr>
				<td rowspan="5">
					보유 포인트<p></p>
					<i class="fab fa-product-hunt" style="font-size: 4.5em;"></i><p></p>
					${userInfo.point} <i class="fab fa-product-hunt"></i>
				</td>
			</tr>
			<tr>
				<td>획득 포인트</td>
				<td>${userInfo.point} <i class="fab fa-product-hunt"></i></td>
			</tr>
			<tr>
				<td>사용 포인트</td>
				<td>${userInfo.point} <i class="fab fa-product-hunt"></i></td>
			</tr>
			<tr>
				<td>누적 포인트</td>
				<td>${userInfo.point} <i class="fab fa-product-hunt"></i></td>
			</tr>
			<tr>
				<td colspan="2">
					<button class="button-active">충전</button>
					<button class="button-inactive">환전</button>
				</td>
			</tr>
		</table>
	</div>
</div>

<!-- 회원 아이콘 변경 모달 -->
<form name="iconEdit" id="iconEdit" role="form" action="/user/iconEdit" method="post" enctype="multipart/form-data">
<div id="EditUserIcon" class="chImgModal">
	<div class="chImgModal-content">
		<p>내 아이콘 변경
			<i class="chImgModalClose fa fa-times" id="chImgModalClose"></i>
		<p>
		
		<input type="file" name="btUpUserIcon" id="btUpUserIcon"><br>
		
		<button type="button" class="button-active" id="userIconEdit" name="userIconEdit">적용</button>
		<button type="button" class="button-inactive">취소</button>
		<span>
			채널 이미지 권장 크기: 500 X 500 픽셀<br>
			최대 파일 크기 : 6MB
		</span>
	</div>
</div>
</form>

<script type="text/javascript">
$(function(){
	//[수정]수정 버튼 이벤트=======================================
	$("#btInfoEdit").click(function(){
		var originPwd=$("#originPwd").val();
		var pwd=$("#pwd").val();
		var pwdCheck=$("#pwdCheck").val();
	
		if(originPwd==""){
			alert("현재 비밀번호를 입력해야 정보 수정이 가능합니다");
			reqReject("originPwd")
			return;
		}
		if(pwd!="" || pwdCheck!=""){
			if(pwd=="" || pwdCheck=="" || pwd!=pwdCheck){
				alert("변경할 비밀번호를 동일하게 입력하세요");
				reqReject("pwd");
				return;
			}
			var yn=confirm("정말 비밀번호를 변경하시겠습니까?");
			if(yn==true) $("#infoEdit").submit();
			else return;
		}
		infoEdit.submit();
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
	
	//[탈퇴]=================================================
	$("#btUserDrop").click(function(){
		var originPwd=$("#originPwd").val();		
		if(originPwd==""){
			alert("탈퇴하시려면 현재 비밀번호를 입력하세요");
			reqReject("originPwd");
			return;
		}
		
		var path = window.location.pathname;	//프로젝트 경로 추출: retulix/user/channel
		var yn=confirm("정말 탈퇴하시겠습니까? 탈퇴 후에는 재가입해야 이용할 수 있습니다");
		if(yn){	//y==true
			infoEdit.action=path+"/userDrop";
			infoEdit.submit();
		}else{
			return;
		}
	})
	
	//[아이콘변경]아이콘 변경 버튼 클릭시 모달 팝업=========================
	$("#btEditUserIcon").on("click", function(){
		$("#EditUserIcon").css("display","block");
	})
	
	//[아이콘변경]적용 버튼 클릭시
	$("#userIconEdit").click(function(){
		
		$("#iconEdit").submit();
	})
	
});
</script>