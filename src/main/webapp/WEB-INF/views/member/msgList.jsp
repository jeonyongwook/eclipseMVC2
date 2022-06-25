<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.iei.member.model.vo.Msg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%	
    	ArrayList<Msg> list=(ArrayList<Msg>)request.getAttribute("list");
    	String pageNavi=(String)request.getAttribute("pageNavi");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.msg-tbl a:hover{
			text-decoration:underline;
		}
		.msg-tbl tr{
			border-bottom:1px solid #ccc;
		}
		.msg-tbl th{
			background-color:lightgray;
		}
		.msg-tbl tr>th:first-child{
			width:60%;
		}
		.msg-tbl tr>th:nth-child(2){
			width:20%;
		}
		.msg-tbl tr>td:nth-child(2){
			text-align:center;
		}
		.msg-tbl tr>th:last-child{
			width:20%;
		}
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="page-content">
		<div class="page-title">받은 쪽지</div>
		<table class="tbl tbl-hover msg-tbl">
			<tr>
				<th>제목</th><th>작성자</th><th>받은 날짜</th>
			</tr>
			<%for(Msg l : list){ %>
			<tr class="tr-1">
				<td><a href="/msgView.do?msgNo=<%=l.getMsgNo()%>"><%=l.getMsgTitle() %></a></td>
				<td><a href="/writeMsgFrm.do?memberId=<%=l.getWriter()%>"><%=l.getWriter() %></a></td>
				<td><%=l.getReqDate() %></td>
			</tr>
			<%} %>
		</table>
		<div id="pageNavi"><%=pageNavi %></div>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>