<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>reTuLix</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/whole.css" /> <!-- 전체 기본 스타일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signUp.css" /> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%
	//contentType은 "application/json"으로 지정한다.
	//CORS 문제 해결을 위해
	//1. PROXY객체를 만드는 방법
	//2. JSONP 를 이용하는 방법
	//3. 서버쪽에서 헤더에 Access-Control-Allow-Origin 등의 설정을 하는 방법
	response.addHeader("Access-Control-Allow-Origin","*");
	response.addHeader("Access-Control-Allow-Headers", "origin, x-request-with, content-type, accept");
	
	request.setCharacterEncoding("UTF-8");
	String email=request.getParameter("email");

	//DB와 연결하여 데이터 insert후 그 결과를  json형태로 만들어 응답한다.

%>

<script>
function chkEmail(str) {
    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (regExp.test(str)) return true;
    else return false;
}

//이메일 중복체크
$(document).ready(function(){
   $('#useremail').blur(function(){  
	  /* var emailCheck=function(){ */
    var useremail =$('#useremail').val();
   /*  alert('checkemail?inputemail'+useremail);  */
    $.ajax({
      url : 'checkemail?inputemail='+useremail,
      type : 'get',
      cache: false,
      dataType: "json",
      success : function(data){
        console.log("1=중복 / 0=중복아님 : " +data);
       /*  alert(JSON.stringify(data)); */
        if(data.userEmailCheck==1){
          $("#emailCheck").text("사용중인 이메일입니다.");
          $("#emailCheck").css("color","red");
          $("#submit").attr("disabled", true);
        }else{
          $("#emailCheck").text("사용가능");
          $("#emailCheck").css("color","red");
          $("#submit").attr("disabled", false);
        }
        
      }
    })
  })
 })
 
 
 
 
 //비밀번호 일치 체크 
 $(document).ready(function(){
 $('#inputPwd2').keyup(function(){

   var passwd = $('#inputPwd').val();

   var passwdcheck = $('#inputPwd2').val();

   if(passwd == passwdcheck){

      passCheck = true;

      $('#PwdCheck').text('동일한 비밀번호 입니다.');

   }else{

      passCheck = false;

      $('#PwdCheck').text('동일하지 않은 비밀번호 입니다.');
      $("#submit").attr("disabled", true).alert("ss");

   }

})
 })
</script>

</head>

<body>

    <div class="signup">
      <h1 class="head">reTuLix ${userEmailCheck}</h1>
 
          
          
            <form class="form-horizontal" role="form" action="signupEnd.jsp" method="post" onsubmit="return check()">
            
            
              
              <div class="form-group">
                <div>
                  <label for="inputemail" class="control-label" >이메일 </label>
                </div> 
                
                <div>
                  <input type="text" class="form-control" name="useremail" id="useremail" placeholder="이메일 형식에 맞게 작성하세요" required>
                  <span class="check" id="emailCheck"></span>
                </div>
                
                <!-- <div class="col-sm-2">
								<button type="button" onclick="emailCheck()" class="btn btn-danger">중복체크</button>
								
				</div> -->
              </div>
              
            
              <div class="form-group">
                <div>
                  <label for="inputPassword" class="control-label">비밀번호</label>
                </div>
                <div>
                  <input type="password" class="form-control" name="pwd" id="inputPwd" placeholder="" required>
                </div>
              </div>
              <div class="form-group">
                <div>
                  <label for="inputPassword2" class="control-label">비밀번호 확인</label>
                </div>
                <div>
                  <input type="password" class="form-control" id="inputPwd2" placeholder="" required>
                  <span class="check" id="PwdCheck"></span>
                </div>
              </div>
              
                <div class="form-group">
                <div>
                  
                  <label for="inputname" class="control-label">이름</label>
                </div>
                <div>
                  <input type="text" class="form-control" name="name" id="name" placeholder="" required>
                </div>
              </div>
              
                <div class="form-group">
                <div>
                  
                  <label for="inputname" class="control-label">나이</label>
                </div>
                <div>
                  <input type="text" class="form-control" name="name" id="name" placeholder="" required>
                </div>
              </div>
            
              <div class="">
                <div>
                  <button type="submit" id="submit" class="signUpButton">가입 하기</button>
                 
                </div>
              </div>
              
              
            </form>
          </div>

</body></html>
<jsp:include page="../foot.jsp" />