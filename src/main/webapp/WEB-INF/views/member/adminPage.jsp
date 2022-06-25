<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		ArrayList<Member> list=(ArrayList<Member>)request.getAttribute("list");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리페이지</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">회원관리</div>
		<table class="tbl tbl-hover">
			<tr class="tr-3">
				<th>선택</th>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일</th>
				<th>회원등급</th>
				<th>등급변경</th>
			</tr>
			<%for(Member member : list){ %>
			<tr class="tr-1">
				<th><input type="checkbox" class="chk"></th>
				<td><%=member.getMemberNo() %></td>
				<td><%=member.getMemberId() %></td>
				<td><%=member.getMemberName() %></td>
				<td><%=member.getPhone() %></td>
				<td><%=member.getAddress() %></td>
				<td><%=member.getEnrollDate() %></td>
				<td>
					<%if(member.getMemberLevel()==0){ %>
						<select class="input-form">
							<option value="0" selected>관리자</option>
							<option value="1">정회원</option>
							<option value="2">준회원</option>
						</select>
					<%}else if(member.getMemberLevel()==1){ %>
						<select class="input-form">
							<option value="0">관리자</option>
							<option value="1" selected>정회원</option>
							<option value="2">준회원</option>
						</select>
					<%}else if(member.getMemberLevel()==2){ %>
						<select class="input-form">
							<option value="0">관리자</option>
							<option value="1">정회원</option>
							<option value="2" selected>준회원</option>
						</select>
					<%} %>
				</td>
				<td>
					<button class="btn bc5 changeLevel">등급변경</button>
				</td>
			</tr>
			<%} %>
			<tr>
				<th colspan="9">
					<button class="btn bc44 bs4 checkedChangeLevel">선택회원 등급변경</button>
				</th>
			</tr>
		</table>
	</div>
	<script>
		$(".changeLevel").on("click", function(){
			const memberLevel = $(this).parent().prev().children().val();
			const memberNo=$(this).parent().parent().children().eq(1).text();
			console.log(memberNo,memberLevel);
			location.href="/changeLevel.do?memberNo="+memberNo+"&memberLevel="+memberLevel;
		});
		$(".checkedChangeLevel").on("click",function(){
			const check=$(".chk:checked");
			if(check.length==0){
				alert("선택된 회원이 없습니다.");
				return;
			}
			const num=new Array();
			const level=new Array();
			check.each(function(index,item){
				num.push($(item).parent().next().text());
				level.push($(item).parent().parent().find("select").val());
			});
			location.href="/checkedChangeLevel.do?num="+num.join("/")+"&level="+level.join("/");
		});
		
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>