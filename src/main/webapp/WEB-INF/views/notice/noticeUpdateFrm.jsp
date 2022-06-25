<%@page import="kr.or.iei.notice.model.vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Notice n = (Notice) request.getAttribute("n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.noticeUpdateFrm td, .noticeUpdateFrm th{
		border:1px solid #ccc;
	}
	.file-box{
		display:flex;
		align-items:center;
		justify-content:center;
	}
	.file-box>*{
		padding:0.2rem 0.8rem;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">공지사항 수정</div>
		<form action="/noticeUpdate.do" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
			<table class="tbl noticeUpdateFrm">
				<tr class="tr-1">
					<th class="td-3">제목</th>
					<td>
						<input type="text" name="noticeTitle"
						class="input-form" value="<%=n.getNoticeTitle()%>">
					</td>
				</tr>
				<tr class="tr-1">
					<th class="td-3">첨부파일</th>
					<td>
						<input type="hidden" name="status" value="stay">
						<%if(n.getFilepath()!=null) {%>
							<div class="file-box">
								<img src="/img/file.png" width="16px" class="delFile">
								<span class="delFile"><%=n.getFilename() %></span>
								<button type="button" class="btn bc1 delFile" id="fileDelBtn">삭제</button>
								<input type="file" name="file" style="display:none;">
								<input type="hidden" name="oldFilename" value="<%=n.getFilename() %>">
								<input type="hidden" name="oldFilepath" value="<%=n.getFilepath() %>">
							</div>
						<%}else{ %>
							<input type="file" name="file">
						<%} %>	
					</td>
				</tr>
				<tr class="tr-1">
					<th>내용</th>
					<td>
						<textarea class="input-form" name="noticeContent"><%=n.getNoticeContent() %></textarea>
					</td>
				</tr>
				<tr class="tr-1">
					<th colspan="2"><button class="btn bc7 bs4">수정완료</button>
				</tr>
			</table>
		</form>
		<script>
			$("#fileDelBtn").on("click",function(){
				$(".delFile").hide();
				$(this).next().show();
				$("[name=status]").val("delete");
			})
		</script>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>