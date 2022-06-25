<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	Msg mv=(Msg)request.getAttribute("mv");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#msgView th,#msgView td{
		border:1px solid #eee;
	}
	#msgContent{
		min-height:300px;
		text-align:left;
		font-family:ns-light;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
		<div class="page-content">
			<div class="page-title">쪽지</div>
		<table class="tbl" id="msgView">
			<tr class="tr-3">
				<th colspan="6"><%=mv.getMsgTitle() %></th>
			</tr>
			<tr class="tr-1">
				<th class="td-3">작성자</th>
				<td><%=mv.getWriter() %></td>
				<th class="td-3">작성일</th>
				<td><%=mv.getReqDate() %></td>
			</tr>
			<tr class="tr-1">
				<th class="td-3">내용</th>
				<td colspan="5">
					<div id="msgContent"><%=mv.getMsgContent() %></div>
				</td>
			</tr>
		</table>
		</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>