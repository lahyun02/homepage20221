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
<title>게시판</title>
<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet" />

<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<c:choose>
	<c:when test="${not empty searchVO.boardId}">
		<c:set var="actionUrl" value="/board/update.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="actionUrl" value="/board/insert.do"/>
	</c:otherwise>
</c:choose>

<div class="container">
<div id="contents">
	<form action="${actionUrl}" method="post" id="frm" name="frm" onsubmit="return regist()">
		<%-- onsubmit: 유효성 검사  "return true"를 생략한 것. --%>
		<input type="hidden" name="boardId" value="${result.boardId}" />
		
		<table class="chart2">
			<%-- caption: 표에 대한 제목. 웹표준성- 테이블엔 꼭 들어가야함. 이 테이블은~ 가 들어가있습니다.라고 설명해주는 것. --%>
			<caption>게시글 작성</caption> 
			<%-- colgroup: 열 너비 조절. 두번째 col은 디바이스 크기에서 고정 너비를 뺀 나머지 값. --%>
			<colgroup>
				<col style="width:120px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<%-- scope:읽기형식  row -> row의 형태를 읽음. row행들이 모여 위아래 세로로 표가 나아간다. --%>
					<td>
						<input type="text" id="boardSj" name="boardSj" title="제목입력" class="q3" value="<c:out value="${result.boardSj}"/>"/>
					</td>
				</tr>
				<tr>
					<th scope="row">공지여부</th>
					<td>
						<label for="noticeAtY">예 : </label>
						<input type="radio" id="noticeAtY" value="Y" name="noticeAt" <c:if test="${result.noticeAt eq 'Y'}">checked="checked"</c:if>/>
						&nbsp;&nbsp;&nbsp;
						<label for="noticeAtN">아니오 : </label>
						<input type="radio" id="noticeAtN" value="N" name="noticeAt" <c:if test="${result.noticeAt ne 'Y'}">checked="checked"</c:if>/>
						<%-- radio-> 무조건 하나만 선택. radio버튼 둘 중 하나는 선택이 되어져야 함. 초기값이 '아니오', NULL.  Y가 아닐때라고 설정. --%>
					</td>
				</tr>
				<tr>
					<th scope="row">비공개 여부</th>
					<td>
						<label for="noticeAtY">예 : </label>
						<input type="radio" id="othbcAtY" value="Y" name="othbcAt" <c:if test="${result.othbcAt eq 'Y'}">checked="checked"</c:if>/>
						&nbsp;&nbsp;&nbsp;
						<label for="noticeAtN">아니오 : </label>
						<input type="radio" id="othbcAtN" value="N" name="othbcAt" <c:if test="${result.othbcAt ne 'Y'}">checked="checked"</c:if>/>
						<%-- 디폴트값이 아니오로 설정 --%>
					</td>
				</tr>
				<tr>
					<th scope="row">작성자ID</th>
					<td>
						<c:out value="${USER_INFO.id}"/>
					</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td>
						<textarea id="boardCn" name="boardCn" rows="15" title="내용입력"><c:out value="${result.boardCn}"/></textarea>
						<%-- textarea태그 사이에 엔터를 치면 그대로 한줄 떨어져서 나옴. 붙여서 한줄로 써야함 --%>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn-cont ar">
			<c:choose>
				<c:when test="${not empty searchVO.boardId}">
					<c:url var="uptUrl" value="/board/update.do">
						<c:param name="boardId" value="${result.boardId}" />
					</c:url>				
					<a href="${uptUrl}" id="btn-reg" class="btn">수정</a>
					
					<c:url var="delUrl" value="/board/delete.do">
						<c:param name="boardId" value="${result.boardId}"/>
					</c:url>
					<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i> 삭제</a>
				</c:when>
				<c:otherwise>
					<a href="#none" id="btn-reg" class="btn spot">등록</a>
				</c:otherwise>
			</c:choose>
			<c:url var="listUrl" value="/board/selectList.do"/>
			<a href="${listUrl}" class="btn">취소</a>
		</div>
	</form>
</div>
</div>
<script>
<%-- 소스가 다 준비된 후에 document를 ready준비해라  
랜더링 순서. 스크립트가 위에 있으면 태그가 만들어지기도 전에 스크립트가 생성되므로 버튼이 작동하지 않을수있음. 
--%>
$(document).ready(function(){
	//게시글 등록
	$("#btn-reg").click(function(){
		$("#frm").submit();
		return false; 
	});
<%-- return false;  a태그 링크로의 이동을 비활성화 --> 레이어 띄울때 많이씀.  --%>

	//게시글 삭제 
	$("#btn-del").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
	});
});
<%-- value값이 없으면 --%>
function regist(){
	if(!$("#boardSj").val()){
		alert("제목을 입력해주세요.");
		return false;
	}
}
</script>
</body>
</html>