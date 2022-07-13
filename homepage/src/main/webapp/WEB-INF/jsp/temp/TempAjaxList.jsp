<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<table>
	<thead>
		<tr>
			<th>TEMP_VAL</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}">
			<tr>
				<td><c:out value="${result.tempVal}" /></td>
				<td>
					<c:url var="delUrl" value="/temp/delete.do">
						<c:param name="tempId" value="${result.tempId}" />
					</c:url>
					<a href="${delUrl}" class="btn-del">삭제</a> 
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
