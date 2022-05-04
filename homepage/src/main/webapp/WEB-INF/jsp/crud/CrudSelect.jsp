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
<title>데이터 가져오기~</title>
</head>
<body>

<table>
	<tbody>
		<tr>
			<th>제목</th>
			<td><c:out value="${result.crudSj}" /></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><c:out value="${result.userNm}" /></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${result.registDate}" pattern="yyyy-MM-dd" />   </td>
		</tr>
		<tr>
			<th>내용</th>
			<td><c:out value="${result.crudCn}" /></td>
		</tr>
	</tbody>
</table>


	<%-- 제목: ${result.crudSj}	
	<br/>
	작성자: ${result.userNm}
	<br/>
	작성일: ${result.registDate}
	<br/>
	내용: ${result.crudCn}
	<br/>
	 --%>
	
	
<div class="box-btn">
	<c:url var="uptUrl" value="/crud/crudRegist.do">
		<c:param name="crudId" value="${result.crudId}"/>
	</c:url>
	<button><a href="${uptUrl}">수정</a></button>
	
	<c:url var="delUrl" value="/crud/delete.do">
		<c:param name="crudId" value="${result.crudId}"/>
	</c:url>
	<button><a href="${delUrl}" class="btn-del">삭제</a></button>
	
	<button><a href="/crud/selectList.do">목록</a></button>
</div>


	
</body>
</html>