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
					<td><input type="file" name="file"></td>
				</tr>
				<tr class="tr-1">
					<td colspan="4"><textarea name="noticeContent"
							class="input-form"></textarea></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" class="btn bc1 bs4">공지사항등록</button></td>
				</tr>
			</table>
		</form>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>