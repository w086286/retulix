<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/top.jsp"/>

<style>
.container {
	display: grid;
	grid-template-columns: 250px repeat(1, 1fr);
	grid-auto-rows: minmax(100px, 350px);
	overflow: hidden;
	z-index: 9;
}

div .item {
	border: 1px solid black;
	background-color: rgba(255, 255, 255, 0);
}

.item1 {
	grid-row-start: 1;
	grid-row-end: 2;
	float: left;
	position: relative;
	z-index: 9;
}

.bot, .rev {
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	grid-auto-rows: minmax(150px, auto);
	/* background-color: antiquewhite; */
	background-color: rgba(255, 255, 255, 0);
	grid-column-gap: 40px;
}

.bot>div {
	border: 1px solid black;
}

.rev>div {
	border: 1px solid black;
}

.img {
	width: 100%;
}

.imbt1, .imbt2 {
	position: absolute;
	top: 45%;
	left: 40%;
	height: 60px;
	width: 60px;
}

.imgDiv {
	grid-row-start: 1;
	grid-row-end: 2;
	float: left;
	position: relative;
}

.imgDiv>img {
	position: absolute;
	top: 45%;
	left: 40%;
	height: 60px;
	width: 60px;
}

.imbt1:hover {
	opacity: 0;
	transition: opacity 0.4s;
}

.ma {
	border: 1px solid black;
	background-color: rgba(255, 255, 255, 0);
	z-index: 9;
}

iframe {
	position: relative;
	z-index: 6;
}

.imbt3,.imbt4 {
	position: absolute;
	top: 0.5%;
	left: 49%;
	height: 25px;
	width: 25px;
	z-index: 9;
}

.imbt3:hover {
	opacity: 0;
	transition: opacity 0.4s;
}

.backgr:after{
	background-image: url(./images/interbk.jpg);
	top:0;
    left:0;
    position:absolute;
    background-size:100%;
    opacity:0.3!important;
	background-repeat:none;
    content:"";
    width:100%;
    height:100%;
    min-width: 1024px;
	

}


</style>

<script type="text/javascript">

	$(function(){
		 $('.imbt1').click(function(){
	            $('.iframe').slideDown(500);
	        });
		 
		 
	        $('.imbt3').click(function(){
	             $('#players')[0].contentWindow.postMessage('{"event":"command","func":"' + 'stopVideo' + '","args":""}', '*');    
	             $('.iframe').slideUp(500); 
	        });
	});
</script>

<!-- ----------------------------------------------------------- -->
<form name='previewForm' action='trailerInsertEnd.do' method='POST'>
	<div class='backgr'  >
	
		 	<div class="iframe" style="position:relative; display:none " >
			<iframe id ='players'src="${mvo.url}" width = "100%" height="600px"  ></iframe>
			<a href='#'>
			<img class='imbt4' src="./images/exit2.png">
			<img class='imbt3' src="./images/exit.png">
			</a>
			</div>
		<div class="container"  >
		
			<div class='item1' style="border: 1px solid black">
				<img class='img' src="./images/인터.jpg">
				<div id="imgDiv">
				 
				<img class='imbt2' src="./images/재생over.png">
				<img class='imbt1' src="./images/재생.png">
				
				</div>
			</div>
			<div class="ma" style = "color : white" class='item2' > <!--  본문-->
				<label class='button'>${trailer.idx }</label>
				<h3><c:out value="${trailer.title}"/></h3><p>
				감독  <c:out value="${trailer.director}"/><br>
				줄거리<br><pre><c:out value="${trailer.info}"/></pre><br>
				개봉일 <c:out value="${trailer.release}"/><br>
			</div>
			<!-- 폼 전송용 히든인풋 -->
				<input type="hidden" name='idx' value='${trailer.idx}'readonly>
				<input type="hidden" name='title' value='${trailer.title}' readonly>
				<input type="hidden" name='director' value='${trailer.director}'  readonly>
				<input type="hidden" name='info' value='${trailer.info}'  readonly>
				<input type="hidden" name='release' value='${trailer.release}' readonly>
			<!-- /////폼 전송용 히든인풋 -->
		</div>

		<p></p>
		<div class="rev">

			<div>1</div>
			<div>2</div>
			<div>3</div>
			<div>4</div>
			<div>5</div>
		</div>
		<p></p>
		<div class="bot">

			<div>6</div>
			<div>7</div>
			<div>8</div>
			<div>9</div>
			<div>10</div>
		</div>

	</div>

	<div class='box right'>
	<c:if test='${trailer.idx eq null or trailer.idx eq ""}'>
		<button type='button' onclick='insertTrailer()'>등  록</button>
	</c:if>
	<c:if test='${trailer.idx ne null}'>
		<button type='button' onclick='editTrailer()'>수  정</button>
	</c:if>
		<button type='button' onclick='javascript:history.back()'>취  소</button>
	</div>
</form>
	
<script>
	function insertTrailer(){
		previewForm.action="trailerInsertEnd.do";
		previewForm.submit();
	}
	function editTrailer(){
		previewForm.action="trailerEditEnd.do";
		previewForm.submit();
	}
	
</script>
	
<jsp:include page="/foot.jsp" />


