<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>JSTL</title>
</head>
<body>
	
	<c:set var="step" value="${param.step}" />
	<c:if test="${empty step}">
		<c:set var="step" value="1"/>
	</c:if>
	<ul>
		<c:choose>
			<%-- c tag 설정 --%>
			<c:when test="${step eq '1'}">
				<li>
					<h3>c:out Tag : &#60;% = ... %&#62;과 유사한 표현식</h3>
					<h4>기본문법 : &#60;c:out value="값"/&#62;</h4>
					
					JSP 1번 : <% out.print("hello~"); %> <br/>
					JSP 2번 : <% String a = "hello~";%> 
							<%=a%><br/>
					JSTL : <c:out value="hello~"/><br/>
				</li>
			</c:when>
			
			<c:when test="${step eq '2'}">
				<li>
					<h3>c:import Tag : jsp 'include'와 유사. 서버 내부 또는 서버 외부의 모든 자원 컨텐츠를 포함하는 추가 기능이 있음.</h3>
					<h4>기본문법 : &#60;c:import url="URL주소 값" charEncoding="utf-8"/&#62;</h4>
					
					<c:import url="/temp/jstlImport.do" charEncoding="utf-8"/>
					<%-- <c:import url="/temp/selectList.do" charEncoding="utf-8"/> --%>
				</li>
			
			</c:when>
			
			<c:when test="${step eq '3'}">
				<li>
					<h3>c:set Tag : 일반 변수를 생성해서 값을 할당 </h3>
					<h4>기본문법 :  &#60;c:set var="변수명" value="값"/ &#62;</h4>
					
					<c:set var="str" value="지금은 c:set 연습중" />
					<c:out value="${str}" />
				</li>
			</c:when>
			
			<c:when test="${step eq '4'}">
				<li>
					<h3>c:if Tag : 조건문 중의 하나. JAVA에서 사용하는 If와 동일</h3>
					<h4>기분문법 : &#60;c:if test="조건문"&#62; &#60;/c:if&#62; </h4>
					
					<c:set var="test" value="0"/>
					<c:if test="${test eq '0' }">
						true
					</c:if>
				</li>
			</c:when>
			
			<c:when test="${step eq '5'}">
				<li>
					<h3>c:choose, c:when, c:otherwise Tag : 조건문 중의 하나.
					JAVA에서 사용하는 If, else if, else와 비슷함 </h3>
					<h4>기본문법 : <br/>
						&#60;c:choose&#62;<br/>
							&#60;c:when test="조건문"&#62; 조건 true에 대한 내용 &#60;/c:when&#62;</br>
							&#60;c:otherwise&#62;조건에 해당되지 않아서 나오는 내용 &#60;/c:otherwise&#62;</br>
						&#60;/c:choose&#62;
					</h4>
					
					<c:set var="test" value="0"/>
					<c:choose>
						<c:when test="${test eq '1'}">1입니다.</c:when>
						<c:otherwise>조건에 해당되지 않음</c:otherwise>
					</c:choose>
				</li>
			</c:when>
			
			<c:when test="${step eq '6'}">
				<li>
					<h3>c:forEach Tag : 기본 반복 태그, 고정된 횟수 또는 초과 수집 동안 중첩된 본문 내용을 반복</h3>
					<h4>기본문법 : <br/>
						&#60;c:forEach var="변수명" items="반복문 변수"&#62;<br/>
							반복문 내용<br/>
						&#60;/c:forEach&#62;
					</h4>
					
					<c:set var="str" value="1,2,3,4,5,6"/>
					<c:set var="strSplit" value="${fn:split(str, ',')}"/>
					<c:forEach var="result" items="${strSplit}">
						<c:out value="${result}" /><br/>
					</c:forEach>
				</li>
			</c:when>
			
			<c:when test="${step eq '7'}">
				<li>
					<h3>c:param Tag : 포함하는 import, url 태그의 URL에 매개 변수를 추가</h3>
					<h4>기본문법 : &#60;c:param name="변수명" value="값"/&#62;</h4>
					
					<c:import url="/temp/jstlImport.do" charEncoding="utf-8">
						<c:param name="test" value="테스트 호출" />
					</c:import>
				</li>
			</c:when>
			
			<c:when test="${step eq '8'}">
				<li>
					<h3>c:url Tag : url 주소</h3>
					<h4>기본문법 : &#60;c:url name="변수명" value="값"/&#62;</h4>
					
					URL 1 : <c:url var="link1" value="https://www.naver.com" />
							<a href="${link1}" target="_blank" title="새창열기">링크 1번</a><br/>
					URL 2 : <c:url var="link2" value="/temp/jstlImport.do">
								<c:param name="test" value="테스트 호출" />
							</c:url>
							<a href="${link2}" target="_blank" title="새창열기">링크 2번</a>			
					
				</li>
			</c:when>
		</c:choose>
	</ul>
</body>
</html>