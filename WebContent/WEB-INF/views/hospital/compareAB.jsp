<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- jquery/ajax 사용시 라이브러리를 밑의 링크거는방식: cdm방식으로 추가 (인터넷 될 경우. 안되면 다운받아야함)-->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
    
    <!-- 네이버 클라우드 플랫폼 : 네이버지도 api 사용 -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=z0t072q98j"></script>
    
    <!-- chart 사용 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    
     <script>
	    //차트
	    $(document).ready(function(){
	    	console.log("차트 탔다");
			var ctx = $("#myChart"); // jQuery instance
			// 수치가져오기
			var a = $("#a").val();
			var b = $("#b").val();

			// 차트 그리기
			var myChart = new Chart(ctx, {

				type: 'bar',
				data: {
					labels: ['${article1.hosName}', '${article2.hosName}'],
					datasets: [{
						label: '평균',
						data: [a, b],
						backgroundColor: [
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)'],
							borderColor: [
								'rgba(255, 99, 132, 1)',
								'rgba(54, 162, 235, 1)'],
								borderWidth: 1
							}] 
						},
						options: {
				            plugins:{
				            	// label 숨기기
				               legend:{
				                  display:false
				               }
				            }
				         }
				});
			
			// 차트 다 그렸으니 number로 타입변경후 ','찍어주기
			var num = Number($("#a").val());
	    	$("#a").val(num.toLocaleString())
			var num2 = Number($("#b").val());
	    	$("#b").val(num2.toLocaleString())
			
			});
		</script>
		
		<!-- map 설정 -->
		<script>
			// 병원 위치값 지정해주기 : A병원 = 1
			var x1 = document.getElementById("x1").value;
			var y1 = document.getElementById("y1").value;
			// 병원 위치값 지정해주기 : B병원 = 2
			var x2 = document.getElementById("x2").value;
			var y2 = document.getElementById("y2").value;
			
			// 마커에 병원 정보창 표시할 내용 : A병원 = article1 / B병원 = article2
			var contentString1 = [
		        '<div class="iw_inner">',
		        '   <h3>${article1.hosName}</h3>',
		        '   <p>주소 : ${article1.hosNewAddress}<br />',
		        '      전화번호 : ${article1.hosNum}<br />',
		        '   </p>',
		        '</div>'
		    ].join('');
			var contentString2 = [
		        '<div class="iw_inner">',
		        '   <h3>${article2.hosName}</h3>',
		        '   <p>주소 : ${article2.hosNewAddress}<br />',
		        '      전화번호 : ${article2.hosNum}<br />',
		        '   </p>',
		        '</div>'
		    ].join('');
			// infowindow 객체생성
			var infowindow1 = new naver.maps.InfoWindow({
			    content: contentString1
			});
			var infowindow2 = new naver.maps.InfoWindow({
			    content: contentString2
			});
			
			// 지도 옵션 
			var mapOptions1 = {
				    center: new naver.maps.LatLng(x1, y1),
				    zoom: 18,
				    mapTypeControl : true
				}
			// 지도 옵션 
			var mapOptions2 = {
				    center: new naver.maps.LatLng(x2, y2),
				    zoom: 18,
				    mapTypeControl : true
				}
			// 지도 생성 A병원 / B병원
	        var map1 = new naver.maps.Map('map1', mapOptions1);
	        var map2 = new naver.maps.Map('map2', mapOptions2);
			
			// 마커 A병원
			var marker1 = new naver.maps.Marker({
			    position: new naver.maps.LatLng(x1, y1),
			    map: map1, 
			    // 내 아이콘 사용
			    icon: {
        	        url: '/petBill/resources/imgs/pin_default.png', // 아이콘 경로
        	        size: new naver.maps.Size(22, 36), // 아이콘 크기
        	        origin: new naver.maps.Point(0, 0),
        	        anchor: new naver.maps.Point(11, 35)
        	    }
			});
			// 마커 B병원
			var marker2 = new naver.maps.Marker({
			    position: new naver.maps.LatLng(x2, y2),
			    map: map2, 
			    // 내 아이콘 사용
			    icon: {
        	        url: '/petBill/resources/imgs/pin_default.png', // 아이콘 경로
        	        size: new naver.maps.Size(22, 36), // 아이콘 크기
        	        origin: new naver.maps.Point(0, 0),
        	        anchor: new naver.maps.Point(11, 35)
        	    }
			});
			
			// 마커 클릭이벤트 등록 : 인포 나타났다 사라졌다 하게
			naver.maps.Event.addListener(marker1, "click", function(e) {
			    if (infowindow1.getMap()) {
			        infowindow1.close();
			    } else {
			        infowindow1.open(map1, marker1);
			    }
			});
			naver.maps.Event.addListener(marker2, "click", function(e) {
			    if (infowindow2.getMap()) {
			        infowindow2.close();
			    } else {
			        infowindow2.open(map2, marker2);
			    }
			});
			
			// 병원정보창 띄우기
			infowindow1.open(map1, marker1);
			infowindow2.open(map2, marker2);
		</script>
		
</head>
<body>

	<!-- ajax 영역 -->
	<div id="compareAB" class="divTest">
		<br />
		<!-- A병원 좌표값 -->
		<input type="hidden" id="x1" value="${article1.x}">
		<input type="hidden" id="y1" value="${article1.y}">
		<!-- B병원 좌표값 -->
		<input type="hidden" id="x2" value="${article2.x}">
		<input type="hidden" id="y2" value="${article2.y}">
		
		<!-- 지도 -->
		<table>
			<tr>
				<!-- A병원 -->
				<td><div id="map1" style="width:600px;height:400px;"></div></td>
				<td>&nbsp;&nbsp;</td>
				<!-- B병원 -->
				<td><div id="map2" style="width:600px;height:400px;"></div></td>
			</tr>
		</table>
		<br />

		<table class="table">
			<tr class="table-dark" align="center">
				<th>${article1.hosName}</th>
				<th>${article2.hosName}</th>
			</tr>
			<tr>
				<!-- 각 병원(HashMap)의 value(진료비)평균 출력 -->
				<td>
					<c:if test="${articleA == null}">
						<input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
					</c:if>
					<c:if test="${articleA != null}">
						<c:forEach var="i" items="${articleA}">
							<c:if test="${i.value eq '0'}">
								<input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
							</c:if>
							<c:if test="${i.value ne '0'}">
								<input type="text" id="a" value="${i.value}" style="text-align: right" class="form-control-plaintext" readonly>&nbsp;원
							</c:if>
																				
						</c:forEach>						
					</c:if>
				</td>
		 	  	<td>
					<c:if test="${articleB == null}">
						<input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
					</c:if>
					<c:if test="${articleB != null}">
						<c:forEach var="i" items="${articleB}">
							<c:if test="${i.value eq '0'}">
								<input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
							</c:if>
							<c:if test="${i.value ne '0'}">
								<input type="text" id="b" value="${i.value}" style="text-align: right" class="form-control-plaintext" readonly>&nbsp;원
							</c:if>													
						</c:forEach>		
					</c:if>
		 	  	</td>
		    </tr>
		</table>
		<br />
		
		<!-- 차트 -->
		<div style="width:900px;height:500px;">
			<canvas id="myChart"></canvas>
		</div>
	</div>
	<br /><br />



</body>
</html>