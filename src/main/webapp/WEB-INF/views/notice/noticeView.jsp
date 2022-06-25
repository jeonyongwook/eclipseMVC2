<%@page import="kr.or.iei.notice.model.vo.NoticeComment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.iei.notice.model.vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	Notice n=(Notice)request.getAttribute("n");
    	ArrayList<NoticeComment> commentList
    	=(ArrayList<NoticeComment>)request.getAttribute("commentList");
    	ArrayList<NoticeComment> reCommentList
    	=(ArrayList<NoticeComment>)request.getAttribute("reCommentList");	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#noticeView th,#noticeView td{
		border:1px solid #eee;
	}
	#noticeContent{
		min-height:300px;
		text-align:left;
		font-family:ns-light;
	}
	
	.inputCommentBox{
		margin:50px;
	}	
	.inputCommentBox>form>ul{
		list-style-type:none;
		display:flex;
	}
	.inputCommentBox>form>ul>li:first-child{
		width:15%;
		display:flex;
		justify-content:center;
		align-items:center;
	}
	.inputCommentBox>form>ul>li:first-child>span{
		font-size:80px;
		color:#ccc;
	}
	.inputCommentBox>form>ul>li:nth-child(2){
		width:75%;
	}
	.inputCommentBox>form>ul>li:nth-child(2)>textarea.input-form{
		height:96px;
		min-height:96px;
	}
	.inputCommentBox>form>ul>li:last-child{
		width:10%;
	}
	.inputRecommentBox{
		margin:30px 0px;
		display:none;
	}
	.inputRecommentBox>form>ul{
		list-style-type:none;
		display:flex;
	}
	.inputRecommentBox>form>ul>li:first-child{
		width:15%;
		display:flex;
		justify-content:center;
		align-items:center;
	}
	.inputRecommentBox>form>ul>li:first-child>span{
		font-size:50px;
		color:#ccc;
	}
	.inputRecommentBox>form>ul>li:nth-child(2){
		width:80%;
	}
	.inputRecommentBox>form>ul>li:nth-child(2)>textarea.input-form{
		height:96px;
		min-height:96px;
	}
	.inputRecommentBox>form>ul>li:last-child{
		width:10%;
	}
	
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="page-content">
		<div class="page-title">공지사항</div>
		<table class="tbl" id="noticeView">
			<tr class="tr-3">
				<th colspan="6"><%=n.getNoticeTitle() %></th>
			</tr>
			<tr class="tr-1">
				<th class="td-3">작성자</th>
				<td><%=n.getNoticeWriter() %></td>
				<th class="td-3">조회수</th>
				<td><%=n.getReadCount() %></td>
				<th class="td-3">작성일</th>
				<td><%=n.getReqDate() %></td>
			</tr>
			<tr class="tr-1">
				<th class="td-3">첨부파일</th>
				<td colspan="5">
					<%if(n.getFilename()!=null) {%>
						<img src="/img/file.png" width="16px">
						<a href="/fileDown.do?noticeNo=<%=n.getNoticeNo() %>"><%=n.getFilename() %></a>
					<%} %>
				</td>
			</tr>
			<tr class="tr-1">
				<th class="td-3">내용</th>
				<td colspan="5">
					<div id="noticeContent"><%=n.getNoticeContentBr() %></div>
				</td>
			</tr>
			<%if(m!=null&&m.getMemberId().equals(n.getNoticeWriter())) {%>
			<tr class="tr-1">
				<th colspan="6">
					<a class="btn bc44" href="/noticeUpdateFrm.do?noticeNo=<%=n.getNoticeNo() %>">수정</a>
					<button class="btn bc44" onclick="noticeDelete('<%=n.getNoticeNo() %>');">삭제</button>
				</th>
			</tr>
			<%} %>
		</table>
		<%if(m!=null) {%>
		<div class="inputCommentBox">
			<form action="/insertComment.do" method="post">
				<ul>
					<li>
						<span class="material-icons">account_box</span>
					</li>
					<li>
						<input type="hidden" name="ncWriter" value="<%=m.getMemberId() %>">
						<input type="hidden" name="noticeRef" value="<%=n.getNoticeNo() %>">
						<input type="hidden" name="ncRef" value="0">
						<textarea class="input-form" name="ncContent"></textarea>
					</li>
					<li>
						<button type="submit" class="btn bc1 bs4">등록</button>
					</li>
				</ul>
			</form>
		</div>
		<%} %>
		<div class="commentBox">
			<%for(NoticeComment nc: commentList) {%>
				<ul class="posting-comment">
					<li>
						<span class="material-icons">account_box</span>
					</li>
					<li>
						<p class="comment-info">
							<span><%=nc.getNcWriter() %></span>
							<span><%=nc.getNcDate() %></span>
						</p>
						<p class="comment-content"><%=nc.getNcContent() %></p>
						<textarea name="ncContent" class="input-form" style="display:none;min-height:90px"><%=nc.getNcContent() %></textarea>
						<p class="comment-link">
							<%if(m!=null) {%>
								<%if(m.getMemberId().equals(nc.getNcWriter())) {%>
									<a href="javascript:void(0)" onclick="modifyComment(this,'<%=nc.getNcNo()%>','<%=n.getNoticeNo()%>')">수정</a>
									<a href="javascript:void(0)" onclick="deleteComment(this,'<%=nc.getNcNo()%>','<%=n.getNoticeNo()%>')">삭제</a>
								<%} %>
								<a href="javascript:void(0)" class="recShow">답글달기</a>	
							<%} //댓글 링크모음 로그인 체크%>
						</p>
					</li>
				</ul>
				<%if(m!=null) {%>
					<div class="inputRecommentBox">
						<form action="/insertComment.do" method="post">
							<ul>
								<li>
									<span class="material-icons">subdirectory_arrow_right</span>
								</li>
								<li>
									<input type="hidden" name="ncWriter" value="<%=m.getMemberId() %>">
									<input type="hidden" name="noticeRef" value="<%=n.getNoticeNo() %>">
									<input type="hidden" name="ncRef" value="<%=nc.getNcNo()%>">
									<textarea class="input-form" name="ncContent"></textarea>
								</li>
								<li>
									<button type="submit" class="btn bc1 bs4">등록</button>
								</li>
							</ul>
						</form>
					</div>
				<%} //대댓글 입력 form 작성조건%>
				<%for(NoticeComment ncc : reCommentList) {%>
						<%if(ncc.getNcRef()==nc.getNcNo()) {%>
						<ul class="posting-comment reply">
							<li>
								<span class="material-icons">subdirectory_arrow_right</span>
								<span class="material-icons">account_box</span>
							</li>
							<li>
								<p class="comment-info">
									<span><%=ncc.getNcWriter() %></span>
									<span><%=ncc.getNcDate() %></span>
								</p>
								<p class="comment-content"><%=ncc.getNcContent() %></p>
								<textarea name="ncContent" class="input-form" style="display:none;min-height:90px;"><%=ncc.getNcContent() %></textarea>
								<p class="comment-link">
									<%if(m!=null){ %>
										<%if(m.getMemberId().equals(ncc.getNcWriter())) {%>
											<a href="javascript:void(0)" onclick="modifyComment(this,'<%=ncc.getNcNo()%>','<%=n.getNoticeNo()%>')">수정</a>
											<a href="javascript:void(0)" onclick="deleteComment(this,'<%=ncc.getNcNo()%>','<%=n.getNoticeNo()%>')">삭제</a>
										<%} %>
									<%} %>
								</p>
							</li>
						</ul>
					<%} //해당댓글의 대댓글인지 검사하는 조건%>
				<%}//대댓글 출력용 for문 종료 %>
			<%}//댓글 출력용 for문 종료 %>
		</div>
		<script>
			function noticeDelete(noticeNo){
				if(confirm("삭제하시겠습니까?")){
					location.href="/noticeDelete.do?noticeNo="+noticeNo;	
				}
			}
			
			$(".recShow").on("click",function(){
				const idx = $(".recShow").index(this);
				if($(this).text()=="답글달기"){
					$(this).text("취소");
				}else{
					$(this).text("답글달기");
				}
				$(".inputRecommentBox").eq(idx).toggle();
				$(".inputRecommentBox").eq(idx).find("textarea").focus();
			});
			
			function modifyComment(obj,ncNo,noticeNo){
				$(obj).parent().prev().show();//textarea를 화면에 보여줌
				$(obj).parent().prev().prev().hide();//기존 댓글은 화면에서 숨김
				//수정->수정완료
				$(obj).text("수정완료");
				$(obj).attr("onclick","modifyComplete(this,'"+ncNo+"','"+noticeNo+"')");
				//삭제->수정취소
				$(obj).next().text("수정취소");
				$(obj).next().attr("onclick","modifyCancel(this,'"+ncNo+"','"+noticeNo+"')");
				//답글달기 버튼숨김
				$(obj).next().next().hide();
			}
			function modifyComplete(obj,ncNo,noticeNo) {
				//form태그 생성
				const form=$("<form action='/noticeCommentUpdate.do' method='post'></form>");
				//form태그 자식으로 input태그 추가(ncNo)
				form.append($("<input type='text' name='ncNo' value='"+ncNo+"'>"));
				//form태그 자식으로 input태그 추가(noticeNo)
				form.append($("<input type='text' name='noticeNo' value='"+noticeNo+"'>"));
				//form태그 자식으로 수정한 댓글 내용이 들어있는 textarea를 추가
				form.append($(obj).parent().prev());
				//생성된 form태그를 html본문으로 삽입
				$("body").append(form);
				//form태그 submit
				form.submit();
			} 
			function modifyCancel(obj,ncNo,noticeNo) {
				$(obj).parent().prev().hide();
				$(obj).parent().prev().prev().show();
				//수정완료->수정
				$(obj).prev().text("수정");
				$(obj).prev().attr("onclick", "modifyComment(this,'"+ncNo+"','"+noticeNo+"')");
				//수정취소->삭제
				$(obj).text("삭제");
				$(obj).attr("onclick", "deleteComment(this,'"+ncNo+"','"+noticeNo+"')");
				//답글달기버튼 보여줌
				$(obj).next().show();
			}
			function deleteComment(obj,ncNo,noticeNo){
				if(confirm("댓글을 삭제하시겠습니까?")){
					location.href="/deleteComment.do?ncNo="+ncNo+"&noticeNo="+noticeNo;
				}
				
			}
		</script>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>