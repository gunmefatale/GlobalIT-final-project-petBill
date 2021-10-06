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
	<title>** 울산광역시 **</title>
	
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
			fill: rgba(9, 218, 146, 0.5);
		}
		
		.mapdiv path:hover {
			fill: #09da92;
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
						<img src="/petBill/resources/imgs/로고화면.png" style="width: 190px; w margin-top: 10px;">
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
										<a class="dropdown-item" href="/petBill/search/loc/locUlsan.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locUlsan.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>울 산 광 역 시</h2>
						</section>
					</div>
					
					
					<div class="mapdiv" id="region">
						
						<?xml version="1.0"?>
						<svg xmlns="http://www.w3.org/2000/svg" version="1.2" viewBox="-50 -20 900 820">
						
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
						
								<a id="jung" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									<title>중구</title>
									<path id="jung" class="OUTLINE" d="M 612.72 343.21 561.07 341.74 560.76 341.7 548.63 338.28 548.41 338.2 539.93 349.14 529.65 353.38 502.49 337.46 486.98 337.21 478.42 330.44 467.28 321.45 466.18 304.56 458.66 268.58 502.27 274.43 506.91 286.77 523.49 288.82 523.26 272.89 517.46 257.47 539.04 255.53 548.63 265.29 571.67 245.74 590.1 254.85 611.02 252.53 613.4 281.88 618.6 294.79 620.59 321.16 614.76 324.88 612.72 343.21 Z"/>
								</a>
								<a id="nam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
									<title>남구</title>
									<path id="suyeong" class="OUTLINE" d="M 548.41 338.2 548.63 338.28 560.76 341.7 561.07 341.74 612.72 343.21 639.52 355.19 656.44 382.19 657.57 405.41 673.61 408.3 678.68 431.53 665.28 440.45 681.33 464.36 676.21 470.14 673.78 487.91 636.98 521.41 628.97 520.72 612.97 491.57 601.57 490.35 598.36 477.13 580.15 462.48 566.75 456.35 553.69 457.05 549.17 448.46 537.96 452.3 518.13 424.82 516.68 413.17 505.35 408.82 491.88 391.11 457.53 377 431.86 372.51 435.43 365.1 452.62 355.21 462.71 335.82 470.71 340.7 470.76 340.68 478.42 330.44 486.98 337.21 502.49 337.46 529.65 353.38 539.93 349.14 548.41 338.2 Z"/>
								</a>	
								<a id="dong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									<title>동구</title>
									<path id="dong" class="OUTLINE" d="M 677.8 385.46 686.43 395.62 703.58 399.35 714.83 391.37 699.75 381.03 706.66 370.4 711.01 349.18 710.88 348.82 716.1 333.43 728.62 312.5 744.32 305.39 769.95 304 780.35 295.64 787.2 309.12 791.14 331.38 783.45 345.07 780.56 380.28 760.51 381.49 764.16 394.32 774.85 402.02 772.2 415.57 751.98 416.79 750.98 427.68 766.79 424.82 769.73 433.64 751.29 438.78 748.49 446.38 763.23 463.9 752.26 477.86 746.44 468.83 724.53 478.58 718.15 495.13 706.88 484.8 706.39 466 712.94 452.65 704.16 439.82 691.96 437.21 692.91 409.6 677.8 385.46 Z"/>
								</a>	
								<a id="buk" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
									<title>북구</title>
									<path id="buk" class="OUTLINE" d="M 773.65 137.68 760.27 150.97 763.36 169.06 760.11 179.3 765.99 193.43 788.26 211.42 798.78 239.48 799 266.69 787.79 270.38 781.25 279.58 780.35 295.64 769.95 304 744.32 305.39 728.62 312.5 716.1 333.43 710.88 348.82 711.01 349.18 706.66 370.4 699.75 381.03 714.83 391.37 703.58 399.35 686.43 395.62 677.8 385.46 663.63 367.44 649.55 363.3 639.52 355.19 612.72 343.21 614.76 324.88 620.59 321.16 618.6 294.79 613.4 281.88 611.02 252.53 590.1 254.85 571.67 245.74 548.63 265.29 539.04 255.53 517.46 257.47 520.12 241.27 531.47 222.6 523.13 206.68 523.24 191.39 528.51 181.34 525.29 157.34 535.88 147.62 537.53 130.28 548.55 123.08 564.23 130.45 575.68 125.94 585.45 104.03 595.13 104.09 616.67 84.31 634.23 86.22 648.04 103.91 662.88 99.73 693.61 106.99 697.76 115.2 710.41 113.44 739.02 129.29 756.67 129.61 773.65 137.68 Z"/>
								</a>	
								<a id="ulju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=울주군&pageNum=1&petType=${param.petType}">
									<title>울주군</title>
									<path id="ulju" class="OUTLINE" d="M 613.05 510.86 617.71 535.98 616.38 547.33 635.17 544.76 636.34 560.22 649.1 572.92 647.63 579.03 626.3 583.5 629.76 619.17 638.98 626.66 629.25 639.94 628.19 654.03 615.39 661.86 614.09 690.39 630.73 696.67 639.51 711.75 636.88 728.12 609.71 726.79 595.82 731.43 593.82 744.53 577.97 747.07 562.21 780.2 548.68 778.54 548.23 769.31 535.73 767.83 508.92 758.58 517.17 739.81 509.78 729.02 511.97 713.59 495.73 687.53 480.76 671.03 463.72 668.96 453.95 677.26 443.17 674.36 408.04 685.61 396.63 682.18 379.46 668.55 407.64 629.9 393.13 604.74 376.57 596.28 379.48 580.46 370.14 568.15 324.06 581.97 297.68 562.38 287.1 557.8 270.66 539.71 265.96 535.79 247.71 520.29 246.69 507.06 240 495.49 227.45 488.69 222.22 457.68 215.43 452.75 195.67 451.66 148.42 430.05 133.67 420.69 132.51 400.92 138.29 385.18 100.52 398.88 92.17 396.15 80.87 402.26 65.53 404.32 63.45 394.71 38.9 394.95 45.49 374.14 42.3 361.4 29.68 348.41 16.14 359.01 2.85 339.94 1 331.67 10.73 325.14 39.69 315.88 59 291.11 76.7 283.62 85.51 251.48 82.2 245.49 81.54 223.08 57.88 219.53 49.35 211.58 60.43 200.2 73.88 192.53 78.01 181.89 87.61 178.9 102.15 187.37 114.62 169.38 120.1 150.3 156.61 159.88 166.91 169.77 175.43 163.87 157.91 133.56 153.77 104.68 161.64 96.22 156.37 86.38 172.81 58.46 207.32 38.43 229.85 33.27 243.66 33.44 246.72 22.86 261.5 25.06 272.05 1 291.59 5.41 301.99 19.47 320.87 20.87 344.53 9.38 362.49 16.48 374.98 5.56 406.03 28.11 418.07 30.14 421.87 39.15 459.03 44.79 467.44 59.16 467.71 75.23 463.74 103.57 456.83 113.04 456.83 113.05 458.27 124.86 466.5 136.28 481.77 143.08 490.09 138.94 503.04 141.4 525.29 157.34 528.51 181.34 523.24 191.39 523.13 206.68 531.47 222.6 520.12 241.27 517.46 257.47 523.26 272.89 523.49 288.82 506.91 286.77 502.27 274.43 458.66 268.58 466.18 304.56 467.28 321.45 478.42 330.44 470.76 340.68 470.71 340.7 462.71 335.82 452.62 355.21 435.43 365.1 431.86 372.51 457.53 377 491.88 391.11 505.35 408.82 516.68 413.17 518.13 424.82 537.96 452.3 549.17 448.46 553.69 457.05 566.75 456.35 580.15 462.48 598.36 477.13 601.57 490.35 613.05 510.86 Z"/>
								</a>	
								
							<!-- </g> -->
							
							<text class="TEXT" x="550" y="310">
								<a id="jung" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									중구
								</a>
							</text>
							<text class="TEXT" x="580" y="410">
								<a id="nam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
									남구
								</a>
							</text>
							<text class="TEXT" x="750" y="360">
								<a id="dong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									동구
								</a>
							</text>
							<text class="TEXT" x="680" y="250">
								<a id="buk" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
									북구
								</a>
							</text>
							<text class="TEXT" x="300" y="300">
								<a id="ulju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=울산광역시&siguSel=울주군&pageNum=1&petType=${param.petType}">
									울주군
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