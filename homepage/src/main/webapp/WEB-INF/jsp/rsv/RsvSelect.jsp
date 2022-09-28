<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>한국폴리텍 예약관리</title>
<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet" />

<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%-- 기본 URL -검색했던 페이지로의 이동을 위한 파라미터를 유지 --%>
<c:url var="_BASE_PARAM" value="">
	<c:param name="resveId" value="${searchVO.resveId}" />
	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
	<c:if test="${not empty searchVO.searchCondition}">
		<c:param name="searchCondition" value="${searchVO.searchCondition}" /> 
	</c:if>
	<c:if test="${not empty searchVO.searchKeyword}">
		<c:param name="searchKeyword" value="${searchVO.searchKeyword}" /> 
	</c:if>
</c:url>

<!-- content 시작 -->
<div id="content">
	<div class="container">
		<div id="contents"> 
			<div id="bbs_wrap">
				<div class="board_view">
					<dl class="tit_view">
						<dt>프로그램명</dt>
						<dd><c:out value="${result.resveSj}"/></dd>
					</dl>
					<dl class="tit_view">
						<dt>신청유형</dt>
						<dd>
						<c:choose>
							<c:when test="${result.resveSeCode eq 'TYPE01'}">선착순</c:when>
							<c:when test="${result.resveSeCode eq 'TYPE02'}">승인관리</c:when>
						</c:choose>
						</dd>
					</dl>
					<dl class="tit_view">
						<dt>강사명</dt>
						<dd><c:out value="${result.recNm}"/></dd>
					</dl>
					<dl class="info_view">
						<dt>운영일자</dt>
						<dd><c:out value="${result.useBeginDt}"/> ~ <c:out value="${result.useEndDt}"/></dd>
						<dt>운영시간</dt>
						<dd><c:out value="${result.useBeginTime}"/> ~ <c:out value="${result.useEndTime}"/></dd>
						<dt>신청기간</dt>
						<dd><c:out value="${result.reqstBgnde}"/> ~ <c:out value="${result.reqstEndde}"/></dd>
						<dt>신청 가능한 인원</dt>
						<dd><c:out value="${result.maxAplyCnt}"/></dd>
					</dl>
					<dl class="info_view2">
						<dt>작성자ID</dt>
						<dd><c:out value="${result.frstRegisterId}"/></dd>
						<dt>작성일</dt>
						<dd><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></dd>
					</dl>
					<div class="view_cont">
						<c:out value="${result.resveCn}" escapeXml="false" />
					</div>
				</div>
				
				<div class="btn-cont ar">
					<c:choose>
						<c:when test="${result.applyStatus eq '1'}">
							<a href="#" class="btn btn-status" data-status="${result.applyStatus}">접수 대기중</a>
						</c:when>
						<c:when test="${result.applyStatus eq '2'}">
							<a href="/rsv/rsvApplyRegist.do${_BASE_PARAM}" id="btn-apply" class="btn spot">신청</a>
						</c:when>
						<c:when test="${result.applyStatus eq '3'}">
							<a href="#" class="btn btn-status" data-status="${result.applyStatus}">접수마감</a>
						</c:when>
						<c:when test="${result.applyStatus eq '4'}">
							<a href="#" class="btn btn-status" data-status="${result.applyStatus}">운영중</a>
						</c:when>
						<c:otherwise>
							<a href="#" class="btn btn-status" data-status="${result.applyStatus}">종료</a>
						</c:otherwise>
					</c:choose> 
					<c:url var="listUrl" value="/rsv/selectList.do${_BASE_PARAM}"/>
					<a href="${listUrl}" class="btn">목록</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //content 끝 -->

<script>
$(document).ready(function(){
	//예약상태 메세지
	$(".btn-status").click(function(){
		var status = $(this).data("status");
		//data속성이 status인 것의 값을 변수 status에 저장
		
		//접수중(2)일때만 신청이 가능해야 하므로 나머지일때는 alert로 알림만 해줌.
		if(status == "1") {
			alert("현재 접수대기중 상태입니다.");
		}else if(status == "3") {
			alert("현재 접수마감 상태입니다.");
		}else if(status == "4") {
			alert("현재 운영중 상태입니다.");
		}else if(status == "5") {
			alert("현재 종료 상태입니다.");
		}
	});
	
	//신청
	$("#btn-reg").click(function(){
		if(!confirm("신청하시겠습니까?")){
			return false;
		}
	});
	
	//신청가능여부 체크 후 진행. 신청가능한지, 본인이 이미 예약한 게 있는지 (중복체크) 
	$("#btn-apply").click(function(){
		var href = $(this).attr("href");
		
		$.ajax({
			type : "POST",
			url : "/rsv/rsvCheck.json",		//json형태로 보내면 사용자가 json인지 바로 알 수 있다. 
			data : {"resveId" : "${searchVO.resveId}"},
			dataType : "json",
			success : function(result) {
				if(result.successYn == "Y"){
					location.href = href;
					//alert("접수가능"); 
				}else{
					alert(result.message);
				}
			},error : function(result) {
				alert("error");
			}
		});
		
		return false;
		
	});
})
</script>

</body>
</html>