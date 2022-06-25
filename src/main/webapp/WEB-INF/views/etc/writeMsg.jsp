<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">쪽지보내기</div>
		<form action="/writeMsg.do" method="post">
			<table class="tbl">
				<tr class="tr-1">
					<th class="td-2">제목</th>
					<td><input type="text" name="msgTitle" class="input-form"></td>
				</tr>
				<tr class="tr-1">
					<td><div name="receiver" style="display:none;"><%=m.getMemberId() %></div></td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">내용</th>
					<td><textarea class="input-form" name="msgContent"></textarea></td>
				</tr>
				<tr class="tr-1">
					<th colspan="2"><button type="submit" class="btn bc1 bs4">전송</button></th>
				</tr>
			</table>
		</form>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>