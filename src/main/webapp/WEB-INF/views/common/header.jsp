<%@page import="kr.or.iei.member.model.vo.Msg"%>
<%@page import="kr.or.iei.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Member m = (Member) session.getAttribute("m");
Msg msg=(Msg)session.getAttribute("msg");
%>
<!-- 구글 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!-- jquery -->
<script src="/js/jquery-3.6.0.js"></script>
<!-- 기본 CSS -->
<link rel="stylesheet" href="/css/default.css" />
<link rel="stylesheet" href="/css/header.css" />
<!-- 기본 js -->
<script src="/js/default.js"></script>
<header>
	<div class="site-logo">
		<a href="/">LS</a>
	</div>
	<nav>
		<ul class="navi">
			<li><a href="/noticeList.do?reqPage=1">공지사항</a></li>
			<li><a href="#" id="msg">자유게시판</a></li>
			<li><a href="/ajax.do">ajax</a></li>
			<li><a href="/photoList.do">사진게시판</a></li>
			<li><a href="#">API</a>
				<ul class="sub-navi">
					<li><a href="/map.do">지도 API</a></li>
					<li><a href="/email.do">EMAIL API</a></li>
					<li><a href="/pay.do">결제 API</a></li>
				</ul>
			</li>
			<%if(m!=null) {%>
			<li><a href="#">쪽지</a>
				<ul class="sub-navi">
					<li><a href="/msgList.do?reqPage=1&memberId=<%=m.getMemberId()%>">받은 쪽지</a></li>
					<li><a href="/sendList.do?reqPage=1&memberId=<%=m.getMemberId()%>">보낸 쪽지</a></li>
				</ul>
			</li>
			<%} %>
		</ul>
	</nav>
	<div class="header-link">
		<%
		if (m == null) {
		%>
		<button class="btn bc11 modal-open-btn" target="#login-modal">로그인</button>
		<a class="btn bc11" href="/signupFrm.do">회원가입</a>
		<%
		} else {
		%>
		<a class="btn bc11" href="/mypage2.do?memberId=<%=m.getMemberId()%>"><%=m.getMemberName()%></a>
		<a class="btn bc11" href="/logout.do">로그아웃</a>
		<%
		}
		%>
	</div>
</header>
<%
if (m == null) {
%>
<div id="login-modal" class="modal-bg">
	<div class="modal-wrap">
		<div class="modal-head">
			<h2>로그인</h2>
			<span class="material-icons close-icon modal-close">close</span>
		</div>
		<form action="/signin.do" method="post">
			<div class="modal-content">
				<div class="input-box">
					<label for="memberId">아이디</label> <input type="text"
						name="memberId" id="memberId" class="input-form"
						placeholder="아이디입력">
				</div>
				<div class="input-box">
					<label for="input-box">비밀번호</label> <input type="password"
						name="memberPw" id="memberPw" class="input-form"
						placeholder="비밀번호입력">
				</div>
				<div class="input-box link-box">
					<a href="#">아이디/비밀번호 찾기</a>
				</div>
			</div>
			<div class="modal-foot">
				<button type="submit" class="btn bc11">확인</button>
				<button type="button" class="btn bc1 modal-close">취소</button>
			</div>
		</form>
	</div>
</div>
<%
}
%>