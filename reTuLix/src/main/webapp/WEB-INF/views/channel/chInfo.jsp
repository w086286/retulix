<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<div class="infoAndPoint">
	<div class="myChannelHead">내 정보</div>
	<div>
		<form name="infoEdit" id="infoEdit" role="form" action="${pageContext.request.contextPath}/user/chInfo" method="post">
		<table>
			<tr><td rowspan="4">
				<c:if test="${loginUser.icon eq 'noicon.png'}">
					<img src="${pageContext.request.contextPath}/resources/images/noUserIcon.png" style="width:120px; height:120px; border-radius:0.2em"><br>
				</c:if>
				<c:if test="${loginUser.icon ne 'noicon.png'}">
					<img src="${pageContext.request.contextPath}/resources/images/${loginUser.icon}" style="width:120px; height:120px; border-radius:0.2em"><br>
				</c:if>
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
<form name="iconEdit" id="iconEdit" role="form" action="${pageContext.request.contextPath}/user/iconEdit" method="post" enctype="multipart/form-data">
<div id="EditUserIcon" class="chImgModal">
	<div class="chImgModal-content">
		<p>내 아이콘 변경
			<i class="fa fa-times" id="btIconEditModalClose"></i>
		</p>
		
		<input type="file" name="iconFile" id="iconFile"><br>
		
		<button type="button" class="button-active" id="userIconEdit" name="userIconEdit">적용</button>
		<button type="button" class="button-inactive" onclick="iconEditModalClose()">취소</button>
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
			var yn=confirm("정말 비밀번호를 변경하시겠습니까? 변경 후에는 다시 로그인해야 합니다.");
			if(yn==true) $("#infoEdit").submit();
			else return;
		}
		
		//infoEdit.submit();
		//form submit ajax로 처리
		var formData=$("#infoEdit").serialize();
		$.ajax({
            url : "${pageContext.request.contextPath}/user/chInfo",	//이 url로 데이터 전송함
            type : 'POST',
            data : formData,
            dataType:"json",
			cache : false,
            success:function(res) {
                //정보 수정 성공==T
                if(res.result=="true"){
                	alert(res.msg);
                	//비밀번호 변경시 자동 로그아웃
                	if(res.pwdEdited=="pwdEdited") location.href="${pageContext.request.contextPath}/login";
                	//비밀번호 미변경시 페이지 갱신
                	else{
                		var url="${pageContext.request.contextPath}/user/chInfo";
                		chInfo(url);
                	}
                		//window.location.reload();
                }else{
                	alert(res.msg);
                	reqReject("originPwd");
                }
            }, 
            error:function(err) {
                alert(err.status);
            }
		});
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
		
		//var path = window.location.pathname;	//프로젝트 경로 추출: retulix/user/channel
		var yn=confirm("정말 탈퇴하시겠습니까? 탈퇴 후에는 재가입해야 이용할 수 있습니다");
		if(yn){	//y==true
			infoEdit.action="${pageContext.request.contextPath}/user/userDrop";
			infoEdit.submit();
		}else{
			return;
		}
	})
	
	//[아이콘변경]아이콘 변경 버튼 클릭시 모달 팝업=========================
	$("#btEditUserIcon").on("click", function(){
		$("#EditUserIcon").css("display","block");
		$("html, body").scrollTop(0);
	})
	//모달 창 닫기 [X]버튼 처리
	$("#btIconEditModalClose").on("click", function(){
		$("#EditUserIcon").css("display","none");
	})
	
	//[아이콘변경]적용 버튼 클릭시
	$("#userIconEdit").click(function(){
		var formData=$("#iconEdit").serialize();
		$.ajax({
            url : "${pageContext.request.contextPath}/user/iconEdit",	//이 url로 데이터 전송함
            type : 'POST',
            data : formData,
            dataType:"json",
			cache : false,
            success:function(res) {
               	alert("아이콘이 성공적으로 변경되었습니다.");
/*                if(res=="iconEditTrue"){
               		var url="${pageContext.request.contextPath}/user/chInfo";
               		chInfo(url);
                }else{
                	alert("다시 시도해주세요.");
                } */
            }, 
            error:function(err) {
                alert(err.status);
            }
		});
	})
	
});
//모달 취소 버튼 처리
function iconEditModalClose(){
	EditUserIcon.style.display="none";
}

//:::내 정보 및 포인트 진입 함수: js 모두 합치고 지우기::::::::::::::::::::::::::::
function chInfo(url){
	$.ajax({
		type:"get",
		url:url,
		dataType:"text",
		cache:false,
		success: function(res){
			$("#chArticle").html(res);
		},
		error:function(err){
			console.log("error @chDoor.jsp/chInfo(): "+err.status);
		}
	});
}
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
</script>