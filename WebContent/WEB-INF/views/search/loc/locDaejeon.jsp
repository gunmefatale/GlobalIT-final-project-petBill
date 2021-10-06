<%-- *** 전체내용 복붙해서 사용하시면 됩니다 *** --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>** 대전광역시 **</title>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- footer css 태준 09/30 -->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">	
	
	<style>
		
		@import url('http://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900&display=swap');
		@import url('https://fonts.googleapis.com/css2?family=Rancho&display=swap');
		
		.bgc {
			background: -webkit-radial-gradient(rgb(255, 255, 255), rgb(214, 248, 255));
			background: radial-gradient(rgb(255, 255, 255), rgb(214, 248, 255));
		}
		
		.mapdiv {
			width: 70%;
			margin: auto;
		}
		
		.mapdiv path {
			fill: rgba(149, 154, 156, 0.5);
		}
		
		.mapdiv path:hover {
			fill: #959a9c;
		}
		
		section {
		    position: relative;
		    width: 100%;
		    height: 15vh;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		section #text {
		    position: absolute;
		    color: #094b65;
		    font-size: 2vw;
		    text-align: center;
		    font-family: 'Rancho', cursive;
		}
		
		section #text span {
		    font-size: 0.50em;
		    letter-spacing: 2px;
		    font-weight: 400;
		    font-family: 'Poppins', sans-serif;
		}
		
		.OUTLINE {
		    stroke-linejoin:round;
		    stroke: #545454;
		    stroke-width: 1.5px;
		}
		.TEXT {
		    fill: #000000;
		    font-size: 1.5em;
		    font-weight: bold;
		    text-anchor: middle;
		    alignment-baseline: middle;
		}
	    a:link {
	    	text-decoration: none;
	    }
	    
	    
	</style>
	
	<%-- 1. 부트스트랩 css 사용 --%>
	<link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
	
	</head>
	
	<body>
	
		<%-- ajax로 지도 동적 이미지 표현하기 --%>
		<!-- <script>
			$(document).ready(function() {
				$("#")
			});
		</script> -->
	
	
	
	
		<div class="d-flex" id="wrapper">
			<%-- 왼쪽 메인 메뉴 --%>
			<div class="border-end bg-white" id="sidebar-wrapper">
				<%-- 로고 --%>
				<div class="sidebar-heading border-bottom bg-light">
					<a href="/petBill/user/main.pet">
						<img src="/petBill/resources/imgs/로고화면.png" style="width: 190px; margin-top: 10px;">
					</a>
				</div>
				<div class="list-group list-group-flush">
					<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/search/mapMain.pet?petType=${param.petType}">지도 병원검색</a> 
					<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/search/searchResult.pet?pageNum=1&petType=${param.petType}">시/도 병원검색</a> 
					<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/hospital/hosCompare.pet?petType=${param.petType}">병원 비교하기</a> 
					<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/noticeList.pet?petType=${param.petType}">공지사항</a>
				</div>
			</div>
			<%-- Page content wrapper --%>
			<div id="page-content-wrapper">
				<%-- 상단 네비게이션 --%>
				<nav
					class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
					<div class="container-fluid">
						<%-- 반응형 동작시 버튼생김 --%>
						<button class="navbar-toggler" type="button"
							data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav ms-auto mt-2 mt-lg-0">
	
								<li>
									<%-- 위치 변경필요할듯 search(검색)form 조장님 수정부분 --%>
									<form action="/petBill/search/searchResult.pet">
										<input type="search" name="search" placeholder="병원명 입력"/>
										<input type="hidden" name="petType" value="${param.petType}"/>
										<input type="submit" value="검색" class="btn btn-secondary btn-sm"/>                 
									</form>
								</li>
	
								<%-- 로그인 분기처리 --%>
								<c:if test="${sessionScope.userId eq 'admin'}">	
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
		                       		<li class="nav-item"><a class="nav-link" href="/petBill/admin/adMain.pet">관리자 페이지</a></li>
		                        </c:if>
                                <c:if test="${sessionScope.userId == null && sessionScope.kakaoId == null}">	
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/loginForm.pet">로그인</a></li>
		                       		<li class="nav-item"><a class="nav-link" href="/petBill/user/userSignupForm.pet">회원가입</a></li>
		                        </c:if>
		                        <c:if test="${sessionScope.kakaoId != null ||sessionScope.userId != null && sessionScope.userId ne 'admin'}">
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
		                       		<li class="nav-item"><a class="nav-link" href="/petBill/user/userMypage.pet">마이페이지</a></li>
		                        </c:if>
	
								<li class="nav-item dropdown">
									<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">검색동물 변경</a>
									<div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
										<a class="dropdown-item" href="/petBill/search/loc/locDaejeon.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locDaejeon.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
									</div>
								</li>
							</ul>
							<c:if test="${param.petType eq 'dog'}">
                           		<img src="/petBill/resources/imgs/10.png" style="width: 50px; height: 50px">
                            </c:if>
                            <c:if test="${param.petType eq 'cat'}">
                           		<img src="/petBill/resources/imgs/11.png" style="width: 50px; height: 50px">
                            </c:if>								
						</div>
					</div>
				</nav>
	
				<%-- ================================================== 공통 메뉴 구분선 ========================================================== --%>
	
				<%-- 페이지 내용작성 영역 : Page content --%>
				<!-- <div class="container-fluid"> -->
				<div class="bgc">
				
					
					<div>
						<section>
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>대 전 광 역 시</h2>
						</section>
					</div>
					
					
					<div class="mapdiv" id="region">
					
						
						<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="-60 70 900 870">
							<defs>
							    <filter id="dropshadow">
							        <feGaussianBlur in="SourceAlpha" stdDeviation="5" />
							        <feOffset dx="1" dy="1" result="offsetblur" />
							        <feMerge>
							            <feMergeNode />
							            <feMergeNode in="SourceGraphic" />
							        </feMerge>
							    </filter>
							    <filter id="dropshadow2">
							        <feGaussianBlur in="SourceAlpha" stdDeviation="1.4" />
							        <feOffset dx="1" dy="1" result="offsetblur" />
							        <feMerge>
							            <feMergeNode />
							            <feMergeNode in="SourceGraphic" />
							        </feMerge>
							    </filter>
							</defs> 
							
							<!-- <g filter="url(#dropshadow)"> -->
							
								<a id="dongu" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									<title>동구</title>
									<path id="dongu" class="OUTLINE" d="M 591 241 l -5 11 -1 12 4 11 7 14 7 22 8 15 9 1 9 -7 6 -23 11 -6 24 4 20 1 11 22 6 8 11 13 11 11 2 0 1 -1 1 3 -13 7 -25 -1 -20 13 -10 8 -6 4 2 6 -1 5 0 4 1 9 -2 7 2 6 1 9 -3 12 -3 18 -9 21 -19 11 -10 11 -10 10 1 15 3 17 0 2 -7 12 -6 18 3 27 -6 12 -3 -2 -3 2 -3 6 4 10 8 19 -3 23 -11 12 -2 11 -4 27 3 23 2 14 6 12 -3 10 -11 12 -17 9 -9 11 -14 9 1 12 3 6 -14 5 -8 9 -8 13 -8 16 -22 7 -17 -8 -10 -14 -18 -10 9 -6 2 -4 -4 -6 4 -9 0 -13 -4 -11 1 -4 6 -2 9 4 7 -6 6 -12 9 -18 -8 -18 -9 -13 -8 -18 9 -16 9 -13 -3 -11 -7 -13 -8 -20 -3 -13 10 2 4 -4 18 -9 17 6 16 1 -4 -11 -7 -15 -13 -19 -14 -9 -9 -17 -7 -11 -12 -18 -9 -11 -12 -19 8 -16 10 -8 13 -21 12 2 15 15 18 -3 21 5 4 -21 -9 -18 -7 -10 -9 -19 0 -23 2 -23 4 -18 14 -13 10 -9 11 -15 6 -14 14 -26 15 -22 z " />
								</a>
								<a id="jungu" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									<title>중구</title>
									<path id="jungu" class="OUTLINE" d="M 506 607 l 7 15 4 11 -16 -1 -17 -6 -18 9 -4 4 -10 -2 3 13 8 20 7 13 3 11 -9 13 -9 16 8 18 9 13 8 18 -9 18 -6 12 -7 6 -9 -4 -6 2 -1 4 4 11 0 13 -4 9 4 6 -2 4 -9 6 -23 -16 -8 -20 -9 -12 -9 -15 -21 -8 3 -20 -5 -23 5 -22 -14 -23 -20 -9 -6 -19 -4 -11 -2 -6 4 -9 15 -13 10 -11 1 -8 0 0 -2 -6 -2 -6 6 -7 6 -15 2 -27 7 -15 12 -11 12 -13 5 -10 4 -18 16 13 12 4 12 19 9 11 12 18 7 11 9 17 14 9 z " />
								</a>
								<a id="seogu" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
									<title>서구</title>
									<path id="seogu" class="OUTLINE" d="M 326 648 l -4 7 2 6 4 11 6 19 -21 10 -8 23 4 19 3 28 -3 22 0 24 -3 18 -13 14 -12 12 -6 11 2 4 0 7 -8 11 -10 18 -15 7 -1 -30 -7 -16 -12 -7 -8 -25 -9 -17 -13 -9 -11 -12 -2 12 -20 -1 -2 -11 -14 -13 -10 -23 -2 -10 -1 -2 1 -6 -2 -7 3 -6 8 -13 15 -11 1 -2 2 0 11 -11 17 -9 8 -14 5 -15 13 -13 7 -20 8 -13 14 -11 7 -17 7 -10 -2 -23 4 -22 25 -3 5 -22 -4 -28 10 -12 9 -12 15 -13 18 -16 26 -1 15 5 14 22 4 8 0 0 2 6 4 20 -4 18 -5 10 -12 13 -12 11 -7 15 -2 27 -6 15 -6 7 2 6 2 6 0 0 -1 8 -10 11 z " />
								</a>
								<a id="yuseong" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=유성구&pageNum=1&petType=${param.petType}">
									<title>유성구</title>
									<path id="yuseong" class="OUTLINE" d="M 284 529 l -25 3 -4 22 2 23 -7 10 -7 17 -14 11 -8 13 -7 20 -13 13 -5 15 -8 14 -17 9 -11 11 -2 -1 -12 -2 -26 -10 -14 -9 -12 -7 -16 -14 -11 -17 3 -21 17 -6 0 -20 -1 -23 4 -26 -1 -12 2 0 11 -9 2 -21 16 -13 4 -18 -9 -27 12 -19 5 -12 1 -10 -2 -10 -1 -17 0 -24 2 -14 2 -13 8 -23 15 -6 9 -13 24 -9 25 6 23 -5 11 -8 11 -9 8 -25 7 -15 15 -10 8 -14 3 -6 -3 -9 0 -10 7 -10 5 -24 -7 -18 6 -18 11 4 4 -1 13 -12 11 -14 6 -2 13 6 12 11 13 15 6 9 1 21 -4 10 -2 20 -1 24 -12 14 -10 13 0 13 7 9 12 13 15 13 13 8 9 12 6 18 -7 21 -5 13 -4 16 0 22 -9 23 -21 9 -8 13 -15 -5 -26 1 -18 16 -15 13 -9 12 -10 12 4 28 z " />
								</a>
								<a id="daedeok" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=대덕구&pageNum=1&petType=${param.petType}">
									<title>대덕구</title>
									<path id="daedeok" class="OUTLINE" d="M 572 149 l -5 20 -6 11 -2 12 7 12 12 4 11 -1 12 -5 12 2 1 11 -7 9 -16 17 -9 5 -15 22 -14 26 -6 14 -11 15 -10 9 -14 13 -4 18 -2 23 0 23 9 19 7 10 9 18 -4 21 -21 -5 -18 3 -15 -15 -12 -2 -13 21 -10 8 -8 16 -12 -4 -16 -13 -4 -20 -2 -6 0 0 -4 -8 -14 -22 8 -13 21 -9 9 -23 0 -22 4 -16 5 -13 7 -21 -6 -18 -9 -12 -13 -8 -15 -13 -12 -13 -7 -9 0 -13 10 -13 12 -14 18 3 22 -1 24 -4 14 1 -5 1 8 3 9 8 24 4 12 -6 7 -13 6 -25 9 -15 9 -7 z " />
								</a>
							<!-- </g> -->
							
							
							<text id="dongu" class="TEXT" x="552" y="551">
								<a id="dongu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									동구
								</a>
							</text>
							<text id="jungu" class="TEXT" x="414" y="666">
								<a id="jungu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									중구
								</a>
							</text>
							<text id="LCD30170" class="TEXT" x="272" y="667">
								<a id="seogu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
									서구
								</a>
							</text>
							<text id="LCD30200" class="TEXT" x="247" y="410">
								<a id="yuseong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=유성구&pageNum=1&petType=${param.petType}">
									유성구
								</a>
							</text>
							<text id="daedeok" class="TEXT" x="477" y="317">
								<a id="daedeok" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대전광역시&siguSel=대덕구&pageNum=1&petType=${param.petType}">
									대덕구
								</a>
							</text>
						</svg>
						
					</div>
					<br>
					<div align="center" class="blockquote-footer">
						Copyright (c) 20-January-2020, Author Hyung-jun Kim <br>
					    <cite title="Source Title">
						    This file is licenced under a Creative Commons license: <br>
						    http://www.gisdeveloper.co.kr/?p=8555
					    </cite>
					</div>
				</div> <%-- container-fluid 내용작성 영역 --%>
			</div> <%-- page-content-wrapper 꺼 --%>
		</div> <%-- wrapper 꺼 --%>
		
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
		
		
		<%-- 2. 부트스트랩 core JS --%>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
		<%-- 3. Core theme JS --%>
		<script src="/petBill/resources/js/scripts.js"></script>
	
	</body>
</html>