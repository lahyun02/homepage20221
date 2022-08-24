<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<title>책공간</title>
<!-- 외부스타일시트 -->
<link rel="stylesheet" href="/asset/front/css/login-style.css">
</head>
<body>
<%@include file="/WEB-INF/jsp/main/jsp/menu.jsp"%>
<div class="login-container">
	
	<section id="login-section">
            <div class="login-ctn">
                <h2>로그인</h2>
            </div>
            <!-- 로그인 폼 -->
            <form action="/login/actionLogin.do" id="frmLogin" name="frmLogin" method="post">
            	<input type="hidden" name="userSe" value="USR"/>
            	<input type="hidden" name="address" value="${address}"/>
                <fieldset>
                    <legend>로그인을 위한 아이디/비밀번호 입력</legend>
                    <div class="ipt-row">
                        <input type="text" id="loginId" name="id" placeholder="아이디" required="required" />
                    </div>
                    <div class="ipt-row">
                        <input type="password" id="loginPw" name="password" placeholder="비밀번호" required="required" />
                    </div>
                    <button type="submit" class="btn-login"><span>로그인</span></button>
                </fieldset>
            </form>
        </section>
	
	

	
	
</div>
<%@include file="/WEB-INF/jsp/main/jsp/footer.jsp"%>

<script>
<c:if test="${not empty loginMessage}">
	alert("${loginMessage}"); 
</c:if> 
</script>

</body>
</html>