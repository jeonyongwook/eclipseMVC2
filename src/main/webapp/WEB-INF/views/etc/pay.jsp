<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
.shopping {
	overflow: hidden;
}

.shopping>div {
	float: left;
	box-sizing: border-box;
	padding: 30px
}

.goods-img {
	text-align: center;
	width: 60%;
}

.goods-info {
	width: 40;
}

.goods-name {
	padding: 10px;
	border-bottom: 2px solid #ccc;
}

.count>.btn {
	padding: 0.25rem;
}

.goods-info>div {
	padding: 10px;
	font-size: 1.2em;
}

#payment {
	margin-top: 100px
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">결제모듈 API</div>
		<div class="shopping">
			<div class="goods-img">
				<img src="/img/ice1.png">
			</div>
			<div class="goods-info">
				<h2 class="goods-name">엄마는 외계인</h2>
				<div class="price fc-6">
					<span class="fc-6">2000</span>원 <span class="fc-6">(1개당 가격)</span>
				</div>
				<div class="count">
					<span>수량</span>
					<button class="btn bc3">-</button>
					<span class="amount">1</span>
					<button class="btn bc3">+</button>
				</div>
				<div class="total">
					총 <span id="totalPrice">2000</span>원
				</div>
				<button id="payment" class="btn bc1 bs4">결제하기</button>
			</div>

		</div>
	</div>
	<script>
		$(".count>.btn").on("click", function() {
			let currAmount=Number($(".amount").text());
			if($(this).text()=='+'){
				currAmount++;
			}else{
				if(currAmount!=1){
					currAmount--;	
				}
			}
			$(".amount").text(currAmount);
			const price=Number($(".price").children().first().text());
			$("#totalPrice").text(currAmount*price);
		});
		$("#payment").on("click",function(){
			const price =$("#totalPrice").text();
			//거래 고유ID생성을 위해 현재 결제 날짜를 이용해서 처리
			const d=new Date();
			//date 값 생성 시 ""를 더하지 않으면 숫자 + 연산이 되므로 문자 덧셈을 위해 추가
			const date=d.getFullYear()+""+(d.getMonth()+1)+""+d.getDate()+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
			IMP.init("imp77324396"); //결제 API 사용을 위한 식별코드 입력
			IMP.request_pay({
				merchant_uid : "상품코드_"+date, 			//거래 ID
				name : "결제 테스트",						//결제이름
				amount : price,							//결제금액
				buyer_email : "wjsdyddnr2@naver.com",	//구매자 email 주소
				buyer_name : "구매자",
				buyer_tel : "010-3803-0445",
				buyer_addr : "서울시 강북구",
				buyer_postcode : "01070"
			},function(rsp){
				if(rsp.success){
					console.log("결제 완료");
					console.log("고유 ID : "+rsp.imp_uid);
					console.log("상점거래 ID : "+rsp.merchant_uid);
					console.log("결제 금액 : "+rsp.paid_amount);
					console.log("카드승인번호 : "+rsp.apply_num);
					//추가 DB작업이 필요한 경우 이 부분에 결제 내역을 DB에 저장하는 코드 작성
				}else{
					alert("에러내용 : "+rsp.err_msg);
				}
			});
		});
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>