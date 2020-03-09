<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- <%@ page import="channel.persistence.*" %> --%>

<script type="text/javascript" src="./js/channel/chInfo.js"></script>

<% String ctx=request.getContextPath(); %>

<div class="infoAndPoint">
	<div class="myChannelHead">내 정보</div>
	<div>
		<form name="infoEdit" id="infoEdit" role="form" action="chInfoEdit.do" method="POST">
		<!-- 진입 테스트 회원 정보:::::::::::나중에 삭제 -->
		<div style="display:none">
		<input id="email" name="email" value="hi@gmail.com">
		<input id="pwd" name="pwd" value="123">
		</div>
		<!-- :::::::::::::::::::::::::::::::::::::::: -->
		<table>
			<tr>
				<td rowspan="4">
					<img src="<%=ctx%>/images/channel/channel_image.png" style="width:120px; height:120px; border-radius:0.2em"><br>
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input class="input-readonly" type="text" readonly value="${userInfo.email}"></td>
				<td>기존 비밀번호</td>
				<td>
					<input type="password" id="originPwd" name="originPwd">
					<label class="pwdAlert" id="pwdAlert" name="pwdAlert"></label>
				</td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input class="input-readonly" type="text" readonly value="${userInfo.name}" id="name" name="name"></td>
				<td>변경 비밀번호</td>
				<td>
					<input type="password" id="editPwd" name="editPwd">
					<label class="pwdAlert" id="pwdAlert" name="pwdAlert"></label>
				</td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="text" style="width: 7em;" id="age" name="age" value="${userInfo.age}"> 세</td>
				<td>변경 비밀번호 확인</td>
				<td>
					<input type="password" id="editPwdCheck" name="editPwdCheck">
					<label class="pwdAlert" id="pwdAlert" name="pwdAlert"></label>
				</td>
			</tr>
			<tr>
				<td>
					<button type="button" id="btEditUserIcon" name="btEditUserIcon">내 아이콘 변경</button>
				</td>
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
<form name="iconEdit" id="iconEdit" role="form" action="iconEditEnd.do" method="post" enctype="multipart/form-data">
<div id="EditUserIcon" class="chImgModal">
	<div class="chImgModal-content">
		<p>
			사진 업로드
			<i class="chImgModalClose fa fa-times" id="chImgModalClose"></i>
		<p>
		<div id="dndUserIcon" 
		     ondragenter="document.getElementById('dndUserIcon').textContent = ''; event.stopPropagation(); event.preventDefault();"
		     ondragover="event.stopPropagation(); event.preventDefault();"
		     ondrop="event.stopPropagation(); event.preventDefault(); dragDrop(event);">
		     <!-- dragenter : 드래그 요소가 특정 영역에 들어갔을 경우 호출
				  dragover : 드래그 요소가 특정 영역에 있을 경우 호출
				  drop : 드래그 요소가 드롭되었을 경우 호출 -->
			사진을 여기로 드래그합니다.<br>
			<br>
			드래그 앤 드롭이 싫으시면...<br>
			<input type="file" name="btUpUserIcon" id="btUpUserIcon">
		</div>
		<div>
		</div>
		<br>
		<button type="button" class="button-active" id="userIconEdit" name="userIconEdit">적용</button>
		<button type="button" class="button-inactive">취소</button>
		<span>
			채널 이미지 권장 크기: 1650 X 200 픽셀<br>
			최대 파일 크기 : 6MB
		</span>
	</div>
</div>
</form>