<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	Member member=(Member)request.getAttribute("member");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.input-wrap{
			padding:15px;
		}
		.input-wrap>label{
			font-size:1.1em;
			margin-bottm:10px;
			display:block;
		}
		[name=updateFrm] .btn-box{
			text-align:center;
			margin-top:30px;
		}
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="page-content">
		<div class="page-title">마이페이지</div>
		<form action="/updateMember.do" method="post" name="updateFrm">
			<div class="input-wrap">
				<label for="memberId">아이디</label>
				<input type="text" id="memberId" name="memberId" class="input-form" value="<%=member.getMemberId() %>" readonly>
			</div>
			<div class="input-wrap">
				<label for="memberPw">비밀번호</label>
				<input type="password" id="memberPw" name="memberPw" class="input-form" value="<%=member.getMemberPw() %>">
			</div>
			<div class="input-wrap">
				<label for="memberName">이름</label>
				<input type="text" id="memberName" name="memberName" class="input-form" value="<%=member.getMemberName() %>" readonly>
			</div>
			<div class="input-wrap">
				<label for="phone">전화번호</label>
				<input type="text" id="phone" name="phone" class="input-form" value="<%=member.getPhone() %>">
			</div>
			<div class="input-wrap">
				<label for="address">주소</label>
				<input type="text" id="address" name="address" class="input-form" value="<%=member.getAddress() %>">
			</div>
			<div class="input-wrap">
				<label for="memberLevel">회원등급</label>
				<%if(member.getMemberLevel()==0) {%>
				<input type="text" id="memberLevel" name="memberLevel" class="input-form" value="관리자" disabled>
				<%} else if(member.getMemberLevel()==1) {%>
				<input type="text" id="memberLevel" name="memberLevel" class="input-form" value="정회원" disabled>
				<%} else if(member.getMemberLevel()==2) {%>
				<input type="text" id="memberLevel" name="memberLevel" class="input-form" value="준회원" disabled>
				<%} %>
			</div>
			<div class="input-wrap">
				<label for="enrollDate">가입일</label>
				<input type="text" id="enrollDate" name="enrollDate" class="input-form" value="<%=member.getEnrollDate() %>" readonly>
			</div>
			<div class="btn-box">
				<button type="submit" class="btn bc11 bs2">정보수정</button>
				<%if(member.getMemberLevel()==0) {%>
					<a class="btn bc66 bs2" href="/adminPage.do">회원관리</a>
				<%} else{%>
					<a class="btn bc66 bs2" href="/deleteMember.do?memberNo=<%=member.getMemberNo() %>">회원탈퇴</a>
				<%} %>
			</div>
		</form>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>