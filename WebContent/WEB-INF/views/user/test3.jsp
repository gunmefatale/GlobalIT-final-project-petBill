<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
.container{
	width:400px;
	height:400px;
}
</style>


<!-- 부트스트랩 --> 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<!-- 차트 -->
<script>
$(document).ready(function(){
	var ctx = $("#myChart");
	
	var a = 11;
	var b = 2;
	var c = 5;
	var d = 4;
	var myChart = new Chart(ctx, {
		
		type: 'bar',
		data: {
			labels: ['전국', '지역(시/도)', '구/동', '리뷰평균'],
			datasets: [
				{
				label: '평균',
				data: [a, b, c, d],
				backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)'],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)'
						],
						borderWidth: 1
					},
				{
				label: '평균2',
				data: [3, 2, 1, 7],
				backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)'],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)'
						],
						borderWidth: 1
					}
				] 
			},
			options: {
				plugins:{
					legend:{
						display:false
					}
				}
			}
	});
});
</script>
</body>
<div class="container">
	<canvas id="myChart"></canvas><!--canvas : 그림을 그릴수 있는 태그  -->
</div>

</html>
