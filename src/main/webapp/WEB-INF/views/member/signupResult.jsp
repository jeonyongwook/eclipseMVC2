<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int result=(Integer)request.getAttribute("result");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="page-content">
		<div class="page-title">회원가입결과</div>
		<%if(result>0){ %>
			<h2>회원가입 성공</h2>
			<script>
				$function(){
					$("button[target='login-modal']").click();
				}
			</script>
		<%} else{%>
			<h2>회원가입실패</h2>
			<a href="/signupFrm.do">회원가입 페이지로 이동</a>
		<%} %>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>