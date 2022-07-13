<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>Ajax 테스트</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<form id="frm" action="/temp/insertAjax.do" method="post" name="tempVO">
	<label for="tempVal">값 정보 : </label>
	<input type="text" id="tempVal" name="tempVal" value="${result.tempVal}" />
	<button id="btn-submit" type="button">등록</button>
</form>

<div id="ajax-box">
	<c:import url="/temp/ajaxList.do" charEncoding="utf-8"></c:import>
</div>

<script>
$(document).ready(function(){
	$("#btn-submit").click(function(){
		var tempVal = $("#tempVal").val();
		
		if(tempVal) {
			$.ajax({
				url : "/temp/ajaxList.do",
				type : "post",
				data : {"tempVal" : tempVal},
				dataType : "html",   			/* 태그를 갖고 오므로 html타입 */
				success : function(data){		/* 모든 data를 다 갖고옴 */
					$("#ajax-box").html(data);	/* data의 html을 재구성함 */
				}, error : function(){			/* 에러가 날 경우 표시해줌 */
					alert("error : list");
				}
			});
		}else{
			alert("내용을 입력해주세요.")
		}
	});
});
</script>


</body>
</html>