<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>reTuLix</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/whole.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/signUp.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%
	response.addHeader("Access-Control-Allow-Origin", "*");
	response.addHeader("Access-Control-Allow-Headers", "origin, x-request-with, content-type, accept");

	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
%>

<script>


	var emailFlag = false;
	var pwdFlag = false;
	var ageFlag = false;

	var emailCheck = function() {

		var useremail = $('#useremail').val();
		
				$.ajax({
					url : 'checkemail?inputemail=' + useremail,
					type : 'get',
					cache : false,
					dataType : "json",
					success : function(data) {
						console.log("1=중복 / 0=중복아님 : " + data);
						
						//이메일 중복체크
						if (data.userEmailCheck == 0) {
							$("#emailCheck").text("사용가능한 이메일입니다.");
							$("#emailCheck").css("color", "red");
							emailFlag = true;
						} else {
							$("#emailCheck").text("사용중인 이메일입니다.");
							$("#emailCheck").css("color", "red");
							emailFlag = false;
						}
						
						//이메일 유효성 검사
						var emailcheck = /^[a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
						if (emailcheck.test(useremail)) {
							return true;
						} else {
							$("#emailCheck").text("이메일 형식에 맞지 않습니다.");
							$("#emailCheck").css("color", "red");
							emailFlag = false;
						}
					}//success : function(data){

				})//    $.ajax({

	}//var emailCheck=function(){	

	//비밀번호 체크 
	$(document).ready(function() {
		$('#inputPwd').keyup(function() {
			var passwd = $('#inputPwd').val();
			var passwdcheck = $('#inputPwd2').val();

			if (passwd == passwdcheck) {
				$('#PwdCheck').text('동일한 비밀번호 입니다.');
				$("#PwdCheck").css("color", "red");
				pwdFlag = true;
			} else if (passwd != passwdcheck) {
				$('#PwdCheck').text('동일하지 않은 비밀번호 입니다.');
				$("#PwdCheck").css("color", "red");
				pwdFlag = false;
			}			
		})
	})
	//비밀번호 확인 체크
	$(document).ready(function() {
		$('#inputPwd2').keyup(function() {
			var passwd = $('#inputPwd').val();
			var passwdcheck = $('#inputPwd2').val();

			if (passwd == passwdcheck) {
				$('#PwdCheck').text('동일한 비밀번호 입니다.');
				$("#PwdCheck").css("color", "red");
				pwdFlag = true;
			} else if (passwd != passwdcheck) {
				$('#PwdCheck').text('동일하지 않은 비밀번호 입니다.');
				$("#PwdCheck").css("color", "red");
				pwdFlag = false;
			}
		})
	})

	//나이 정규식 체크
	$(document).ready(function() {
		$('#age').keyup(function() {
			var age = $('#age').val();
			var agecheck = /^[1-9+][0-9]{0,1}$/;

			if (agecheck.test(age)) {
				$("#AgeCheck").text("");
				$("#AgeCheck").css("color", "red");
				ageFlag = true;
			} else {
				$("#AgeCheck").text("나이형식에 맞지 않습니다.");
				$("#AgeCheck").css("color", "red");
				ageFlag = false;
			}
		})
	})

	//onsubmit 체크
	var validate = function() {
		if (!emailFlag) {
			alert('이메일을 다시 확인해주세요.');
			return false;
		}
		if (!pwdFlag) {

			alert('비밀번호가 일치하지 않습니다.')
			$("#inputPwd").val("");
			$("#inputPwd2").val("");
			return false;
		}
		if (!ageFlag) {
			alert('나이를 다시 확인해주세요')
			return false;
		}
		return true;
	}
</script>

</head>

<body>

	<div class="signup">
		<a href="/retulix"><h1 class="head">reTuLix</h1></a>

		<form class="form-horizontal" id="f" role="form" action="signup"
			method="post" onsubmit="return validate()">

			<div class="form-group">
				<div>
					<label for="inputemail" class="control-label">이메일 </label>
				</div>
				<div>
					<input type="text" onchange="emailCheck()" class="form-control"
						name="email" id="useremail" placeholder="이메일 형식에 맞게 작성하세요"
						required>
					<span class="check" id="emailCheck"></span>
				</div>
			</div>

			<div class="form-group">
				<div>
					<label for="inputPassword" class="control-label">비밀번호</label>
				</div>
				<div>
					<input type="password" class="form-control" name="pwd"
						id="inputPwd" placeholder="" required>
				</div>
			</div>
			
			<div class="form-group">
				<div>
					<label for="inputPassword2" class="control-label">비밀번호 확인</label>
				</div>
				<div>
					<input type="password" class="form-control" id="inputPwd2"
						placeholder="" required> <span class="check" id="PwdCheck"></span>
				</div>
			</div>

			<div class="form-group">
				<div>
					<label for="inputname" class="control-label">이름</label>
				</div>
				<div>
					<input type="text" class="form-control" name="name" id="name"
						placeholder="" required>
				</div>
			</div>

			<div class="form-group">
				<div>
					<label for="inputname" class="control-label">나이</label>
				</div>
				<div>
					<input type="text" class="form-control" name="age" id="age"
						placeholder="1~99사이를 입력하세요" required> <span class="check" id="AgeCheck"></span>
				</div>
			</div>

			<div class="">
				<div>
					<button type="submit" id="submitbt" class="signUpButton">가입
						하기</button>

				</div>
			</div>


		</form>
	</div>

</body>
</html>
<jsp:include page="../foot.jsp" />