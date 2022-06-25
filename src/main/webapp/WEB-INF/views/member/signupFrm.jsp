<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		margin-bottom:10px;
		display:block;
	}
	submit-btn{
		padding:15px;
		margin:20px 0px;
	}
	.input-wrap>.id-wrap{
		display:flex;
	}
	.input-wrap>.id-wrap>#memberId{
		width:80%;
		height:46.59px;
	}
	.input-wrap>.id-wrap>#idChkBtn{
		width:20%;
		height:46.59px;
		line-height:10px
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="page-content">
		<div class="page-title">회원가입</div>
		<form name="checkIdFrm" action="/checkId.do">
			<input type="hidden" name="checkId">
		</form>
		
		<form action="/signup.do" method="post">
			<div class="input-wrap">
				<label for="memberId">아이디<span id="ajaxCheckResult"></span></label>
				<div class="id-wrap">
					<input type="text" name="memberId" id="memberId" class="input-form">
					<button type="button" id="idChkBtn" class="btn bc2">중복체크</button>
				</div>
			</div>
			<div class="input-wrap">
				<label for="memberPw">비밀번호</label>
				<input type="password" name="memberPw" id="memberPw" class="input-form">
			</div>
			<div class="input-wrap">
				<label for="memberPw">비밀번호확인</label>
				<input type="password" name="memberPwRe" id="memberPwRe" class="input-form">
			</div>
			<div class="input-wrap">
				<label for="memberName">이름</label>
				<input type="text" name="memberName" id="memberName" class="input-form">
			</div>
			<div class="input-wrap">
				<label for="phone">전화번호</label>
				<input type="text" name="phone" id="phone" class="input-form">
			</div>
			<div class="input-wrap">
				<label for="address">주소</label>
				<input type="text" name="address" id="address" class="input-form">
			</div>
			<div class="submit-btn">
				<button type="submit" class="bc bc88 bs4">회원가입</button>
			</div>
		</form>
	</div>
	<script>
		$("[name=memberId]").eq(1).on("keyup",function(){
			const memberId=$(this).val();
			const input=$(this);
			$.ajax({
				url : "/ajaxCheckId.do",
				type : "get",
				data : {memberId:memberId},
				success : function(data){
					if(data=="1"){
						$("#ajaxCheckResult").text("이미 사용중인 아이디입니다.");
						$("#ajaxCheckResult").css("color","#ff2e63");
						input.css("border", "1px solid #ff2e63");
					}else if(data=="0"){
						$("#ajaxCheckResult").text("사용 가능한 아이디입니다.");
						$("#ajaxCheckResult").css("color","#00adb5");
						input.css("border", "1px solid #00adb5");
					}
				},
				error : function(){
					console.log("서버요청실패");
				}
			})
		})
		$("#idChkBtn").on("click",function(){
			const memberId=$(this).prev().val();
			if(memberId==""){
				alert("아이디를 입력하세요");
				return;
			}
			$("[name=checkId]").val(memberId);
			const popup=window.open("","checkId","left:700px, top=300px,width:300px, height=200px,menubar=no, status=no,scrollbars=yes")
			$("[name=checkIdFrm]").attr("target","checkId");
			$("[name=checkIdFrm]").submit();
		})
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>