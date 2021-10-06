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
	<title>** 대구광역시 **</title>
	
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
			fill: rgba(120, 189, 67, 0.3);
		}
		
		.mapdiv path:hover {
			fill: #78bd43;
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
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/loginPro.pet">로그아웃</a></li>
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
										<a class="dropdown-item" href="/petBill/search/loc/locDaegu.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locDaegu.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>대 구 광 역 시</h2>
						</section>
					</div>
					
					<div class="mapdiv" id="region">
						
						<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="-30 70 950 890">
							<defs>
							    <filter id="dropshadow">
							        <feGaussianBlur in="SourceAlpha" stdDeviation="4" />
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
							
								<a id="jungu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									<title>중구</title>
									<path id="jungu" class="OUTLINE" d="M 476 366 l 14 5 -2 18 -4 18 -12 -3 -14 -3 -16 1 -7 -3 -9 -7 7 -21 -1 -8 3 1 0 -6 20 3 13 2 z " />
								</a>
								<a id="dongu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									<title>동구</title>
									<path id="dongu" class="OUTLINE" d="M 624 83 l 11 7 22 5 14 7 7 12 8 8 -2 8 -2 6 4 9 8 10 10 7 -1 17 -1 6 -6 11 2 11 3 8 2 8 -5 12 -4 12 3 13 6 10 10 6 11 9 3 16 1 18 5 18 -3 21 1 14 -9 16 -8 9 -10 7 -14 3 -11 -2 -6 -9 -17 -5 -20 6 -19 -2 -13 -5 -7 -16 -12 -7 -14 -1 -9 -5 -13 -3 -11 7 -10 5 -11 11 -27 -10 -6 -9 -3 -2 7 -7 7 -13 20 -8 6 -4 0 -2 -5 -8 -2 -15 7 -9 1 -9 -1 -20 -3 -9 -6 -9 -2 -21 -3 -16 1 -17 -4 -13 -5 -8 -3 -15 -11 -13 -8 -6 4 -13 4 -7 11 -16 10 -3 21 -5 7 -3 5 0 9 3 11 -1 9 -1 12 -5 22 -4 z " />
								</a>
								<a id="seogu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
									<title>서구</title>
									<path id="seogu" class="OUTLINE" d="M 437 343 l -2 15 0 6 -3 -1 1 8 -7 21 -22 6 -6 3 -18 3 -7 -2 -10 -6 -13 -7 -6 -8 -10 -3 6 -7 -1 -9 -4 -9 3 -7 9 -4 19 -4 19 -13 15 9 19 4 z " />
								</a>
								<a id="namgu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
									<title>남구</title>
									<path id="namgu" class="OUTLINE" d="M 435 399 l 7 3 16 -1 14 3 12 3 -1 14 0 4 -1 7 -1 15 2 12 -3 5 -8 18 -10 8 -8 9 -12 -5 -7 -8 -10 -9 -6 -9 -12 -10 -6 -10 5 -16 9 -10 10 -11 1 -19 z " />
								</a>
								<a id="bukgu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
									<title>북구</title>
									<path id="bukgu" class="OUTLINE" d="M 496 157 l 3 15 5 8 4 13 -1 17 3 16 2 21 6 9 3 9 1 20 -1 9 -7 9 2 15 5 8 0 2 -6 4 -20 8 -7 13 -7 7 3 2 6 9 -14 -5 -8 -3 -13 -2 -20 -3 2 -15 -18 -5 -19 -4 -15 -9 -19 13 -19 4 -20 -12 -15 5 2 -18 3 -12 9 -10 10 -8 7 -9 8 -11 5 -13 4 -9 0 -18 -2 -16 1 -17 -6 -6 -3 -17 0 -12 17 1 11 13 8 15 7 -4 6 -11 12 -6 10 -7 19 -3 13 -4 8 -9 16 -6 8 6 z " />
								</a>
								<a id="suseongu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=수성구&pageNum=1&petType=${param.petType}">
									<title>수성구</title>
									<path id="suseongu" class="OUTLINE" d="M 454 499 l 8 -9 10 -8 8 -18 3 -5 -2 -12 1 -15 1 -7 0 -4 1 -14 4 -18 2 -18 27 10 11 -11 10 -5 11 -7 13 3 9 5 14 1 12 7 7 16 13 5 19 2 20 -6 17 5 6 9 -4 25 -3 11 -11 5 -11 17 8 18 0 20 -10 11 -11 8 -13 2 -9 7 -10 2 -3 -4 -2 0 -5 -3 -11 -3 -20 -5 -8 -7 -4 -1 -9 1 -13 -1 -11 1 -11 -5 -9 5 -8 -3 -18 -3 z " />
								</a>
								<a id="dalseogu" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=달서구&pageNum=1&petType=${param.petType}">
									<title>달서구</title>
									<path id="dalseogu" class="OUTLINE" d="M 334 378 l 10 3 6 8 13 7 10 6 7 2 18 -3 6 -3 22 -6 -1 19 -10 11 -9 10 -5 16 6 10 12 10 6 9 10 9 7 8 12 5 -5 15 -12 8 -15 1 -1 14 1 19 -8 11 -13 2 -7 -10 -8 -8 -8 -9 -13 0 -15 -10 -8 -7 -9 -12 -7 -11 -6 -12 -6 -4 -27 -5 -8 3 -1 -18 -10 -13 -11 -11 2 -15 3 -20 8 -16 9 -10 7 0 8 5 18 0 8 -3 z " />
								</a>
								<a id="dalseongun" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=달성군&pageNum=1&petType=${param.petType}">
									<title>달성군</title>
									<path id="dalseongun" class="OUTLINE" d="M 314 486 l 6 4 6 12 7 11 9 12 8 7 15 10 13 0 8 9 8 8 7 10 13 -2 8 -11 -1 -19 1 -14 15 -1 12 -8 5 -15 19 4 18 3 8 3 9 -5 11 5 11 -1 13 1 9 -1 4 1 8 7 20 5 11 3 5 3 2 0 4 9 1 13 5 10 3 14 8 18 5 8 0 3 -1 10 -4 17 -1 17 -6 12 -7 7 1 5 -3 2 -8 0 -15 4 -18 6 -10 9 -10 8 -17 4 -11 3 -6 4 -9 -6 -5 -8 1 -15 -6 -17 0 -20 -19 -2 -18 6 -18 -6 -20 4 -8 7 -7 7 -15 9 -8 9 -12 6 -10 7 -3 1 4 7 4 19 2 15 -5 17 -12 5 -19 15 -5 21 -2 18 5 19 -5 10 -12 3 -16 5 -16 -2 -22 0 -19 -1 -15 4 -8 9 -9 8 -7 11 -6 -2 -6 -3 -6 6 -5 0 0 1 -5 6 -9 8 -5 0 -2 -4 -2 3 -3 -1 -7 2 -14 8 -13 7 -14 -5 8 -7 11 -5 11 -8 7 -10 6 -10 5 -17 -4 -18 -7 -8 -8 -7 -12 -9 -9 -8 -10 -10 -9 -9 -8 -10 -6 -10 -7 -19 -2 -18 9 -14 16 3 8 3 9 4 19 3 21 5 11 3 9 2 7 0 9 -5 12 -11 4 -8 0 -23 -4 -12 -10 -9 -8 -7 -11 -8 -12 -6 -13 -7 -10 -7 -8 -11 -6 -9 0 -7 5 -9 8 -15 7 -10 4 -8 7 -20 5 -11 8 -9 8 -9 8 -4 32 1 10 3 20 0 19 -2 9 -10 10 -10 8 -3 z M 242 236 l 3 3 9 1 12 11 0 6 -4 11 -1 15 -9 16 6 21 15 5 8 3 1 -4 7 -2 8 11 15 2 15 -5 20 12 -9 4 -3 7 4 9 1 9 -6 7 -14 5 -8 3 -18 0 -8 -5 -7 0 -9 10 -5 8 -3 8 -3 20 -2 15 -19 -11 -19 -8 -18 -3 -8 -2 -10 -1 -14 -2 -23 -1 -20 1 -10 -7 0 -16 4 -11 4 -8 5 -18 6 -15 5 -10 7 -12 15 -18 9 -18 4 -9 11 -12 7 -6 7 -2 21 -8 8 -10 0 -2 0 -1 z " />
								</a>
							<!-- </g> -->
							
								<text id="LCD27110" class="TEXT" x="459" y="382">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
										중구
									</a>
								</text>
								<text id="LCD27140" class="TEXT" x="608" y="243">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
										동구
									</a>	
								</text>
								<text id="LCD27170" class="TEXT" x="387" y="365">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
										서구
									</a>		
								</text>
								<text id="LCD27200" class="TEXT" x="447" y="445">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
										남구
									</a>		
								</text>
								<text id="LCD27230" class="TEXT" x="431" y="256">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
										북구
									</a>	
								</text>
								<text id="LCD27260" class="TEXT" x="571" y="446">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=수성구&pageNum=1&petType=${param.petType}">
										수성구
									</a>	
								</text>
								<text id="LCD27290" class="TEXT" x="355" y="461">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=달서구&pageNum=1&petType=${param.petType}">
										달서구
									</a>	
								</text>
								<text id="LCD27710" class="TEXT" x="270" y="648">
									<a id="dalseongun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=대구광역시&siguSel=달성군&pageNum=1&petType=${param.petType}">
										달성군
									</a>	
								</text>
						
						</svg>
							
					</div>
					<br />
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