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

<title>책공간</title>
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
        selector: '#reviewCn', // 내 거에 맟춰서 변경 id가 boardCn인 곳을 찾아라 
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
<%@include file="/WEB-INF/jsp/main/jsp/menu.jsp"%>

<c:choose>
	<c:when test="${not empty result.reviewId}">
		<c:set var="actionUrl" value="/review/update.do" /> 
	</c:when>
	<c:otherwise>
		<c:set var="actionUrl" value="/review/insert.do" /> 
	</c:otherwise>
</c:choose>


<div class="container"> 
<div id="contents">
	<div class="list-title">
            <h2>책리뷰</h2>
        </div>
	<form action="${actionUrl}" method="post" id="frm" name="frm" onsubmit="return regist()" enctype="multipart/form-data"> 
		<input type="hidden" name="reviewId" value="${rv.reviewId }" />
		<input type="hidden" name="returnUrl" value="/review/reviewRegist.do" />
		<table class="chart2">
			<caption>게시글 작성</caption>
			<colgroup>
				<col style="width:120px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td>
						<input type="text" id="reviewSj" name="reviewSj" title="" class="" value="${result.reviewSj}" />
					</td>
				</tr>
				<tr>
					<th scope="row">작성자ID</th>
					<td><c:out value="${USER_INFO.id}" /></td>
				</tr>
				<tr>
					<th scope="row">책제목</th>
					<td>
						<input type="text" id="rvBookSj" name="rvBookSj" title="" class="" value="${result.rvBookSj}" />
					</td>
				</tr>
				<tr>
					<th scope="row">책작가</th>
					<td>
						<input type="text" id="rvBookWr" name="rvBookWr" title="" class="" value="${result.rvBookWr}" />
					</td>
				</tr>
				<tr>
					<th scope="row">출판사</th>
					<td>
						<input type="text" id="rvBookPb" name="rvBookPb" title="" class="" value="${result.rvBookPb}" />
					</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td>
						<textarea id="reviewCn" name="reviewCn" rows="30" cols="50" title="내용입력"><c:out value="${result.reviewCn}" /></textarea>
					</td>
				</tr>
				
				<c:if test="${not empty result.atchFileId}">
					<tr>
						<th scope="row">기존<br/>첨부파일목록</th>		
						<td>
							<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${result.atchFileId }" />
							</c:import>
						</td>			
					</tr>
				</c:if>
				
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<input type="file" name="file_1" />
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn-cont ar">
			<c:choose>
				<c:when test="${not empty result.reviewId }">
					<c:url var="udtUrl" value="/review/update.do">
						<c:param name="reviewId" value="${result.reviewId}" />
					</c:url>
					<a href="${udtUrl}" id="btn-rgt" class="btn">수정</a>
					
					<c:url var="delUrl" value="/review/delete.do">
						<c:param name="reviewId" value="${result.reviewId}" />
					</c:url>
					<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i> 삭제</a>
				</c:when>
				<c:otherwise>
					<a href="#none" id="btn-rgt" class="btn spot">등록</a> 
				</c:otherwise>
			</c:choose>
			<c:url var="listUrl" value="/review/selectList.do"/>
			<a href="${listUrl}" class="btn">취소</a>
		</div>
	</form>
</div>
</div>

<%@include file="/WEB-INF/jsp/main/jsp/footer.jsp"%>

<script>
	$(document).ready(function() {
		//게시글 등록
		$("#btn-rgt").click(function(){
			//alert(00);
			$("#frm").submit();
			return false;
		});
		
		//게시글 삭제
		$("#btn-del").click(function(){
			if(!confirm("삭제하시겠습니까?")){
				return false;
			}
		});
	});
	
	function regist() {
		if(!$("#reviewSj").val()) {
			alert("제목을 입력하세요.");
			return false;
		}
		
		//에디터에 작성한 내용 db에 저장하기
		$("#reviewCn").val(tinymce.activeEditor.getContent());
		
	};
</script>

</body>
</html>