<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.page-content h3 {
	margin-top: 50px;
}

.ajaxResult {
	min-height: 100px;
	border: 2px solid #ccc;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">AJAX</div>

		<h3>1. 서버 호출하기</h3>
		<button class="btn bc11" id="js">JS방식</button>
		<button class="btn bc11" id="jQ1">jQuery방식</button>

		<h3>2. 서버로 데이터 전송하기</h3>
		<input class="input-form">
		<button class="btn bc11" id="jQ2">전송</button>

		<h3>3. 서버로 데이터 전송하고 서버에서 데이터 받기(기본형데이터)</h3>
		<input type="text" id="su1"> <input type="text" id="su2">
		<button class="btn bc11" id="jQ3">더하기</button>
		<p class="ajaxResult"></p>

		<h3>4. 서버로 데이터를 전송하고 서버에서 객체데이터 받기</h3>
		<input type="text" id="input4">
		<button class="btn bc11" id="jQ4">회원정보조회</button>
		<p class="ajaxResult"></p>
		
		<h3>5. 서버에서 데이터 리스트 받기</h3>
		<button class="btn bc11" id="jQ5">전체회원정보조회</button>
		<p class="ajaxResult"></p>
		
		<h3>6. 서버로 데이터를 전송하고 서버에서 객체 데이터 받기(GSON 사용)</h3>
		<input type="text" id="input6">
		<button class="btn bc11" id="jQ6">회원정보조회</button>
		<p class="ajaxResult"></p>
		
		<h3>7. 서버에서 데이터 리스트 받기(GSON 사용)</h3>
		<button class="btn bc11" id="jQ7">전체회원정보조회</button>
		<p class="ajaxResult"></p>
		
		<h3>8. 비동기 테스트</h3>
		<button class="btn bc11" id="jQ8">비동기호출테스트</button>
	</div>
	<script>
		$("#js").on("click", function() {
			//javascript를 이용해서 ajax 호출
			//1. XMLHttpRequest 객체를 생성
			const xhttp = new XMLHttpRequest();
			//2. 요청정보설정
			xhttp.open("GET", "/ajaxTest1.do", true);//메소드, 요청url, 비동기방식여부
			//3. 서버요청처리에 따른 결과를 수행할 함수작성
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					//요청이 다 끝나고 결과가 정상인 경우
					console.log("서버요청완료");
				} else if (this.readyState == 4 && this.status == 404) {
					//요청이 다 끝나고 결과가 404에러인 경우
					console.log("주소를 찾을 수 없습니다");
				}
			}
			//4. 서버에 요청
			xhttp.send();
		})
		$("#jQ1").on("click", function() {
			$.ajax({
				url : "/ajaxTest1.do",
				type : "GET",
				success : function() {
					console.log("서버 요청 완료");
				},
				error : function() {
					console.log("에러발생");
				},
				complete : function() {
					console.log("무조건 실행");
				}
			});
		})
		$("#jQ2").on("click", function() {
			const inputVal = $(this).prev().val();
			console.log(inputVal);
			$.ajax({
				url : "/ajaxTest2.do",
				type : "get",
				data : {
					input1 : inputVal
				},
				success : function() {
					console.log("전송 완료");
				},
				error : function() {
					console.log("전송실패");
				},
				complete : function() {
					console.log("무조건 실행2");
				}
			})
		})
		$("#jQ3").on("click", function() {
			const su1 = $("#su1").val();
			const su2 = $("#su2").val();
			const result = $(this).next();
			$.ajax({
				url : "/ajaxTest3.do",
				type : "post",
				data : {
					num1 : su1,
					num2 : su2
				},
				success : function(data) {
					result.text(data);
					console.log(data);
					console.log("서버호출완료");
				},
				error : function() {
					console.log("서버호출실패");
				}
			});
		});
		$("#jQ4").on("click", function() {
			const memberId = $("#input4").val();
			const result = $(this).next();
			$.ajax({
				url : "/ajaxTest4.do",
				data : {
					memberId : memberId
				},
				type : "post",
				success : function(data) {
					result.empty();//이전 출력내용 삭제
					if (data == null) {
						result.append("회원정보를 조회할 수 없습니다.");
					} else {
						result.append("아이디 : " + data.memberId + "<br>");
						result.append("비밀번호 : " + data.memberPw + "<br>");
						result.append("이름 : " + data.memberName + "<br>");
					}
				},
				error : function() {
					console.log("서버호출실패");
				}
			});
		});
		$("#jQ5").on("click", function() {
			const result=$(this).next();
			$.ajax({
				url : "/ajaxTest5.do",
				type : "get",
				success : function(data) {
					result.empty();
					for(let i=0;i<data.length;i++) {
						result.append(data[i].memberNo+"/"+data[i].memberId+"/"+data[i].memberName+"<br>");
					}
				},
				error : function() {
					console.log("서버호출실패");
				}
			});
		});
		$("#jQ6").on("click", function() {
			const memberId=$("#input6").val();
			const result=$(this).next();
			$.ajax({
				url : "/ajaxTest6.do",
				data : {memberId:memberId},
				type : "get",
				success : function(data) {
					result.empty();//이전 출력내용 삭제
					if (data == null) {
						result.append("회원정보를 조회할 수 없습니다.");
					} else {
						result.append("아이디 : " + data.memberId + "<br>");
						result.append("비밀번호 : " + data.memberPw + "<br>");
						result.append("이름 : " + data.memberName + "<br>");
					}
				},
				error : function() {
					console.log("서버호출실패");
				}
			});
		});
		$("#jQ7").on("click", function() {
			const result=$(this).next();
			$.ajax({
				url : "/ajaxTest7.do",
				type : "get",
				success : function(data) {
					result.empty();
					for(let i=0;i<data.length;i++) {
						result.append(data[i].memberNo+"/"+data[i].memberId+"/"+data[i].memberName+"<br>");
					}
				},
				error : function() {
					console.log("서버호출실패");
				}
			});
		});
		$("#jQ8").on("click", function(){
			let test=10;
			console.log("이벤트 시작 : "+test);
			$.ajax({
				url : "/ajaxTest8.do",
				type : "get",
				success : function(data) {
					test=data;
					console.log("ajax success 함수 내부 : "+test);
				},
				error : function() {
					console.log("서버호출실패");
				}
			}).then(function(){
				console.log("이벤트 끝 : "+test);
			})
		});
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>