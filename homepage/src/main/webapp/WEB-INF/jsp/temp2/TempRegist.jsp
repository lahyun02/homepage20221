<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>데이터 가져오기~</title>
</head>
<body>

* 등록폼

<c:choose>
	<c:when test="${not empty searchVO.tempId}">
		<c:set var="actionUrl" value="/temp2/update.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="actionUrl" value="/temp2/insert.do"/>
	</c:otherwise>
</c:choose>

<form action="${actionUrl}" method="post" name="tempVO">
	<input type="hidden" name="tempId" value="${result.tempId}"/>
	<label for="tempVal"> 값 정보 : </label>
	<input type="text" id="tempVal" name="tempVal" value="${result.tempVal}" />
	<br/>
	<c:choose>
		<c:when test="${not empty searchVO.tempId}">
			<button type="submit">수정</button>
		</c:when>
		<c:otherwise>
			<button type="submit">등록</button>
		</c:otherwise>
	</c:choose>
</form>


<!-- <form action="/temp/insert.do" method="post" name="tempVO">
	<label for="tempVal"> 값 정보 : </label>
	<input type="text" id="tempVal" name="tempVal" value="" />
	<br/>
	<button type="submit">등록</button>
</form> -->






</body>
</html>