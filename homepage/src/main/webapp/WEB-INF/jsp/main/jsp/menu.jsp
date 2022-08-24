<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menu</title>
<!-- 외부스타일시트 -->
<link rel="stylesheet" href="/asset/front/css/menu-style.css">
<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
</head>
<body>

<!-- 헤더 -->
<header id="main-header">
  <div class="menu-wrap">
    <!-- 로고 -->
  	<h1>
        <a href="/index.do"><img class="logo" src='<c:out value="/asset/images/comm/logo.png"/>' alt="logo" /></a>
    </h1>
    <!-- 메뉴 -->
    <nav id="nav">
    	<ul class="gnb">
        	<li><a href="/review/selectList.do">책리뷰</a></li>
        	<li><a href="/sentc/selectList.do">책문구</a></li>
        	<%-- <li><a href="#">자유글</a></li> --%>
        	<%-- <li><a href="#">책추천</a></li> --%>
     	</ul>
     </nav>
     <!-- 로그인/회원가입 -->
     <ul class="util-menu">
     	<c:choose>
			<c:when test="${empty USER_INFO.id}">
				<li><a href="/login/loginForm.do" class="login">로그인 </a></li>
				<li><a href="/login/loginForm.do" class="login"> 회원가입</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/login/actionLogout.do"><c:out value="${USER_INFO.name}"/>님 로그아웃</a></li>
			</c:otherwise>
		</c:choose>
     </ul>
   </div>
   
   <div class="dim"></div>
   
</header>


</body>
</html>