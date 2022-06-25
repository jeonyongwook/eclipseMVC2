<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=255s4c7p0n&submodules=geocoder"></script>

</head>
<style>
	.address-wrap>.input-form{
		width:60%;
		display:inline-block;
	}
	#postcode{
		width:40%;
	}
</style>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">지도 API</div>
		<h2>1. 다음 주소찾기 api</h2>
		<div class="address-wrap">
			<input type="text" name="postcode" id="postcode" class="input-form" placeholder="우편번호">
			<button class="btn bc1" onclick="searchAddr();">주소찾기</button>
			<input type="text" name="address" id="address" class="input-form" placeholder="주소">
			<input type="text" name="detailAddress" id="detailAddress" class="input-form" placeholder="상세주소">
		</div>
		<br><br>
		<h2>2. 네이버 지도 api</h2>
		<div id="map" style="width:100%;height:500px;"></div>
	</div>
	<script>
		$(function(){
			//아무설정없이 지도객체 생성하면 서울시청 중심으로 지도 생성
			//const map=new naver.maps.Map("map");
			const map=new naver.maps.Map("map",{
				center : new naver.maps.LatLng(37.533837,126.896836),
				zoom : 17,
				zoomControl : true,
				zoomControlOptions : {
					position : naver.maps.Position.TOP_RIGHT,
					style : naver.maps.ZoomControlStyle.SMALL
				}
			});
			const marker = new naver.maps.Marker({
				position : new naver.maps.LatLng(37.533837,126.896836),
				map : map
			});
			let cententString = [
				"<div class='iw_inner'>",
				"	<h3>KH정보교육원</h3>",
				"	<p>서울시 영등포구 선유동2로 57 이레빌딩 19F A강의장</p>",
				"</div>"
			].join("");
			let infoWindow=new naver.maps.InfoWindow();
			//마커에 클릭이벤트 생성
			naver.maps.Event.addListener(marker,"click",function(e){
				if(infoWindow.getMap()){//마커옮길때 정보창이 지도에 존재하면
					infoWindow.close();	//정보창 닫기
					return;
				}
				//마커 클릭시 infoWindow에 정보를 삽입하여 객체 생성
				infoWindow=new naver.maps.Infowindow({
					content : contentString	
				});
				//생성된 infoWindow를 map의 marker위치에 생성
				infoWindow.open(map,marker);
			});
			naver.maps.Event.addListener(map,"click",function(e){
				marker.setPosition(e.coord);
				if(infoWindow.getMap()){//마커옮길때 정보창이 지도에 존재하면
					infoWindow.close();	//정보창 닫기
					return;
				}
				//위경도를 통해 해당위치의 주소값 알아내기
				naver.maps.Service.reverseGeocode({
					location : new naver.maps.LatLng(e.coord.lat(),e.coord.lng())
				},function(status, response){
					if(status!=naver.maps.Service.Status.OK){
						return alert("주소를 찾을 수 없습니다");
					}
					const result = response.result;
					const items=result.items;
					const address =items[1].address;
					cententString = [
						"<div class='iw_inner'>",
						"	<p>"+address+"</p>",
						"</div>"
					].join("");
				});
			});
			//지도를 클릭했을때 해당위치로 마커 이동
			
		});
	
		function searchAddr() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
					// 예제를 참고하여 다양한 활용법을 확인해 보세요.		
					$("#postcode").val(data.zonecode);
					$("#address").val(data.roadAddress);
					$("detailAddress").focus();
				}
			}).open();
		}
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>