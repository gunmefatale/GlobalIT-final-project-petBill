<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">


<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>petBill</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">	
	<!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">

<script>
$(document).ready(function(){
	var ctx = $("#myChart");
	var a = $("#a").val();
	var b = $("#b").val();
	var c = $("#c").val();
	var d = $("#d").val();
	var myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: ['오늘', '어제', '1주전','1달전'],
			datasets: [{
				label: '신규 회원가입 현황',
				data: [a, b, c, d],
				backgroundColor: [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)'],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)'
						],
						borderWidth: 1
					}] 
				},
				options: {
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							}
						}]
					}
				}
	});
});

//리뷰
$(document).ready(function(){
	var ctx = $("#Chart");
	
	var a = $("#a1").val();
	var b = $("#b2").val();
	var c = $("#c3").val();
	var d = $("#d4").val();
	var myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: ['오늘', '어제', '1주전','1달전'],
			datasets: [{
				label: '리뷰 현황',
				data: [a, b, c, d],
				backgroundColor: [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)'],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)'
						],
						borderWidth: 1
					}] 
				},
				options: {
					//maintainAspectRatio:false //maintainAspectRation:비율을 유지하라는 뜻
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							}
						}]
					}
				}
	});
});
</script>


</head>
  <body>
 		
   <div class="d-flex" id="wrapper">
        <!-- 왼쪽 메인 메뉴 -->
        <div class="border-end bg-white" id="sidebar-wrapper">
        	<!-- 로고 -->
            <div class="sidebar-heading border-bottom bg-light"><a href="/petBill/user/main.pet"><img src="/petBill/resources/imgs/로고화면.png" style="width: 190px; margin-top: 10px;"></a></div>
            <div class="list-group list-group-flush">
            	<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adMain.pet">관리자페이지</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adUserSearch.pet">회원 검색</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adHosModify.pet">병원 등록/수정/삭제</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adPetModify.pet">진료비 수정/삭제</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adReviewStatus.pet">전국 리뷰 현황</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adQuestionList.pet">1:1 문의</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adNoticeList.pet">공지사항 등록</a>
            </div>
        </div>
        <!-- Page content wrapper-->
        <div id="page-content-wrapper">
            <!-- 상단 네비게이션 -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                   <!-- 반응형 동작시 버튼생김 -->
                   <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                       <div class="collapse navbar-collapse" id="navbarSupportedContent">
	                      <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
	                        	
	                        <%-- 위치 변경필요할듯 search(검색)form 조장님 수정부분 --%>
							<li class="searchBar" >
							</li>
					
	                        <li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
	                        <li class="nav-item"><a class="nav-link" href="/petBill/admin/adMain.pet">관리자 페이지</a></li>
	                        <li class="nav-item dropdown"></li>
	                      </ul>
                      </div>
                 </div>
            </nav>
                
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
           <!-- 페이지 내용작성 영역 : Page content-->
            <div class="container-fluid" style="white-space:nowrap; overflow:auto;">
            <br />
	            <div align="center">
		            <table class="table">
			            <tr>
			            	<td>
					            <div style="width:600px;">
									<canvas id="myChart"></canvas><!--canvas : 그림을 그릴수 있는 태그  -->
								</div>
			            	</td>
			            	<td>
					            <div style="width:600px;">
									<canvas id="Chart"></canvas><!--canvas : 그림을 그릴수 있는 태그  -->
								</div>	
			            	</td>
			            </tr>
		            </table>
		        </div>
				
				<input type="hidden" id="a" value="${todaydate}"/>            
				<input type="hidden" id="b" value="${yesterdaydate}"/>            
				<input type="hidden" id="c" value="${yesterdaydate7}"/>            
				<input type="hidden" id="d" value="${yesterdaydate30}"/>            
				<input type="hidden" id="a1" value="${Rtodaydate}"/>            
				<input type="hidden" id="b2" value="${Ryesterdaydate}"/>            
				<input type="hidden" id="c3" value="${Ryesterdaydate7}"/>            
				<input type="hidden" id="d4" value="${Ryesterdaydate30}"/>
            
            	<div align="center">
				
				<table class="table">
				<tr>
					<td>
					<div align="center">
						<c:if test="${count == 0}"> 
				            <table class="table">
								<tr class="table-dark">
				            		<th>
				            			회원 가입 현황
				            		</th>
				            	</tr>
								<tr>
									<td>
										가입한 회원이 없습니다
									</td>
								</tr>            
				            </table>
		       			</c:if>
						<c:if test="${count != 0}">     
				            <table class="table">
				            	<caption>회원가입 현황</caption>
								<tr class="table-dark" align="center">
									<th>회원아이디</th>
									<th>회원닉네임</th>
									<th>가입 날짜</th>
								</tr>
								<c:forEach var="article" items="${NewUserList}">
								<tr>           
									<td>	
										<a href="/petBill/admin/adUserSearch.pet" class="nav-link">${article.id}</a>
									</td>
									<td align="center">
										${article.nickname}
									</td>
									<td align="center">
										<fmt:formatDate value="${article.reg}" pattern="yyyy-MM-dd"/>
									</td>
								</tr>
								</c:forEach>
				            </table>
		       			</c:if>
	       			</div>
					</td>
					<td><!-- 간격벌리는용 td --></td>
					<td>
						<div>
		            		<c:if test="${count == 0}">
								<table class="table">
					            	<tr class="table-dark">
					            		<th>최신 리뷰</th>
					            	</tr>
									<tr>
										<td>리뷰가 없습니다</td>
									</tr> 
								</table>
							</c:if>
							<c:if test="${count != 0}">
					            <table class="table">
					            	<caption>최신 리뷰</caption>
									<tr class="table-dark" align="center">
										<th>작성자</th>
										<th>제목</th>
										<th>병원명</th>
									</tr>
									<c:forEach var="article" items="${NewReviewList}">
										<tr>
											<td align="center">
												${article.reviewId}			
											</td>
											<td>
												<a href="/petBill/admin/adReviewStatus.pet" class="nav-link">${article.reviewSubject}</a>
											</td>
											<td>
												${article.hosname}
											</td>
										</tr>
									</c:forEach>            
					            </table>
				            </c:if>
						</div>
					</td>
				</tr>
	            </table>
	            
       			<br /><br />
       			<table class="table">
	            	<tr class="table-dark">
	            		<th>1:1 문의 </th>
	            	</tr>
					<tr>
						<td>
							읽지않은 문의 <a href="/petBill/admin/adQuestionList.pet" class="page-link">${mtmcount}</a>개 있습니다
						</td>
					</tr>            
	            </table>
       			</div>
       
		</div><!-- container-fluid 내용작성 영역 -->
      </div> <!-- page-content-wrapper 꺼 -->
  </div>      
  	<!-- footer -->
	<footer class="footer">
		<div class="container bottom_border">
			<div class="row">
				<div class=" col-sm-4 col-md col-sm-4  col-12 col">
					<h1 class="headin5_amrc col_white_amrc pt2">🚑𝖕𝖊𝖙𝕭𝖎𝖑𝖑</h1>
				</div>
				
				<div class=" col-sm-4 col-md col-sm-4  col-12 col">
					<h5 class="headin5_amrc col_white_amrc pt2">🐕Bootstrap</h5>
					<!--headin5_amrc-->
					<p class="mb10">http://bootstrapk.com</p>
				</div>
				
				<div class=" col-sm-4 col-md col-sm-4  col-12 col">
					<h5 class="headin5_amrc col_white_amrc pt2">🐈Naver</h5>
					<!--headin5_amrc-->
					<p class="mb10">https://developers.naver.com/main</p>
				</div>
				
				<div class=" col-sm-4 col-md col-sm-4  col-12 col">
					<h5 class="headin5_amrc col_white_amrc pt2">🦮Kakao</h5>
					<!--headin5_amrc-->
					<p class="mb10">https://tableblog.tistory.com/117</p>
					<p class="mb10">https://developers.kakao.com/</p>
				</div>
				
				<div class=" col-sm-4 col-md col-sm-4  col-12 col">
					<h5 class="headin5_amrc col_white_amrc pt2">🐕‍🦺‍Chartjs</h5>
					<!--headin5_amrc-->
				<p class="mb10">https://www.chartjs.org/</p>
				</div>
			</div>
		</div>
		
		<div class="container">
			<ul class="foote_bottom_ul_amrc">
				<li>👨‍⚕️이건우</li>
				<li>👩‍⚕️안혜란</li>
				<li>👨‍⚕️김태준</li>
				<li>👩‍⚕️정샛별</li>
				<li>👨‍⚕️이용훈</li>
			</ul>
		</div>
	</footer>	
        <!-- 2. 부트스트랩 core JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- 3. Core theme JS -->
        <script src="/petBill/resources/js/scripts.js"></script>


</body>
</html>