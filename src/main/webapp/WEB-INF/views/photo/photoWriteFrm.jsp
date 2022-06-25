<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#photoWrite td, #photoWrite th{
		border : 1px solid #eee;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">사진게시판작성</div>
		<form action="/photoWrite.do" method="post" enctype="multipart/form-data">
			<table class="tbl" id="photoWrite">
				<tr class="tr-1">
					<th class="td-2">작성자</th>
					<td>
						<input type="hidden" name="photoWriter" value="<%=m.getMemberId() %>">
						<%=m.getMemberId() %>
					</td>
					<th class="td-2">첨부파일</th>
					<td>
						<input type="file" name="file" onchange="loadImg(this);" accept=".jpg,.png,.jpeg">
					</td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">내용</th>
					<td colspan="3">
						<textarea class="input-form" name="photoContent"></textarea>
					</td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">이미지</th>
					<td colspan="3">
						<div id="img-viewer">
							<img id="img-view" width="500px">
						</div>
					</td>
				</tr>
				<tr class="tr-1">
					<th colspan="4"><button type="submit" class="btn bc22 bs4">등록</button></th>
				</tr>
			</table>
		</form>
	</div>
	<script>
		function loadImg(f){
			console.log(f.files);	//input file에서 선택된 파일이 여러개일수 있으므로 배열로 처리
			//배열의 길이가 0이 아니고, 배열 첫번째 파일이 정상적인 파일이면
			if(f.files.length!=0 &&	f.files[0] !=0){
				const reader=new FileReader();//파일의 정보를 읽어올 수 있는 객체 생성
				reader.readAsDataURL(f.files[0]);//선택한 파일의 경로를 가져옴
				//읽기가 완료되면 onload이벤트 발생
				reader.onload = function(e){
					$("#img-view").attr("src", e.target.result);
				}
			}else{
				$("#img-view").attr("src", "");
			}
		}
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>