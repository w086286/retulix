<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--구독 리스트 boardList.jsp참고할것  -->
<% String ctx=request.getContextPath(); %>

<!-- 상단바====================================================================== -->
<div id="wrap">
	<ul class="topNav">
		<li class="topNavLeft" id="menuToggle"><i class="fa fa-bars"></i></li>
		<li class="topNavLeft"><a href="${pageContext.request.contextPath}/index"><img src="${pageContext.request.contextPath}/resources/images/logo-row.png" alt="logo" class="retulix_logo"></a></li>

		<li class="topNavLeft"><a href="#">영화</a></li>
		<li class="topNavLeft"><a href="#">TV프로그램</a></li>
		<li class="topNavSearch">
			<form action="">
				<input id="searchbar" type="text" name="search"
					placeholder="검색어를 입력하세요"> <i class="fa fa-search"></i>
			</form>
		</li>

		<li class="topNavRight"><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
		<li class="topNavRight"><a href="${pageContext.request.contextPath}/chDoor"><i class="fa fa-cog"></i></a></li>
		<li class="topNavRight"><a href="${pageContext.request.contextPath}/admin"><i class="fa fa-star"></i></a></li>
	</ul>
</div>

<!-- 좌측바====================================================================== -->
<div id="wrap">
	<!-- topNav에 가려지는 부분 -->
	<div class="topNavFloor"></div>

	<div class="sideNav">
		<!-- .sideNav============== -->
		<!-- 상단 로그인 회원 정보 -->
		<div class="sideNavInfo">
			<span> <img src="${pageContext.request.contextPath}/resources/images/noUserIcon.png" alt="회원 이미지" />
			</span>
			<h1>${loginUser.name}</h1>
			<p>일반회원</p>
		</div>

		<!-- 중앙 메뉴 -->
		<div class="sideNavMenu">
			<ul>
				<li><a href="#"> <span class=""><i
							class="fa fa-home"></i>홈</span>
				</a></li>
				<li><a href="#"> <span class=""><i
							class="fa fa-star"></i>최근 인기 영상</span>
				</a></li>
				<li><a href="#"> <span class=""><i
							class="fa fa-reply"></i>최근에 본 영상</span>
				</a></li>
				<li><a href="#"> <span class=""><i
							class="fa fa-heart"></i>나중에 볼 영상</span>
				</a></li>
			</ul>

			<hr>

			<!-- 구독 리스트: 첫 로드시 최대 4행 -->
			<ul class="subscribe">
				<span class="subscribeHead">구독</span>
				<c:forEach var="sub" items="${email_subs}">
				<div class="moreSub">
				
				<li><a href="#"> <span class="">
					<img src="${pageContext.request.contextPath}/resources/images/noUserIcon.png"></img>${sub.email_subs}</span>
				</a></li>
				
				</div>
				</c:forEach>
			
				<li><a href="#"> <span class="more"><i
							class="fa fa-plus"></i>더보기</span>
				</a></li>
			</ul>

			<hr>
			<div class="sideNavFoot">
				<ul>
					<li><a href="${pageContext.request.contextPath}/noticeMain">
						<span class=""><i class="fa fa-exclamation-circle"></i>공지사항</span>
					</a></li>
					<li><a href="${pageContext.request.contextPath}/chDoor">
						<span class=""><i class="fa fa-cog"></i>내 채널</span> 
					</a></li>
					<li><a href="${pageContext.request.contextPath}/logout"> <span class=""><i class="fa fa-times"></i>로그아웃</span>
					</a></li>
					<hr>
					<button type="button">
						<i class="fab fa-product-hunt"></i> 포인트 충전하기
					</button>
				</ul>
			</div>
		</div>

	</div><!-- .sideNav -->
</div><!-- #wrap -->

<div class="main" id="main">