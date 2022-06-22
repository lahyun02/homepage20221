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

<script src="https://cdn.tiny.cloud/1/o51boi46cx1thhzb0u3dfus43nwkmyl5lp1k2j9xntaiyfgo/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
$(function(){
    var plugins = [
        "advlist", "autolink", "lists", "link", "image", "charmap", "print", "preview", "anchor",
        "searchreplace", "visualblocks", "code", "fullscreen", "insertdatetime", "media", "table",
        "paste", "code", "help", "wordcount", "save"
    ];
    var edit_toolbar = 'formatselect fontselect fontsizeselect |'
               + ' forecolor backcolor |'
               + ' bold italic underline strikethrough |'
               + ' alignjustify alignleft aligncenter alignright |'
               + ' bullist numlist |'
               + ' table tabledelete |'
               + ' link image';
	// | -> 에디터안 기능들 사이 띄어쓰기. 추가하고 싶은 기능이 있으면 여기에 붙여서 쓰면 됨.
	// 예 -> 이미지(텍스트)를 삽입할 때 첨부파일로도 자동으로 생성되도록 하는 기능 추가 
	
    tinymce.init({
    	language: "ko_KR", //한글판으로 변경
        selector: '#boardCn', // 내 거에 맟춰서 변경 id가 boardCn인 곳을 찾아라 
        height: 500,
        menubar: false,
        plugins: plugins,
        toolbar: edit_toolbar,
        
        /*** image upload ***/
        image_title: true,
        /* enable automatic uploads of images represented by blob or data URIs*/
        automatic_uploads: true,
        /*
            URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
            images_upload_url: 'postAcceptor.php',
            here we add custom filepicker only to Image dialog
        */
        file_picker_types: 'image',
        /* and here's our custom image picker*/
        file_picker_callback: function (cb, value, meta) {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');

            /*
            Note: In modern browsers input[type="file"] is functional without
            even adding it to the DOM, but that might not be the case in some older
            or quirky browsers like IE, so you might want to add it to the DOM
            just in case, and visually hide it. And do not forget do remove it
            once you do not need it anymore.
            */
            input.onchange = function () {
                var file = this.files[0];

                var reader = new FileReader();
                reader.onload = function () {
                    /*
                    Note: Now we need to register the blob in TinyMCEs image blob
                    registry. In the next release this part hopefully won't be
                    necessary, as we are looking to handle it internally.
                    */
                    var id = 'blobid' + (new Date()).getTime();
                    var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
                    var base64 = reader.result.split(',')[1];
                    var blobInfo = blobCache.create(id, file, base64);
                    blobCache.add(blobInfo);

                    /* call the callback and populate the Title field with the file name */
                    cb(blobInfo.blobUri(), { title: file.name });
                };
                reader.readAsDataURL(file);
            };
            input.click();
        },
        /*** image upload ***/
        
        content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
    });
});
</script>


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
	<form action="${actionUrl}" method="post" id="frm" name="frm" onsubmit="return regist()" enctype="multipart/form-data">
		<%-- onsubmit: 유효성 검사  "return true"를 생략한 것. --%>
		<input type="hidden" name="boardId" value="${result.boardId}"/>
		<input type="hidden" name="returnUrl" value="/board/boardRegist.do"/>
		<%--"returnUrl": 첨부파일목록에서 x(삭제)버튼을 눌렀을때 다시 이 url로 돌아올수있도록 --%>

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
				<c:if test="${not empty result.atchFileId}">
					<tr>
						<th scope="row">기존<br/>첨부파일목록</th>
						<td>
							<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${result.atchFileId}" /> 
							</c:import>
						</td>
					</tr>
				</c:if>
				
				<tr>
					<th scope="row">파일첨부</th>
					<td>
						<input type="file" name="file_1" />
						<br/>
						<input type="file" name="file_2" />
						<br/>
						<input type="file" name="file_3" />
						<br/>
						<input type="file" name="file_4" />
						<br/>
						<input type="file" name="file_5" />
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
	
	//에디터에 작성한 내용 저장 -> db에 넣을때 반영됨
	$("#boardCn").val(tinymce.activeEditor.getContent());
	//#boardCn에 tinymce에서 저장한 내용(tinymce에서 제공한 속성)의 데이터를 저장해라. 
	//tinymce 6버전에선 이 코드를 안써도 db에 저장됨. 하지만 다른 에디터에서는 안됨.
	
}
</script>
</body>
</html>