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
<style>
.wrap {
	margin: 200px;
}
</style>

</head>
<body>
<%-- <%@ include file="/WEB-INF/jsp/main/jsp/menu.jsp"%>  --%>



<div class="wrap"> 
	<nav>
		<a href="/join/memberRegist.do?loginType=normal" class="member-type">일반 회원가입</a>
		<a class="btn-kakao" href="#" data-type="join">
			<img src="http://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="150" alt="카카오 로그인 버튼"/>
		</a>
	</nav>
</div>

<form id="joinFrm" name="joinFrm" method="post" action="/join/insertMember.do">
	<input type="hidden" name="loginType" value="" />
	<input type="hidden" name="emplyrId" />
	<input type="hidden" name="userNm" />
</form>

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
$(document).ready(function(){
	//카카오 로그인 버튼
	$(".btn-kakao").click(function(){
		const type = $(this).data("type");	//type을 넘긴다 (회원가입/로그인)
		kakaoLogin(type);
		return false;
	});
});

//카카오 키 정보 입력 -카카오에서 제공해주는 라이브러리(Kakao.~)
Kakao.init('f636d8c233e77a72038fbb88c3c00d9e');

//카카오SDK 초기화 - init()초기화를 계속 실행가능
Kakao.isInitialized();

//카카오로그인
function kakaoLogin(type) {
	Kakao.Auth.login({
		success: function (response) {  //response라는 변수명에 데이터 담기 
			Kakao.API.request({			//카카오 규칙- 카카오 api 호출하기
				url: '/v2/user/me',		// 유저 정보 가져오기 (api 버전이 계속 올라감에 따라 체크 후 버전업해줘야 함)
				success: function (response) {
					console.log(response)
					$("input[name=loginType]").val("KAKAO");
					if(type == "join"){	
						$("input[name=emplyrId]").val(response.id);
						$("input[name=userNm]").val(response.properties.nickname);
						
						$("#joinFrm").submit();		//회원가입
					}else{
						$("input[name=id]").val(response.id);
						$("#frmLogin").submit();	//로그인
					}
					
				},
				fail: function (error) {
					console.log(error)
				},
			})
		}, fail: function (error) {
			console.log(error)
		},
	})
}

</script>

</div>


<%-- <%@ include file="/WEB-INF/jsp/main/jsp/footer.jsp"%> --%>


</body>
</html>