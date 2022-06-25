<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#noticeWrite td, #noticeWrite th {
	border: 1px solid #ccc;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<script src="/summernote/summernote-lite.js"></script>
	<script src="/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/summernote/summernote-lite.css">
	<div class="page-content">
		<div class="page-title">공지사항 작성</div>
		<form action="/noticeWrite.do" method="post"
			enctype="multipart/form-data">
			<table class="tbl" id="noticeWrite">
				<tr class="tr-1">
					<th class="td-3">제목</th>
					<td colspan="3"><input type="text" name="noticeTitle"
						class="input-form"></td>
				</tr>
				<tr class="tr-1">
					<th class="td-3">작성자</th>
					<td><input type="hidden" name="noticeWriter"
						value="<%=m.getMemberId()%>"> <%=m.getMemberId()%></td>
					<th class="td-3">첨부파일</th>
					<td><input type="file" name="file" multiple="multiple"></td>
				</tr>
				<tr class="tr-1">
					<td colspan="4" style="text-align:left;"><textarea id="noticeContent"
							name="noticeContent" class="input-form"></textarea></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" class="btn bc1 bs4">공지사항등록</button></td>
				</tr>
			</table>
		</form>
	</div>
	<script>
		$("#noticeContent").summernote({
			height:400,
			lang : "ko-KR",
			collbacks:{
				onImageUpload : function(files){
					uploadImage(files[0],this);
				}
			}
		});
		function uploadImage(file,editor){
			//ajax를 통해 서버에 이미지를 업로드하고 업로드 경로를 받아옴
			//form태그와 동일한 효과를 내는 FormData 객체 생성
			const form =new FormData();
			form.append("file",file);
			$.ajax({
				url : "/uploadImage.do",
				type : "post",
				data : form,
				processData : false,
				contentType : false,
				success : function(data){
					//결과로 받은 이미지 파일 경로를 에디터에 추가
					$(editor).summernote("insertImage",data);
				}
			});
			//processData : 기본값 true {key1:value1, key2:value2, key3:value3}
			//					-> 파일전송 시 String이 아니라 파일형태로 전송하기 위해서 기본값 제거
			//contentType : 기본값 "application/x-www-form-urlencoded;charset=UTF-8"
			//					-> enctype="multipart/form-data"로 설정하기 위해 기본값을 제거
		}
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>