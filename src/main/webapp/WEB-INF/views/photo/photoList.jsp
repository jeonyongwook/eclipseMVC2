<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int totalCount=(Integer)request.getAttribute("totalCount");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.photoWriteBtn{
		float:right;
	}
	.photoWrapper{
		clear:right;
		margin:50px 0px;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="page-content">
		<div class="page-title">사진게시판<%=totalCount %></div>
		<%if(m!=null) {%>
		<a href="/photoWriteFrm.do" class="btn bc4 photoWriteBtn">글쓰기</a>
		<%} %>
		<div class="photoWrapper posting-wrap">
		
		</div>
		<button class="btn bc44 bs4" id="more-btn" totalCount="<%=totalCount%>" currentCount="0" value="1">더보기</button>
		<!--
		  	totalCount:전체 게시물 수
		  	currentCount:실제로 jsp페이지로 가져온 게시물 수
		  	value:다음 요청시 게시물 시작번호
		  -->
	</div>
	<script>
		$("#more-btn").on("click", function(){
			const amount=10;//가져올 게시물 시작번호
			const start=$(this).val();//더보기 한번 클릭 시 가져올 게시물 수
			$.ajax({
				url : "/photoMore.do",
				type : "post",
				data : {start:start,amount:amount},
				success:function(data){
					for(let i=0;i<data.length;i++){
						const p=data[i]; 
						const item=$("<div>");
						item.addClass("posting-item");
						
						const imgDiv=$("<div>");
						imgDiv.addClass("posting-img");
						const img=$("<img>");
						img.attr("src","/upload/photo/"+p.filepath);
						console.log(p.filepath);
						imgDiv.append(img);
						
						const contentDiv=$("<div>");
						contentDiv.addClass("posting-content");
						const content=$("<p>");
						content.append(p.photoContent);
						contentDiv.append(content);
						
						item.append(imgDiv).append(contentDiv);
						
						$(".photoWrapper").append(item);
					}
					//화면추가 완료 후 다음 더보기를 위한 값 수정
					//value값 변경
					$("#more-btn").val(Number(start)+amount);//start는 현재 버튼의 속성값을 읽어온 값으로 기본자료형이 String
					const currVal=Number($("#more-btn").attr("currentCount"));
					$("#more-btn").attr("currentCount", currVal+data.length);
					const totalCount=Number($("#more-btn").attr("totalCount"));
					if(totalCount==(currVal+data.length)){
						$("#more-btn").css("display","none");
						/* $("#more-btn").attr("disabled",true);
						$("#more-btn").css("cursor","not-allowed"); */
					}
				},
				error:function(){
					console.log("서버호출실패");
				}
			})
		});
		$(function(){
			$("#more-btn").click();
		})
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>