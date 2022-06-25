<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Msg r = (Msg) request.getAttribute("r");
String memberId = (String) request.getAttribute("memberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#msgWrite td, #msgWrite th {
	border: 1px solid #ccc;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">쪽지 작성</div>
		
		<form action="/msgWrite.do" method="post">
			<table class="tbl" id="msgWrite">
				<tr class="tr-1">
					<th class="td-3">제목</th>
					<td colspan="3"><input type="text" name="msgTitle"
						class="input-form"></td>
					<th class="td-3">수신자</th>
					<td><input type="hidden" name="receiver" value="<%=memberId%>">
						<%=memberId%></td>
						<input type="hidden" name="writer" value="<%=m.getMemberId()%>">
				</tr>
				<tr class="tr-1">
					<td colspan="7" style="text-align: left;"><textarea
							id="msgContent" name="msgContent" class="input-form"></textarea></td>
				</tr>
				<tr>
					<td colspan="7"><button type="submit" class="btn bc1 bs4">쪽지보내기</button></td>
				</tr>
			</table>
		</form>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>