<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/top" />

<script type="text/javascript" src="./js/channel/chDoor.js"></script>
<link rel="stylesheet" href="./css/channel.css" />

<!-- 진입 테스트 회원 정보:::::::::::나중에 삭제 -->
<div style="display:none">
<input id="email" name="email" value="nofootbird@gmail.com">
<input id="pwd" name="pwd" value="123">
</div>
<!-- :::::::::::::::::::::::::::::::::::::::: -->

<div class="channelImage">
	<img src="${pageContext.request.contextPath}/resources/images/channel/noChImg.png" alt="channelImage">
	<button class="button-active" id="changeChImg">이미지 변경</button>
</div>

<div class="channelMenu">
	<button class="button-active" onclick="chHome()" id="btChHome">홈</button>
	<button onclick="chStat()" id="btChStat">내 채널 및 영상</button>
	<button onclick="chInfo()" id="btChInfo">내 정보 및 포인트</button>
	<button class="button-active" onclick="chUpload()"  id="btChUpload">영상 업로드</button>
</div>

<div id="chArticle"></div>

<!-- 채널 이미지 변경 모달 -->
<div id="chImgModal" class="chImgModal">
	<div class="chImgModal-content">
		<p>
			사진 업로드
			<i class="chImgModalClose fa fa-times" id="chImgModalClose"></i>
		<p>
		<div>
			사진을 여기로 드래그합니다.<br>
			<br>
			드래그 앤 드롭이 싫으시면...<br>
			<button>컴퓨터에서 사진 찾기</button>
		</div>
		<br>
		<button class="button-active">적용</button>
		<button class="button-inactive" onclick="chImgModalClose()">취소</button>
		<span>
			채널 이미지 권장 크기: 1650 X 200 픽셀<br>
			최대 파일 크기 : 6MB
		</span>
	</div>
</div>

<c:import url="/foot" />