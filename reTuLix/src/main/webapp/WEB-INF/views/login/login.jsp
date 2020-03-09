<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String key="";
	String saveId="";
	String saveLogin="";
	boolean saveIdFlag=false;
	boolean saveLoginFlag=false;
	
	Cookie[] cks=request.getCookies();
	if(cks!=null){
		for(Cookie c:cks){
			key=c.getName();
			if(key.equals("saveId")){
 			saveId=c.getValue();
 			saveIdFlag=true;
 			break;
			} else {
				saveIdFlag=false;
			}
		}
	}
 %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reTuLix</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/whole.css" />		<!-- 전체 기본 스타일 -->
<style>
    .login{
        text-align: center;
        line-height: 3em;
    }
    .login table{
        display: inline-table;
        text-align: center;
    }
    .login img{
        margin-top: 8em;
        height: 12em;
    }
    .login a:hover{
        color: rgb(209, 0, 0);
    }
</style>
</head>

<body>
    <div class="login">
	<form name="loginF" id="loginF" action="${pageContext.request.contextPath}/login" method="post">
        <img src="${pageContext.request.contextPath}/resources/images/logo-col.png"><br><br>
        <table>
            <tr>
                <td>아이디</td>
                <td>
                    <input type="text" id="email" name="email" placeholder="아이디를 입력하세요" required>
                </td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td>
                    <input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" required>
                </td>
            </tr>
        </table><br>
        <input type="checkbox" name="saveId" id="saveId" value="Y" class="form-check-input"> 아이디 저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="saveLogin" id="saveLogin" value="Y" class="form-check-input"> 자동 로그인<p></p>
        <button type="button" onclick="loginCheck()" id="btLogin" name="btLogin" class="button-active">로그인</button>
        <!-- <button type="button" onclick="loginCheck()" id="btJoin" name="btJoin">회원가입</button><br><br> -->
        <a href="#">아이디/비밀번호를 분실하셨습니까?</a>
    </form>
    </div>
</body>
</html>

<script>
	/*
	function loginCheck(){
		var userData={
			"email":$("#email").val(),
			"pwd":$(#pwd).val(),
			"isSaveId":$("#saveId").prop("checked")==true? "Y":"N"
			"isSaveLogin":$("#saveLogin").prop("checked")==true? "Y":"N"
		};
		
		$.ajax({
			type:"post",
			url:"/login",
			data:userData,
			dataType:"json",
			success:function(res){
				if(res.status==0){
					alert(JSON.stringify(res));
					window.location.href="/";
				}else if(res.status==1){
					alert(JSON.stringify(res));
				}
			},
			error:function(err){
				alert("error: "+err.status);
			}
		});
	}
	*/
	function loginCheck() {
		if (!loginF.email.value) {
			alert("아이디를 입력하세요. 아이디는 이메일 형식입니다.");
			loginF.userid.focus();
			return;
		}
		if (!loginF.pwd.value) {
			alert("비밀번호 입력하세요.");
			loginF.pwd.focus();
			return;
		}
		loginF.submit();
	}
</script>