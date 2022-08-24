<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>

<%-- 기본 URL --%>
<c:url var="_BASE_PARAM" value="">
	<c:param name="menuNo" value="50" />
	<c:if test="${not empty rvVO.searchCondition}">
		<c:param name="searchCondition" value="${rvVO.searchCondition}" />
	</c:if>
	<c:if test="${not empty rvVO.searchKeyword}">
		<c:param name="searchKeyword" value="${rvVO.searchKeyword}" />
	</c:if>
</c:url>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>책공간</title>
<!-- 외부스타일시트 -->
<link rel="stylesheet" href="/asset/front/css/review-list.css">
<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/jsp/main/jsp/menu.jsp"%>
<div id="container">

	
	
	<!-- 섹션 - -->
        <section id="rvList-section">
            <div class="rvList-title">
                <h2>책리뷰</h2>
            </div>
            <div class="rv-container">
            
            	<%-- 검색 영역 --%>
            	<div id="bbs_search">
            		<form action="/review/selectList.do" method="post" name="frm" >
            			<fieldset>
            				<legend>검색조건입력폼</legend>
            				<label for="ftext" class="hdn">검색분류선택</label>
            				<select name="searchCondition" id="ftext">
            					<option value="0" <c:if test="${rvVO.searchCondition eq '0'}">selected="selected"</c:if>>제목</option>
            					<option value="1" <c:if test="${rvVO.searchCondition eq '1'}">selected="selected"</c:if>>내용</option>
            					<option value="2" <c:if test="${rvVO.searchCondition eq '2'}">selected="selected"</c:if>>작성자</option>
            				</select>
            				<label for="inp_text" class="hdn">검색어입력</label>
            				<input name="searchKeyword" value='<c:out value="${rvVO.searchKeyword}"/>' type="text" class="inp_s" id="inp_text">
            				<span class="bbtn_s"><input type="submit" value="검색" title="검색" /></span>
            			</fieldset>
            		</form>
            	</div>
            	
                <div class="cnt-page">
                    총 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>건 | 현재페이지 <strong><c:out value="${paginationInfo.currentPageNo}"/></strong>/<c:out value="${paginationInfo.totalPageCount}"/>
                	
                </div>
                <div class="rvList-wrap">
                	<c:forEach var="item" items="${rvList}" varStatus="status" >
	                    <div class="box">
	                    	<%-- <div class="num">
	                    		<c:out value="${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage) - (status.count - 1)}" />
	                    		| ${paginationInfo.recordCountPerPage} + ${rvVO.pageUnit} + ${rvVO.pageIndex}
	                    	</div> --%>
	                        <div class="b-img">
	                        	<c:choose>
									<c:when test="${not empty item.atchFileNm}">
										<c:url var="thumbUrl" value="/cmm/fms/getThumbImage.do">  
											<c:param name="thumbYn" value="Y" />
											<c:param name="atchFileNm" value="${item.atchFileNm}"/>
										</c:url>
										<img src="${thumbUrl}" alt=""/>
									</c:when>
									<c:otherwise>
										<img class="defaultImg" src='<c:url value="/asset/images/reviewList_default_img.jpg"/>' alt="기본썸네일" /> 
									</c:otherwise>				
	                        	</c:choose>	
	                        </div>
	                        
	                        <div class="b-wrap">
	                        <div class="b-title">
	                            <a href="/review/select.do?reviewId=${item.reviewId}"><c:out value="${item.reviewSj}" /> </a>
	                            <input type="hidden" name="reviewId" value="${item.reviewId}" />
	                            <input type="hidden" name="pageIndex" value="${rvVO.pageIndex}" />
	                        </div>
	                        <div class="b-content">
	                        	<p><c:out value="${item.reviewCn}" escapeXml="false"  /> </p>
	                        </div>
	                        <div class="b-txt">
	                            <span><c:out value="${item.frstRegisterId}" /></span>
	                            <em><fmt:formatDate value="${item.frstRegistPnttm}" pattern="yyyy-MM-dd"/></em>
	                        </div>
	                        </div>
	                        
	                    </div>
                	</c:forEach>
                	
                	<%-- 게시글이 없을 경우 --%>
                	<c:if test="${fn:length(rvList) == 0}">
                		<div class="empty">검색 데이터가 없습니다.</div> 
                	</c:if>
                    
                </div>
                
                
            	
                
                <div id="paging">
                	<c:url var="pageUrl" value="/review/selectList.do${_BASE_PARAM}" />
                	<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
                	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pagingParam}"/>
                </div>
                
                <div class="btn-cont ar">
                	<a href="/review/reviewRegist.do" class="btn spot">
                		<i class="ico-check-spot"></i> 글쓰기
                	</a>
                </div>
                
            </div>
            
        </section>
        
	
	
<%@include file="/WEB-INF/jsp/main/jsp/footer.jsp"%>
</div>


<script>
	<c:if test="${not empty message}">
		alert("${message}");
	</c:if>
</script>


</body>
</html>