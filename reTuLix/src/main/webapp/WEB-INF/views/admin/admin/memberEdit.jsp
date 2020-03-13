<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:import url="/admin/adminTop"/>

<!-- -------------------------------------------------------- -->
<style>
input {
	text-align:center;
}
</style>

<div class='box'>
	<h1 class='head'>회원정보 수정</h1>
</div>
<div class='outer test-outline'>
<div class=tableContainer>
	<form name='memberInfoForm' action='memberEdit' method='POST'>
	<table class='table' style='max-width:700px;'>
		<tr>
			<td><label for="email">Email</label></td>
			<td width='300px' align='left'><label name="email">${member.email}</label></td>
		</tr>
		<tr>
			<td><label for="name">이름</label></td>
			<td align='left'><input name="name" type="text" value='${member.name }'></td>
		</tr>
		<tr>
			<td><label for="age">나이</label></td>
			<td align='left'><input name="age" type="text" value='${member.age }' readonly></td>
		</tr>
		<tr>
			<td><label for="point">포인트</label> </td>
			<td align='left'>
				<input name="point" type="text" value='${member.point }'> 
				<label class='label' style='background-color:darkred; border-radius:30%; margin-left:20px;'>point</label>
			</td>
		</tr>
		<tr>
			<td><label for="state">회원상태</label></td>
			<td align='left'>
				<select id='state' name="state" style='width:180px; padding-left:20%;'>
					<!-- 당신의 회원상태 동적으로 할당되었다 아래스크립트에 -->
				</select>
			</td>
		</tr>
	</table>
	<%-- 히든으로 전송할 목록 --%>
	<input type='hidden' name='email' id='email' type='text' value='${member.email }'>
	<input type='hidden' name='oldName' id='oldName' type='text' value='${member.name }'>
	<input type='hidden' name='oldPoint' id='oldPoint' type='text' value='${member.point}'>
	<input type='hidden' name='oldState' id='oldState' type='text' value='${member.state}'>
	</form>

	<div class='box right' style='padding-right:4em;'>
		<button type="button" onclick='goConfirm()'>수정</button>
		<button type="button" onclick='javascript:history.back()'>취소</button>
		<button type='button' onclick='goDel()' class='button' style='background-color:darkred;'>회원정보 삭제</button>
	</div>
</div>
</div>

<!-- -------------------------------------------------------- -->
<script>

$(function(){});
//동적으로 회원상태 할당하기

var stateName=['일   반','특   별','정   지','탈   퇴','관리자'];
var stateVal=[0,1,-1,-2,99];
var str=``;
for(var i=0; i<stateName.length; i++) {
	if(stateName[i] == "${member.state}") {
		str+="<option value='"+stateVal[i]+"' selected>"+stateName[i]+"</option>";			
	}
	else {
		str+="<option value='"+stateVal[i]+"'>"+stateName[i]+"</option>";			
	}
}

$('#state').html(str);

//기존회원정보 저장
//input 아래 히든 input에다 저장해둠(각 항목)

//수정버튼
function goConfirm() {
	memberInfoForm.submit();
}
function goDel(){
	var check= confirm("회원정보를 정말로 삭제하시겠습니까?\n"
				+"개인정보 보호법에 의하여 가입 후 1년 미만의 회원정보는 삭제하실 수 없습니다");
	if(check){
		memberInfoForm.action="memberDelete";
		memberInfoForm.submit();
	}
	else {
		alert("삭제처리가 취소되었습니다");
		return;
	}
}

</script>
<!-- -------------------------------------------------------- -->

<c:import url="/foot"/>