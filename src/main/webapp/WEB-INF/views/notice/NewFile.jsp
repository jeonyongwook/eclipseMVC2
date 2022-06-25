<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.0.js"></script>
<style>
.open {
	display: none;
}
</style>
</head>
<body>

	<a href="javascript:void(0)" class="click">답글달기</a>
	<div class="open">ㅅㅄㅂ</div>
	<script>
		$(function() {
			$(".click").on("click", function() {
				$(".open").css.display("block");
			});
		});
	</script>
</body>
</html>