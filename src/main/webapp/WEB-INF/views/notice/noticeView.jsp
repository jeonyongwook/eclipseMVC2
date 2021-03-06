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
		<div class="page-title">????????????</div>
		<table class="tbl" id="noticeView">
			<tr class="tr-3">
				<th colspan="6"><%=n.getNoticeTitle() %></th>
			</tr>
			<tr class="tr-1">
				<th class="td-3">?????????</th>
				<td><%=n.getNoticeWriter() %></td>
				<th class="td-3">?????????</th>
				<td><%=n.getReadCount() %></td>
				<th class="td-3">?????????</th>
				<td><%=n.getReqDate() %></td>
			</tr>
			<tr class="tr-1">
				<th class="td-3">????????????</th>
				<td colspan="5">
					<%if(n.getFilename()!=null) {%>
						<img src="/img/file.png" width="16px">
						<a href="/fileDown.do?noticeNo=<%=n.getNoticeNo() %>"><%=n.getFilename() %></a>
					<%} %>
				</td>
			</tr>
			<tr class="tr-1">
				<th class="td-3">??????</th>
				<td colspan="5">
					<div id="noticeContent"><%=n.getNoticeContentBr() %></div>
				</td>
			</tr>
			<%if(m!=null&&m.getMemberId().equals(n.getNoticeWriter())) {%>
			<tr class="tr-1">
				<th colspan="6">
					<a class="btn bc44" href="/noticeUpdateFrm.do?noticeNo=<%=n.getNoticeNo() %>">??????</a>
					<button class="btn bc44" onclick="noticeDelete('<%=n.getNoticeNo() %>');">??????</button>
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
						<button type="submit" class="btn bc1 bs4">??????</button>
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
									<a href="javascript:void(0)" onclick="modifyComment(this,'<%=nc.getNcNo()%>','<%=n.getNoticeNo()%>')">??????</a>
									<a href="javascript:void(0)" onclick="deleteComment(this,'<%=nc.getNcNo()%>','<%=n.getNoticeNo()%>')">??????</a>
								<%} %>
								<a href="javascript:void(0)" class="recShow">????????????</a>	
							<%} //?????? ???????????? ????????? ??????%>
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
									<button type="submit" class="btn bc1 bs4">??????</button>
								</li>
							</ul>
						</form>
					</div>
				<%} //????????? ?????? form ????????????%>
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
											<a href="javascript:void(0)" onclick="modifyComment(this,'<%=ncc.getNcNo()%>','<%=n.getNoticeNo()%>')">??????</a>
											<a href="javascript:void(0)" onclick="deleteComment(this,'<%=ncc.getNcNo()%>','<%=n.getNoticeNo()%>')">??????</a>
										<%} %>
									<%} %>
								</p>
							</li>
						</ul>
					<%} //??????????????? ??????????????? ???????????? ??????%>
				<%}//????????? ????????? for??? ?????? %>
			<%}//?????? ????????? for??? ?????? %>
		</div>
		<script>
			function noticeDelete(noticeNo){
				if(confirm("?????????????????????????")){
					location.href="/noticeDelete.do?noticeNo="+noticeNo;	
				}
			}
			
			$(".recShow").on("click",function(){
				const idx = $(".recShow").index(this);
				if($(this).text()=="????????????"){
					$(this).text("??????");
				}else{
					$(this).text("????????????");
				}
				$(".inputRecommentBox").eq(idx).toggle();
				$(".inputRecommentBox").eq(idx).find("textarea").focus();
			});
			
			function modifyComment(obj,ncNo,noticeNo){
				$(obj).parent().prev().show();//textarea??? ????????? ?????????
				$(obj).parent().prev().prev().hide();//?????? ????????? ???????????? ??????
				//??????->????????????
				$(obj).text("????????????");
				$(obj).attr("onclick","modifyComplete(this,'"+ncNo+"','"+noticeNo+"')");
				//??????->????????????
				$(obj).next().text("????????????");
				$(obj).next().attr("onclick","modifyCancel(this,'"+ncNo+"','"+noticeNo+"')");
				//???????????? ????????????
				$(obj).next().next().hide();
			}
			function modifyComplete(obj,ncNo,noticeNo) {
				//form?????? ??????
				const form=$("<form action='/noticeCommentUpdate.do' method='post'></form>");
				//form?????? ???????????? input?????? ??????(ncNo)
				form.append($("<input type='text' name='ncNo' value='"+ncNo+"'>"));
				//form?????? ???????????? input?????? ??????(noticeNo)
				form.append($("<input type='text' name='noticeNo' value='"+noticeNo+"'>"));
				//form?????? ???????????? ????????? ?????? ????????? ???????????? textarea??? ??????
				form.append($(obj).parent().prev());
				//????????? form????????? html???????????? ??????
				$("body").append(form);
				//form?????? submit
				form.submit();
			} 
			function modifyCancel(obj,ncNo,noticeNo) {
				$(obj).parent().prev().hide();
				$(obj).parent().prev().prev().show();
				//????????????->??????
				$(obj).prev().text("??????");
				$(obj).prev().attr("onclick", "modifyComment(this,'"+ncNo+"','"+noticeNo+"')");
				//????????????->??????
				$(obj).text("??????");
				$(obj).attr("onclick", "deleteComment(this,'"+ncNo+"','"+noticeNo+"')");
				//?????????????????? ?????????
				$(obj).next().show();
			}
			function deleteComment(obj,ncNo,noticeNo){
				if(confirm("????????? ?????????????????????????")){
					location.href="/deleteComment.do?ncNo="+ncNo+"&noticeNo="+noticeNo;
				}
				
			}
		</script>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>