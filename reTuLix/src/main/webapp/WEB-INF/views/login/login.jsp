<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	//아이디 저장값 추출
	
	Cookie ck[]=request.getCookies();
	String ckEmail="";

		
	//System.out.println("ck.length : "+ck.length);
	
	try{
		System.out.println("ck.length : "+ck.length);
		if(ck.length>0){
			
			for(int i=0; i<ck.length; i++){
				
			 	if(ck[i].getName().equals("saveId")){
			 		//System.out.println("for - if : "+ck[i].getValue());
					ckEmail=ck[i].getValue();
				} 
				
				/* if(ck[0].getName().equals("saveId")){
					ckEmail=ck[0].getValue();
				} */
				
				
			}
		}//--------------if-------------------------
	
	}
	catch(NullPointerException e){

		response.sendRedirect("/retulix/");

		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reTuLix</title>
<!-- 전체 기본 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/whole.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css" />
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
                <td><input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" required></td>
            </tr>
        </table><br>
        
       	<input type="checkbox" name="saveId" id="saveId" class="form-check-input"> 아이디 저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="saveLogin" id="saveLogin" class="form-check-input"> 자동 로그인<p></p>
        <button type="button" onclick="loginCheck()" id="btLogin" name="btLogin" class="button-active">로그인</button>
        <button type="button" onclick="location.href='signup'" id="btLogin2" name="btLogin2">회원가입</button><br><br>
        
        <a href="${pageContext.request.contextPath}/findUser">아이디/비밀번호를 분실하셨습니까?</a>
    </form>
    </div>
</body>
</html>

<script>
	//아이디 저장시 input 값 설정+체크박스 체크 설정
	var ckEmailExist="<%=ckEmail%>";
	if(ckEmailExist!=""){
		
		//alert("공백이 아닌경우 ckEmailExist : "+ckEmailExist);
		
		$("#email").val(ckEmailExist);
		$("#saveId").prop("checked", true);
	}else{
		
		//alert("나머지 경우 ckEmailExist : "+ckEmailExist);
		
		$("#email").val("");
		$("#saveId").prop("checked", false);
	}

	//로그인=============================================
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
	
	//엔터키로 진입 처리
	$(function(){
		$("#email, #pwd").keydown(function(key){
			if(key.keyCode==13) loginCheck();
		})
	})
</script>