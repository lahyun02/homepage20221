<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>데이터 가져오기~</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
게시물 총 수 : <c:out value="${paginationInfo.totalRecordCount}" />건
<table>
	<thead>
		<tr>
			<th>ID</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList }">
			<tr>
				<td><c:out value="${result.crudId}"/></td>
				<!-- <td><c:out value="${result.tempVal}"/></td> -->
				<td>
					<c:url var="viewUrl" value="/crud/select.do">
						<c:param name="crudId" value="${result.crudId}" />
					</c:url>
					<a href="${viewUrl}"><c:out value="${result.crudSj}" /></a>
				</td>
				<td><c:out value="${result.userNm}"/></td>
				<%-- <td><c:out value="${result.registDate}"/></td> --%>
				
				<td>
					<fmt:formatDate value="${result.registDate}" pattern="yyyy-MM-dd" />   
				</td> 
				<td>
					<c:url var="delUrl" value="/crud/delete.do">
						<c:param name="crudId" value="${result.crudId}"/>
					</c:url>
					<button><a href="${delUrl}" class="btn-del">삭제</a></button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div id="paging_div">
	<ul class="paging_align">
		<c:url var="pageUrl" value="/crud/selectList.do?" />
		<c:set var="pagingParam"><c:out value="${pageUrl}" /></c:set>
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pagingParam}" />
	</ul>
</div>


<a href="/crud/crudRegist.do">글쓰기</a>


<script>
$(document).ready(function(){
	$(".btn-del").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
	});
});

</script>

</body>
</html>