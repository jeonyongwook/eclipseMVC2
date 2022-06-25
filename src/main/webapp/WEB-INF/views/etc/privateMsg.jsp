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
		<div class="page-title">쪽지</div>
		<a href="/receiveMsg.do">받은 쪽지</a>
		<br>
		<a href="/sendMsg.do">보낸 쪽지</a>
		<br>
		<a href="/writeMsgFrm.do">쪽지보내기</a>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>