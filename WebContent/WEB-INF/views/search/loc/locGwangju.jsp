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
	<title>** 광주광역시 **</title>
	
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
			width: 80%;
			margin: auto;
		}
		
		.mapdiv path {
			fill: rgba(231, 52, 12, 0.3);
			stroke: #545454;
			stroke-width: 1.5px;
		}
		
		.mapdiv path:hover {
			/* fill: #e7340c; */
			fill: rgba(231, 52, 12, 0.6);
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
		    font-size: 1.4em;
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
										<a class="dropdown-item" href="/petBill/search/loc/locGwangju.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locGwangju.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
					
					<div class="mapdiv" id="region">
						
						<div>
							<section>
								<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>광 주 광 역 시</h2>
							</section>
						</div>
						
						
						<div class="mapdiv" id="region">
							
							<?xml version="1.0"?>
							<svg xmlns="http://www.w3.org/2000/svg" version="1.2" viewBox="-5 -10 800 560">
							
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
							
								<a id="dongu" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
									<title>동구</title>
									<path id="dongu" class="OUTLINE" d="M 760.4 357.56 759.61 361.68 748.42 371.74 751.03 376.15 739.3 382.01 728.58 384.55 727.52 393.48 722.2 396.86 727.23 408.77 725.22 416.96 727.56 425.1 724.8 427.75 715.94 429.08 705.9 433.32 695.96 432.98 691.67 436.86 680.01 439.27 672.65 444.52 663.07 457.88 665.23 462.18 655.42 476.57 648.83 480.87 637.95 481.99 631.72 479.86 615.23 477.27 607.4 477.46 607.94 468.67 597.74 461.83 594.39 456.79 594.91 451.6 591.46 442.35 582.86 432.8 579.99 433.18 584.11 418.99 578.12 414.2 575.66 403.94 568.87 395.41 569.59 388.7 566.05 384.46 568.34 375.95 565.46 372.29 572.3 367.45 576.91 367.71 587.8 357.51 591.51 347.69 600.9 344.76 597.73 339.8 593.33 327.7 586.51 320.77 581.17 310.19 575.19 301.96 569.26 296.31 560.82 284.65 555.38 278.83 566.69 267.71 574.97 242.78 600.05 250.67 605.35 256.54 615.49 252.55 622.56 252.59 621.49 258.77 624.58 260.61 634.21 260.61 636.96 268.66 642.68 272.09 648.77 272.26 657.02 277.43 657.86 280.75 653.54 289.06 653.04 295.74 649.35 300.62 656.96 307.59 663.05 308.97 671.28 308.27 679.04 312.33 685.36 317.55 690.83 317.93 694.55 313.34 700.56 314.81 705.79 313.26 716.39 316.94 720.13 322.83 725.46 338.83 729.24 342.52 735.39 353.62 741.28 351.76 760.4 357.56 Z"/>
								</a>
								<a id="seogu" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
									<title>서구</title>
									<path id="seogu" class="OUTLINE" d="M 555.38 278.83 560.82 284.65 551.56 286.98 547.49 284.36 541.37 276.02 534.7 276.13 528.2 278.64 523.69 283.92 519.6 284.8 509.33 291.12 515.39 300.85 504.95 310.55 510.05 316.93 513.69 328.69 512.12 330.41 512.3 341.57 515.74 355.43 513.42 363.05 505.37 370.96 494.26 367.05 486.62 362.57 480.09 365.87 475.54 374.69 471.99 377.25 476.72 384.01 467.65 383.28 455.39 387.45 456.28 394.29 446.33 392.41 433.36 396.2 427.96 396.03 420.67 399.17 414.81 407.83 407.55 405.94 405.43 413.01 402.15 415.55 395.37 415.52 386.57 424.41 376.43 430.84 369.76 433.03 362.23 426.2 357.98 427.38 350.27 433.81 342.22 418.52 333.14 426.59 329.2 416.78 330.07 407.52 335.25 402.58 341.52 402.52 338.49 394.93 334.08 378.23 348.04 378 348.6 367.8 355.95 366.12 363.65 367.29 364.12 356.66 366.72 351.95 372.8 347.59 375.45 341.49 368.69 333.43 368.7 325.56 372.13 321.89 378.73 319.42 390.65 305.69 390.38 285.05 389.02 280.56 382.54 271.98 384.12 254.55 380.16 245.73 382.23 240.68 388.15 235.07 401.17 228.97 408.74 227.03 408.99 212.99 411.23 208.43 418.88 210.95 419.9 214.27 457.58 224.74 489.09 227.12 502.36 229.39 511.06 241.45 514.58 252.95 525.03 254.67 536.62 260.81 555.38 278.83 Z"/>
								</a>
								<a id="namgu" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
									<title>남구</title>
									<path id="namgu" class="OUTLINE" d="M 560.82 284.65 569.26 296.31 575.19 301.96 581.17 310.19 586.51 320.77 593.33 327.7 597.73 339.8 600.9 344.76 591.51 347.69 587.8 357.51 576.91 367.71 572.3 367.45 565.46 372.29 568.34 375.95 566.05 384.46 569.59 388.7 568.87 395.41 575.66 403.94 578.12 414.2 584.11 418.99 579.99 433.18 574.65 433.89 561.8 440.47 561.92 443.63 548.76 459.1 538.93 460.78 528.8 460.72 522.21 467.76 522.14 467.81 508.28 458.34 499.48 465.29 489.25 469.81 489 472.52 479.12 476.83 466.16 473.8 466.14 473.82 459.46 470.49 456.88 464.84 445.19 466.26 440.4 477.95 429.37 482.66 425.98 491.33 424.19 492 420.36 499.51 405.52 497.21 403.38 503.32 390.38 508.1 383.85 507.48 373.45 513.18 367.61 525.89 366.39 531.61 366.32 531.66 359.56 529.91 345.06 532.9 342.77 536.27 334.84 532.42 333.6 525.25 325.51 514.21 321.89 515.36 316.41 509.76 309.35 511.34 295.49 523.93 287.58 528.15 286.71 527.9 280.6 527.87 277 530.51 269.48 530.57 261.91 527.78 258.01 521.6 260.8 511.74 258.39 504.84 253.43 500.97 241.8 505.8 236.17 516.04 235.59 516.58 232.79 505.46 228.51 500.56 230.26 494.39 236.3 490.51 244.06 489.74 257.5 491.17 266.75 486.11 275.28 483.38 284.34 482.56 291.11 479.45 299.17 472.33 305.79 460.74 314.99 449.84 319.2 440.62 326.88 436.48 332.44 431.38 333.14 426.59 342.22 418.52 350.27 433.81 357.98 427.38 362.23 426.2 369.76 433.03 376.43 430.84 386.57 424.41 395.37 415.52 402.15 415.55 405.43 413.01 407.55 405.94 414.81 407.83 420.67 399.17 427.96 396.03 433.36 396.2 446.33 392.41 456.28 394.29 455.39 387.45 467.65 383.28 476.72 384.01 471.99 377.25 475.54 374.69 480.09 365.87 486.62 362.57 494.26 367.05 505.37 370.96 513.42 363.05 515.74 355.43 512.3 341.57 512.12 330.41 513.69 328.69 510.05 316.93 504.95 310.55 515.39 300.85 509.33 291.12 519.6 284.8 523.69 283.92 528.2 278.64 534.7 276.13 541.37 276.02 547.49 284.36 551.56 286.98 560.82 284.65 Z"/>
								</a>
								<a id="bukgu" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
									<title>북구</title>
									<path id="bukgu" class="OUTLINE" d="M 572.76 4.11 572.87 4.11 582.49 11.6 586.28 16.56 595.08 17.52 607.78 23.34 613.05 33.75 610.74 46.12 610.56 47.17 614.05 51.33 631.95 62.9 633.44 72.58 643.08 77.23 643.23 77.75 650.89 91.08 644.75 100.53 644.6 105.23 648.54 115.7 651.46 117.45 655.52 127.15 670.07 143.08 678.72 145.04 679.04 145.35 681.05 151.83 677.3 153.86 669.96 167.17 664.95 172.82 666.69 178.9 680.98 194.92 684.73 203.1 692.21 206.5 693.18 193.34 697.11 190.32 706.09 190.18 709.84 195.16 715.66 195.87 718.07 188.08 725.1 183.42 733.33 189.85 739.9 188.4 743.31 184.31 743.86 183.86 752.08 183.7 759.83 190.19 766.89 193.01 776.95 203.99 780.32 205.55 780.62 205.88 785.36 217.8 791.11 222.81 797.21 224.54 799 228.86 794.84 239.02 794.61 239.19 787.38 244.32 775.86 242.11 772.95 248.51 776.58 254.61 775.27 260.74 769.03 269.57 769.53 277.72 772.07 284.69 768.41 288.74 766.75 299.46 771.16 304.86 769.86 325.53 771.77 333.15 776.38 340.84 773.75 349.84 767.95 350.65 760.4 357.56 741.28 351.76 735.39 353.62 729.24 342.52 725.46 338.83 720.13 322.83 716.39 316.94 705.79 313.26 700.56 314.81 694.55 313.34 690.83 317.93 685.36 317.55 679.04 312.33 671.28 308.27 663.05 308.97 656.96 307.59 649.35 300.62 653.04 295.74 653.54 289.06 657.86 280.75 657.02 277.43 648.77 272.26 642.68 272.09 636.96 268.66 634.21 260.61 624.58 260.61 621.49 258.77 622.56 252.59 615.49 252.55 605.35 256.54 600.05 250.67 574.97 242.78 566.69 267.71 555.38 278.83 536.62 260.81 525.03 254.67 514.58 252.95 511.06 241.45 502.36 229.39 489.09 227.12 457.58 224.74 419.9 214.27 418.88 210.95 411.23 208.43 416.85 199.64 424.03 198.8 428.92 205.62 436.86 205.05 441.96 198.38 447.81 199.46 453.49 196.51 457.12 190.02 454.57 178.33 455.65 173.38 453.09 166.27 441.02 161.52 440.09 158.41 446.64 149.65 446.26 138.23 444.25 130.27 441.14 125.49 442.2 117.95 450.47 108.18 442.05 106.67 442.16 96.66 427.7 96.49 424.67 86.37 411.78 90.99 408.09 82.46 404.28 78.81 411.55 76.15 416.53 64.42 425.21 63.59 423.95 57.78 431.22 59.43 431.27 59.51 431.34 59.65 431.53 60.07 431.9 61.05 432.2 60.9 441.03 54.04 448.57 53.51 448.58 53.5 457.65 48.86 460.56 39.37 464.68 35.55 475.66 34.6 481.23 30.71 481.24 30.64 487.33 24.55 498.69 20.86 496.71 26.12 500.16 30.98 512.84 34.59 519.82 33.51 522.68 26.38 526.46 23.39 542.19 15.21 550.49 5.04 550.54 5 565.3 3.38 572.76 4.11 Z"/>
								</a>
								<a id="gwangsangu" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=광산구&pageNum=1&petType=${param.petType}">
									<title>광산구</title>
									<path id="jeju" class="OUTLINE" class="OUTLINE" d="M 14.43 276.87 16.37 275.3 19.28 270.91 14.8 266.22 23.17 255.84 19.68 249.65 22.37 239.65 22.73 239.35 27.02 235.95 38.79 236.61 42.29 231.38 55.3 228.72 58.95 219.55 55.67 214.56 51.27 214.86 46.89 205.31 38.95 200.44 41.32 195.91 36.21 188.09 29.23 185.33 23.97 178.4 19.58 169.51 19.4 169.21 25.86 165.19 31.79 169.97 37.43 166.26 40.77 169.34 54.09 164.42 61.12 168.38 64.36 172.87 70.02 173.35 71.49 166.44 68.7 159.23 72.2 151.85 71.46 143.02 76.22 140.02 77.8 129.86 85.99 125.17 88.5 115.45 91.4 111.43 91.5 111.4 93.23 111.98 93.16 112.15 93.3 112.54 93.48 112.64 94.2 112.97 94.83 113.38 94.92 113.44 94.92 113.3 94.98 112.72 95.06 112.47 95.14 112.25 95.29 112.34 95.42 112.42 95.57 112.56 95.61 112.73 95.72 112.92 95.86 113.09 95.95 112.8 96.2 112.31 96.21 112.19 98.53 112 98.54 112.05 100.28 115.84 112.31 126.87 115.49 126.36 123.99 131.34 141.29 119.36 153.6 119.49 153.73 119.45 161.48 109.86 162.6 102.64 157.92 94.97 161.36 86.02 165.92 79.85 168.84 72.18 169.49 70.77 176.19 57.23 180.65 55.24 183.55 46.48 182.48 39.58 197.84 17.86 198.17 15.45 198.17 15.18 207.7 20.67 208.26 19.4 209.17 17.72 209.45 17.26 209.43 19.76 221.72 14.28 224.02 7.73 230.88 5.26 235.85 6.34 241.9 1.47 248.55 1 248.83 1.06 253.26 6.11 253.49 6.38 253.49 15.26 253.4 15.39 249.13 20.9 247.84 29.65 244.74 34.21 236.74 40.11 232.93 56.19 235.86 63.23 246.51 64.3 261 69.49 267.6 67.41 268.29 68.49 270.25 71.7 278.24 73.29 288.36 85.97 297.18 89.84 305.25 91.4 305.95 90.18 308.05 90.7 320.09 101.33 332.81 101.41 339.4 97.56 343.22 102.75 348.54 98.31 363.21 89.13 367.8 91.23 371.66 87.12 380.76 86.35 382.92 83.27 381.59 73.61 383.82 70.58 393.32 74.36 400.5 79.79 404.28 78.81 408.09 82.46 411.78 90.99 424.67 86.37 427.7 96.49 442.16 96.66 442.05 106.67 450.47 108.18 442.2 117.95 441.14 125.49 444.25 130.27 446.26 138.23 446.64 149.65 440.09 158.41 441.02 161.52 453.09 166.27 455.65 173.38 454.57 178.33 457.12 190.02 453.49 196.51 447.81 199.46 441.96 198.38 436.86 205.05 428.92 205.62 424.03 198.8 416.85 199.64 411.23 208.43 408.99 212.99 408.74 227.03 401.17 228.97 388.15 235.07 382.23 240.68 380.16 245.73 384.12 254.55 382.54 271.98 389.02 280.56 390.38 285.05 390.65 305.69 378.73 319.42 372.13 321.89 368.7 325.56 368.69 333.43 375.45 341.49 372.8 347.59 366.72 351.95 364.12 356.66 363.65 367.29 355.95 366.12 348.6 367.8 348.04 378 334.08 378.23 338.49 394.93 341.52 402.52 335.25 402.58 330.07 407.52 329.2 416.78 333.14 426.59 332.44 431.38 326.88 436.48 319.2 440.62 314.99 449.84 305.79 460.74 299.17 472.33 291.11 479.45 284.34 482.56 275.28 483.38 266.75 486.11 265.09 479.64 258.2 473.23 253.15 464.1 253.06 463.93 254.95 458.99 254.29 451.23 250 449.69 246.74 438.72 247.09 432.26 240.4 430.61 231.04 430.49 228.8 423 224.19 417.01 220.29 408.23 207.4 395.22 193.61 387.6 185.25 375.43 181.86 377.84 181.58 388.76 176.67 389.56 176.57 389.57 166.45 387.07 156.96 386.44 149.35 380.79 134.8 383.78 127.96 374.95 120.07 376.48 116.63 384.77 110.76 388.63 110.68 388.63 98.56 381.51 84.68 376.98 82.03 379.16 85.03 386.2 80.67 388.85 74.24 388.39 66.4 395.19 50.06 395.27 49.1 394.68 51.26 378.66 39.24 369.44 31.89 372.67 25.82 373.23 22.8 370.19 21.92 369.15 21.48 361.53 16.75 359.26 14.55 354.79 14.69 354.53 16.61 350.81 14.78 343.86 17.79 339.02 18.85 324.7 20.94 321.14 21.88 312.11 17.47 302.04 18.57 294.2 6.41 293.9 6.01 293.53 1 287.37 9.74 285.85 14 281.29 14.43 276.87 Z"/>
								</a>
							<!-- </g> -->
								
								<text class="TEXT" x="250" y="260">
									<a id="gwangsangu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=광산구&pageNum=1&petType=${param.petType}">
										광산구
									</a>
								</text>
								<text class="TEXT" x="560" y="160">
									<a id="bukgu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=북구&pageNum=1&petType=${param.petType}">
										북구
									</a>
								</text>
								<text class="TEXT" x="440" y="330">
									<a id="seogu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=서구&pageNum=1&petType=${param.petType}">
										서구
									</a>
								</text>
								<text class="TEXT" x="480" y="430">
									<a id="namgu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=남구&pageNum=1&petType=${param.petType}">
										남구
									</a>
								</text>
								<text class="TEXT" x="650" y="390">
									<a id="dongu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=광주광역시&siguSel=동구&pageNum=1&petType=${param.petType}">
										동구
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