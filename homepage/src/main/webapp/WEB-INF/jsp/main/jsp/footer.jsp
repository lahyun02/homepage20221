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
<title>Insert title here</title>
<!-- 외부스타일시트 -->
<link rel="stylesheet" href="/asset/front/css/footer-style.css">
</head>
<body>

<!-- 푸터 -->
        <footer id="footer">
            <div class="footer-wrap">
                <div class="footer-box">
                    <div class="footer-logo">
                        <a href="/index.do"><img src='<c:out value="/asset/images/comm/footer_logo.png"/>' alt="logo"/></a>
                    </div>
                    <ul class="footer-menu">
                        <li><a href="/review/selectList.do">책리뷰</a></li>
                        <li><a href="/sentc/selectList.do">책문구</a></li>
                        <!-- <li><a href="#">자유글</a></li>
                        <li><a href="#">책추천</a></li> -->
                    </ul>
                </div>
                <div class="footer-contents">
                     <p>
                        COPYRIGHT 2022 BY SOLAHYUN. ALL RIGHTS RESERVED.
                    </p>
                    
                </div>
            </div>
        </footer>

</body>
</html>