<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">EMAIL API</div>
		<h3>1. 이메일 전송하기</h3>
		<form action="/mailSend1.do" method="post">
			<table class="tbl">
				<tr class="tr-1">
					<th class="td-2">제목</th>
					<td><input type="text" name="mailTitle" class="input-form"></td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">수신자메일</th>
					<td><input type="text" name="receiver" class="input-form"></td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">내용</th>
					<td><textarea class="input-form" name="mailContent"></textarea></td>
				</tr>
				<tr class="tr-1">
					<th colspan="2"><button type="submit" class="btn bc1 bs4">전송</button></th>
				</tr>
			</table>
		</form>
		<h3>2. 이메일 인증</h3>
		<input type="text" id="email">
		<button class="btn bc1" onclick="sendMail();">인증메일 전송</button>
		<div id="auth" style="display: none;">
			<input type="text" id="authCode" placeholder="인증코드입력">
			<button class="btn bc1" id="authBtn">인증하기</button>
			<span id="timeZone"></span> <span id="authMsg"></span>
		</div>
	</div>
	<script>
		let mailCode;
		function sendMail() {
			const email = $("#email").val();
			$.ajax({
				url : "/sendMail2.do",
				data : {
					email : email
				},
				type : "post",
				success : function(data) {
					mailCode = data;
					$("#auth").slideDown();
					authTime();
				},
				error : function() {
					console.log("에러");
				}
			});
		}
		let intervalId;
		function authTime() {
			$("#timeZone").html("<span id='min'>3</span> : <span id='sec'>00</span>");
			intervalId = window.setInterval(function() {
				timeCount();
			}, 1000);
		}
		function timeCount() {
			const min = Number($("#min").text());
			const sec = $("#sec").text();
			if (sec == "00") {
				if (min == 0) {
					mailCode = null;
					clearInterval(intervalId);
				} else {
					$("#min").text(min - 1);
					$("#sec").text(59);
				}
			} else {
				const newSec = Number(sec) - 1;
				if (newSec < 10) {
					$("#sec").text("0" + newSec);
				} else {
					$("#sec").text(newSec);
				}
			}
		}
		/* let intervalId;
		function authTime(){
			$("#timeZone").html("<span id='min'>3</span> : <span id='sec'>00</span>");
			intervalId=window.setInterval(function(){
				timeCount();
			},100);
		};
		function timeCount(){
			const min=Number($("#min").text());
			const sec=$("#sec").text();
			if(sec=="00"){
				if(min==0){
					mailCode=null;
					clearInterval(intervalId);
				}else{
					$("#min").text(min-1);
					$("#sec").text(59);
				}
			}else{
				const newSec=Number(sec)-1;
				if(necSec<10){
					$("#sec").text("0"+newSec);
				}else{
					$("#sec").text(newSec);
				}
			}
		}; */
		$("#authBtn").on("click", function() {
			const msg = $("#authMsg");
			if (mailCode == null) {
				msg.text("인증시간이 만료되었습니다");
				msg.css("color", "red");
			} else {
				if ($("#authCode").val() == mailCode) {
					msg.text("인증성공");
					msg.css("color", "blue");
					clearInterval(intervalId);
					$("#timeZone").hide();
				} else {
					msg.text("인증코드를 확인하세요");
					msg.css("color", "red");
				}
			}
		});
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>