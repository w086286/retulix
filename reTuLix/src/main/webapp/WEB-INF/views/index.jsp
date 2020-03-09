<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctx=request.getContextPath(); %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<!-- CSS============================================================ -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/whole.css" />		<!-- 전체 기본 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/topNav.css" />	<!-- 상단 내비게이션 바  -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sideNav.css" />	<!-- 좌측 내비게이션 바 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />		<!-- 메인 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin.css" />		<!-- 관리자 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/channel.css" />	<!-- 내 채널 -->

<!--jQuery Google CDN=============================================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- 아이콘 라이브러리=================================================== -->
<script src="https://kit.fontawesome.com/d9fe37202c.js" crossorigin="anonymous"></script>

<!-- lightslider==================================================== -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/lightslider.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>

<title>reTuLix</title>
</head>

<body>
<c:import url="/top" />
<c:import url="/main" />
<c:import url="/foot" />