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
	<title>** 부산광역시 **</title>
	
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
			fill: rgba(255, 153, 0, 0.5);
		}
		
		.mapdiv path:hover {
			fill: #ff9900;
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
		    font-size: 1.3em;
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
										<a class="dropdown-item" href="/petBill/search/loc/locBusan.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locBusan.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>부 산 광 역 시</h2>
						</section>
					</div>
					
					
					<div class="mapdiv" id="region">
						
						<?xml version="1.0"?>
						<svg xmlns="http://www.w3.org/2000/svg" version="1.2" viewBox="-20 -10 900 750">
						
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
							
								<a id="jung" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									<title>중구</title>
									<path id="jungu" class="OUTLINE" d="M 412.97 510.11 406.88 532.09 391.31 533.96 383.53 515.98 392.36 498.04 399.14 496.03 412.97 510.11 Z"/>
								</a>
								<a id="seog" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
									<title>서구</title>
									<path id="seogu" class="OUTLINE" d="M 359.14 565.66 369.18 568.48 373.22 537.68 362.86 524.29 367.34 516.19 356.84 506.3 350.93 484.64 357.36 460.75 368.99 458.66 389.07 461.54 388.11 493.79 392.36 498.04 383.53 515.98 391.31 533.96 391.82 552.4 384.42 581.15 386.14 595.14 370.56 612.54 359.14 565.66 Z"/>
								</a>	
								<a id="dong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									<title>동구</title>
									<path id="dongu" class="OUTLINE" d="M 446.75 450.29 448.29 460.75 447.31 475.99 434.69 492.32 425.6 483 412.97 510.11 399.14 496.03 392.36 498.04 388.11 493.79 389.07 461.54 403.19 457.69 411.92 442.3 427.55 449.03 446.75 450.29 Z"/>
								</a>	
								<a id="yeongdo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=영도구&pageNum=1&petType=${param.petType}">
									<title>영도구</title>
									<path id="yeongdo" class="OUTLINE" d="M 458.63 600.05 448.97 593.17 450.19 582.2 422.34 569.78 403.15 552.43 399.15 536.84 439.42 524.42 453.76 532.5 470.25 552.47 480.04 586.88 496.22 597.35 489.81 612.96 476.59 614.51 468.26 596.08 458.63 600.05 Z"/>
								</a>	
								<a id="busanjin" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=부산진구&pageNum=1&petType=${param.petType}">
									<title>부산진구</title>
									<path id="busanjin" class="OUTLINE" d="M 414.78 345.7 421.05 354.5 425.85 371.92 438.8 372.69 441.86 381.78 442.86 385.29 443.12 385.38 444.37 385.53 446.69 385.78 446.69 385.81 449.69 386.94 449.76 386.58 450.05 386.66 456.83 384.08 471.82 395.44 466.25 408.42 466.95 410.59 473.47 419.53 467.5 433.44 446.91 435.96 444.65 436.96 446.75 450.29 427.55 449.03 411.92 442.3 403.19 457.69 389.07 461.54 368.99 458.66 374.89 447.93 374.55 427.12 366.07 420.17 369.79 407.1 365.54 394.07 378.36 380.65 379.28 380.22 380.88 367.92 387.32 355.88 414.78 345.7 Z"/>
								</a>	
								<a id="dongrae" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=동래구&pageNum=1&petType=${param.petType}">
									<title>동래구</title>
									<path id="dongrae" class="OUTLINE" d="M 512.69 324.81 522.07 341.35 521.14 367.47 520.81 372.83 515.2 363.16 479.32 355.41 464.79 345.04 456.13 352.69 427.59 358.48 421.05 354.5 414.78 345.7 424.95 321.04 440.24 297.54 464.34 296.66 476.41 309.38 512.69 324.81 Z"/>
								</a>	
								<a id="nam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
									<title>남구</title>
									<path id="nam" class="OUTLINE" d="M 516.32 459.43 542.26 490.24 542.03 504.24 535.51 524.87 511.74 518.13 494.3 530.39 486.22 518.11 463.38 518.47 451.93 510.42 459.93 484.93 450.59 478.76 448.29 460.75 446.75 450.29 444.65 436.96 446.91 435.96 467.5 433.44 473.47 419.53 492.07 413.54 500.97 430.53 502.72 447.21 516.32 459.43 Z"/>
								</a>	
								<a id="nam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
									<title>북구</title>
									<path id="buk" class="OUTLINE" d="M 336 337.92 341.96 322.85 344.24 303.2 344.53 301.18 343.4 280.49 346.38 276.82 369.27 217.73 367.2 211.91 392.64 205.88 417.68 210.31 409.53 230.15 419.77 244.6 415.13 251.59 422.87 269.91 414.19 289.18 440.24 297.54 424.95 321.04 414.78 345.7 387.32 355.88 380.88 367.92 361.27 367.04 340.14 354.31 331.02 343.44 336 337.92 Z"/>
								</a>	
								<a id="haeundae" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=해운대구&pageNum=1&petType=${param.petType}">
									<title>해운대구</title>
									<path id="haeundae" class="OUTLINE" d="M 522.31 316.54 523 317.23 522.1 302.61 537.11 293.65 542.83 278.69 558.28 265.47 562.52 250.07 580.2 261.93 578.98 277.11 599.51 291.46 586.87 330.39 624.87 349.57 638.73 343.73 638.8 343.71 656.74 346.46 659.41 373.33 643.34 385.2 641.88 406.34 619.4 423.14 596.55 414.95 581.36 419.52 577.7 429.22 538.39 404.82 521.14 367.47 522.07 341.35 512.69 324.81 522.31 316.54 Z"/>
								</a>	
								<a id="haeundae" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=사하구&pageNum=1&petType=${param.petType}">
									<title>사하구</title>
									<path id="saha" class="OUTLINE" d="M 255.3 509.72 264.43 494.36 290.58 461.33 296.56 460.85 288.01 483.67 315.61 496.38 331.86 483.18 350.93 484.64 356.84 506.3 367.34 516.19 362.86 524.29 373.22 537.68 369.18 568.48 359.14 565.66 356.27 554.43 341.5 562.85 345.97 593.11 355.15 620.25 346.61 625.77 335.85 602.95 320.51 604.77 326.16 619.6 304.8 622.62 291 616.99 279.48 565.54 287.06 517.08 275.37 514.93 269.14 547.76 255.14 554.98 252.43 537.96 255.3 509.72 Z"/>
								</a>	
								<a id="geumjeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=금정구&pageNum=1&petType=${param.petType}">
									<title>금정구</title>
									<path id="geumjeong" class="OUTLINE" d="M 512.69 324.81 476.41 309.38 464.34 296.66 440.24 297.54 414.19 289.18 422.87 269.91 415.13 251.59 419.77 244.6 409.53 230.15 417.68 210.31 433.22 172.73 434.08 172.46 451.32 173.01 455.96 179.6 480.74 156.43 507.43 153.9 538.73 164.82 532.41 209.37 526.57 221.11 529.49 230.93 554.8 234.52 562.52 250.07 558.28 265.47 542.83 278.69 537.11 293.65 522.1 302.61 523 317.23 522.31 316.54 512.69 324.81 Z"/>
								</a>	
								<a id="gangseo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=강서구&pageNum=1&petType=${param.petType}">
									<title>강서구</title>
									<path id="gangseo" class="OUTLINE" d="M 97.29 548.57 107.12 555.17 107.56 597.86 111.64 614.41 124.55 608.94 130.9 619.85 131.56 634.73 118.18 657.8 120.41 666.91 108.19 682.36 115.76 695.9 110.91 716.13 100.97 719.45 89.86 708.62 97.17 686.9 75.86 674.91 79.38 660.87 70.41 656.91 74.77 643.53 64.66 626.08 62.63 591 103.3 582.22 107.23 570.73 72.09 571.27 71.94 561.48 81.75 561.33 91.28 555.34 94.07 555.35 97.29 548.57 Z M 344.53 301.18 344.24 303.2 341.96 322.85 336 337.92 330.93 343.37 315.31 358.31 312.94 359.55 297.32 371.79 295.56 374.57 295.1 376.15 294.1 416.8 291.97 429.27 291.73 435.58 291.69 436.05 290.92 461.3 290.58 461.33 264.43 494.36 255.3 509.72 247.83 518.96 249.48 532.6 242.4 540.97 221.69 553.26 220.24 566.58 196.83 566.93 196.63 553.64 203.8 521.42 203.76 508.5 211.09 496.01 199.13 492.22 187.32 514.93 185.33 546.87 174.14 566.12 156.49 559.54 110.77 560.23 86.78 534.57 89.29 527.05 109.43 524.15 110.09 523.8 118.01 506.25 110.67 488.37 97.01 479.08 95.52 479.17 93.24 476.95 92.09 476.12 76.49 471.54 64.37 459.31 64.87 457.56 64.06 454.48 63.36 453.85 61.1 454.58 60.22 454.92 58.73 455.08 43.66 427.57 61.72 421.41 76.73 421.71 90.77 429.12 91.42 429.56 93.33 429.74 94.03 429.76 103.53 426 105.07 424.81 116.87 425.11 117.77 424.22 117.85 423.86 117.91 423.61 118.68 421.61 118.66 421.49 118.51 420.6 119.14 416.26 119.71 415.81 121.29 414.99 131.85 409.74 133.32 410 136.64 408.7 138.5 408.61 144.82 407.1 146.97 406.87 153.49 422.86 153.37 422.61 150.44 421.96 150.54 422.03 150.54 422.45 150.46 422.57 151.14 426.01 151.33 426.27 153.02 428.46 153.27 428.94 153.28 428.95 153.42 429.19 154.17 430.26 154.98 431.43 163.2 437.07 163.25 437.06 163.25 437.06 163.39 437.26 163.77 437.78 165.12 436.83 165.73 437.58 167.07 436.63 165.1 433.68 164.71 433.13 170.76 421.67 170.89 421.79 170.91 421.87 171.7 421.67 174.02 418.37 173.96 418.27 174.36 417.52 173.02 417 168.04 405.4 167.38 404.9 162.68 395.64 165.56 397.05 172.28 399.83 172.51 399.88 171.74 392.57 171.65 388.89 171.51 386.56 171.64 384.98 171.81 383.96 172.4 382.85 173.45 379.38 172.45 378.03 170.42 375.7 170.09 375.21 168.97 373.81 168.61 373.28 165.07 364.43 165.31 363.22 165.08 360.76 164.52 359.93 161.49 340.92 161.81 340.72 174.69 327.35 174.88 327.18 177.85 323.22 178.45 322.81 193.55 323.77 195.26 324.18 201.9 321.93 204.82 320.9 207.17 320.1 210.52 320.41 211.39 320.38 212.97 320.07 213.49 319.97 213.83 318.78 213.51 318.41 212.23 316.93 211.71 316.32 207.71 311.35 208.97 310.3 209.03 310.25 209.65 309.73 211.36 308.28 214.32 306 215.25 306.2 215.32 306.24 216.07 306.4 216.19 306.43 217.46 306.69 221.23 311.14 224.93 316.84 243.55 311.02 259.04 297.73 267.82 297.59 268.04 297.79 271.68 301.01 272.07 301.17 274.13 301.15 275.26 301.13 278.34 301.05 285.81 300.65 288.52 300.11 290.1 299.8 310.86 296.3 311.28 296.18 315.88 294.82 316.37 294.67 327.7 290.78 327.98 290.64 343.4 280.49 344.53 301.18 Z"/>
								</a>	
								<a id="yeonje" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=연제구&pageNum=1&petType=${param.petType}">
									<title>연제구</title>
									<path id="yeonje" class="OUTLINE" d="M 520.81 372.83 494.59 380.7 492.07 413.54 473.47 419.53 466.95 410.59 466.25 408.42 471.82 395.44 456.83 384.08 450.05 386.66 449.76 386.58 449.69 386.94 446.69 385.81 446.69 385.78 444.37 385.53 443.12 385.38 442.86 385.29 441.86 381.78 438.8 372.69 425.85 371.92 421.05 354.5 427.59 358.48 456.13 352.69 464.79 345.04 479.32 355.41 515.2 363.16 520.81 372.83 Z"/>
								</a>	
								<a id="suyeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=수영구&pageNum=1&petType=${param.petType}">
									<title>수영구</title>
									<path id="suyeong" class="OUTLINE" d="M 538.39 404.82 550.63 420.56 520.76 438.49 525.67 451.7 516.32 459.43 502.72 447.21 500.97 430.53 492.07 413.54 494.59 380.7 520.81 372.83 521.14 367.47 538.39 404.82 Z"/>
								</a>	
								<a id="sasang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=사상구&pageNum=1&petType=${param.petType}">
									<title>사상구</title>
									<path id="sasang" class="OUTLINE" d="M 380.88 367.92 379.28 380.22 378.36 380.65 365.54 394.07 369.79 407.1 366.07 420.17 374.55 427.12 374.89 447.93 368.99 458.66 357.36 460.75 350.93 484.64 331.86 483.18 315.61 496.38 288.01 483.67 296.56 460.85 290.92 461.3 291.69 436.05 291.73 435.58 291.97 429.27 294.1 416.8 295.1 376.15 295.56 374.57 297.32 371.79 312.94 359.55 315.31 358.31 330.93 343.37 331.02 343.44 340.14 354.31 361.27 367.04 380.88 367.92 Z"/>
								</a>	
								<a id="gijang" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=기장군&pageNum=1&petType=${param.petType}">
									<title>기장군</title>
									<path id="gijang" class="OUTLINE" d="M 773.39 119.32 768.52 110.26 743.74 118.47 734.39 130.7 728.94 148.03 734.12 164.31 728.48 177.68 723.25 209.58 708.8 212.86 697.33 222.34 702.24 236.22 721.97 232.1 723.74 255.26 708.78 272.58 704.3 298.08 691.5 303.07 678.68 316.68 690.9 338.78 682.18 365.68 671.92 363.5 659.41 373.33 656.74 346.46 638.8 343.71 638.73 343.73 624.87 349.57 586.87 330.39 599.51 291.46 578.98 277.11 580.2 261.93 562.52 250.07 554.8 234.52 529.49 230.93 526.57 221.11 532.41 209.37 538.73 164.82 507.43 153.9 512.42 130.7 531.52 104.92 532.61 86.38 532.72 85.97 544.74 65.77 533.12 48.79 520.01 38.38 519.79 37.03 519.79 37 549.94 41.83 550 41.93 580.75 51.86 583.73 53.38 609.3 66.76 639.35 39.59 639.68 22.42 631.21 11.5 642.26 1 668.28 16.53 718.97 1.37 734.48 3.26 748.11 18.28 762.9 42.01 760.91 56.06 767.63 65.88 760.12 82.97 784.54 91.39 796.32 101.14 799 112.35 789.87 123.74 773.39 119.32 Z"/>
								</a>	
								
							<!-- </g> -->
							
							<text class="TEXT" x="390" y="513">
								<a id="jung" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=중구&pageNum=1&petType=${param.petType}">
									중구
								</a>
							</text>
							<text class="TEXT" x="370" y="490">
								<a id="seog" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
									서구
								</a>
							</text>
							<text class="TEXT" x="420" y="473">
								<a id="dong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									동구
								</a>
							</text>
							<text class="TEXT" x="435" y="555">
								<a id="yeongdo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=영도구&pageNum=1&petType=${param.petType}">
									영도구
								</a>
							</text>
							<text class="TEXT" x="410" y="410">
								<a id="busanjin" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=부산진구&pageNum=1&petType=${param.petType}">
									부산진구
								</a>
							</text>
							<text class="TEXT" x="460" y="330">
								<a id="dongrae" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=동래구&pageNum=1&petType=${param.petType}">
									동래구
								</a>
							</text>
							<text class="TEXT" x="490" y="480">
								<a id="nam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
									남구
								</a>
							</text>
							<text class="TEXT" x="380" y="300">
								<a id="nam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
									북구
								</a>
							</text>
							<text class="TEXT" x="580" y="370">
								<a id="haeundae" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=해운대구&pageNum=1&petType=${param.petType}">
									해운대구
								</a>
							</text>
							<text class="TEXT" x="320" y="550">
								<a id="haeundae" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=사하구&pageNum=1&petType=${param.petType}">
									사하구
								</a>
							</text>
							<text class="TEXT" x="480" y="250">
								<a id="geumjeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=금정구&pageNum=1&petType=${param.petType}">
									금정구
								</a>
							</text>
							<text class="TEXT" x="230" y="430">
								<a id="gangseo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=강서구&pageNum=1&petType=${param.petType}">
									강서구
								</a>
							</text>
							<text class="TEXT" x="470" y="375">
								<a id="yeonje" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=연제구&pageNum=1&petType=${param.petType}">
									연제구
								</a>
							</text>
							<text class="TEXT" x="515" y="410">
								<a id="suyeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=수영구&pageNum=1&petType=${param.petType}">
									수영구 
								</a>
							</text>
							<text class="TEXT" x="330" y="430">
								<a id="sasang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=사상구&pageNum=1&petType=${param.petType}">
									사상구
								</a>
							</text>
							<text class="TEXT" x="630" y="200">
								<a id="gijang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=부산광역시&siguSel=기장군&pageNum=1&petType=${param.petType}">
									기장군
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