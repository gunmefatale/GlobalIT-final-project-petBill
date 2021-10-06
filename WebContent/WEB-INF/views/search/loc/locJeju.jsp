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
	<title>** 제주특별자치도 **</title>
	
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
		
		body {
			background-color: #01171b;
		}
		
		.mapdiv {
			width: 70%;
			margin: auto;
		}
		
		.mapdiv path {
			fill: rgba(18, 140, 117, 0.4);
			stroke: #545454;
			stroke-width: 1.5px;
		}
		
		.mapdiv path:hover {
			/* fill: #128c75; */
			fill: rgba(18, 140, 117, 0.6);
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
										<a class="dropdown-item" href="/petBill/search/loc/locJeju.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locJeju.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>제주특별자치시</h2>
						</section>
					</div>
					
					<div class="mapdiv" id="region">
						
						<?xml version="1.0"?>
					    <svg xmlns="http://www.w3.org/2000/svg" version="1.2" viewBox="5 510 800 450">
				        
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
						
							<a id="jeju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=제주특별자치도&siguSel=제주시&pageNum=1&petType=${param.petType}">
								<title>제주시</title>
								<path id="jeju" class="OUTLINE" d="M 782.5 570.64 793.02 582.52 799 599.78 792.96 609.42 776.95 606.31 770.92 591.22 782.5 570.64 Z M 732.74 618.54 730.11 618.3 730.04 618.3 728.28 618.97 728.18 618.99 726.6 619.37 726.54 619.39 723.14 620.17 723.1 620.14 721.69 620.98 720.98 620.46 720.88 620.38 715.48 621.2 714.03 622.95 713.68 623.87 713.54 624.2 713.47 624.3 711.68 625.1 708.93 626.42 708.69 626.32 707.16 626.56 707.15 626.51 705.74 626.43 705.57 626.53 685.74 640.67 685.37 640.9 684.01 641.27 683.68 641.36 667.58 647.87 667.4 647.95 654.98 659.27 642.17 661.67 640.96 661.91 628.64 665.4 627.88 665.26 611.03 677.15 610.71 677.56 599.56 686.16 599.35 686.26 599.26 686.28 598.18 686.82 598.24 687.06 584.78 689.93 583.56 689.75 580.37 689.44 578.37 689.21 565.72 683.06 563.74 684.27 546.47 687.04 525.82 696.79 507 711.65 492.55 717.49 466.37 722.87 464.96 728.79 447.58 731.86 430.5 740.79 416.24 743.57 396.14 741.25 372.95 754.25 372.79 754.63 372.66 754.77 371.97 754.34 354.88 755.41 354.31 756.02 352.35 758.21 352.02 758.43 336.61 760.48 336.04 761.06 334.87 762.22 334.75 762.21 307.06 756.7 306.69 756.64 305.99 757.17 305.73 757.61 304.03 757.65 295.12 757.08 294.01 756.87 285.5 759.69 285.06 760.18 284.79 760.21 284.51 760.44 284.4 760.62 284.24 760.83 283.96 761.05 283.83 761.4 283.52 761.57 283.3 761.88 282.63 771.25 282.14 771.51 280.29 772.65 279.89 773.15 279.45 773.28 279.06 773.19 278.85 773.7 272.91 777.6 235.88 772.73 235.67 772.58 223.64 770.5 206.64 776.71 205.74 776.92 186.54 777.79 185.96 778.5 185.86 778.66 175.22 791.06 174.37 792.17 167.43 792.31 167.31 792.31 147.06 798.14 143.12 811.32 130.24 823.83 119.7 827.5 119.58 827.52 118.61 827.35 82.29 840.3 56.28 827.52 31.25 832.6 30.76 832.83 27.08 834.92 26.88 834.59 26.17 834.98 26.08 834.85 25.48 835.4 25.45 835.55 25.51 835.65 23.52 842 23.43 841.98 23.33 842.05 16.57 830.75 22.76 823.26 18.79 812.71 23.72 803.03 18.24 793.57 19.62 779.42 35.65 765.59 37.99 754.92 54.79 747.57 77.13 719.03 87.99 720.11 103.79 706.59 116.09 688.15 116.77 666.84 130.92 659.18 144.63 658.43 158.46 648.51 166.01 629 189.24 631.78 204.35 619.9 218.74 619.29 235.23 607.02 243.88 612.73 257.19 610.96 275.43 601.8 301.34 597.59 307.59 590.31 330.18 582.26 341.02 571.8 356.81 577.69 375.64 575.52 387.55 568.49 394.98 572.54 408.82 568.19 429.05 566.87 439.97 553.09 476.46 554.81 476.31 544.65 488.59 540.24 504.18 547 517.49 536.66 527.37 541.3 568.09 527.94 575.25 534.33 596.89 531.85 608.2 522.81 643.03 533.16 658.47 530.43 664.85 551.35 693.48 569.81 704.31 564.48 724.39 568 743.79 594.68 741.29 611.55 732.74 618.54 Z"/>
							</a>
                			<a id="seogwipo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=제주특별자치도&siguSel=서귀포시&pageNum=1&petType=${param.petType}">
								<title>서귀포시</title>
	            				<path id="seogwipo" class="OUTLINE" d="M 730.04 618.3 730.11 618.3 732.74 618.54 751.83 634.61 754.33 652.61 737.9 705.17 735.78 723.1 711.21 733.69 698.58 754.43 699.46 765.35 678.89 787.18 678.5 803.12 661.38 820.56 649.08 818.78 625.35 823.65 609.85 819.65 597.92 836.25 578.35 851.81 554.42 852.67 535.91 860.43 514.03 863.44 491.05 861.12 479.44 867 477.63 875.3 458.46 884.05 456.13 892.94 438.74 899.75 428.9 891.03 412.5 889.29 406.82 894.2 384.97 896.02 361.94 893.76 350.63 905.09 334.64 902.19 314.55 909.68 304.97 894.9 282.99 895.1 277.84 900.7 255.85 886.72 232.74 898.62 217.25 902.75 205.7 896.26 186.33 897.27 175.45 891.16 163.64 896.83 157.6 906.18 143.87 915.14 138.88 932.15 119.73 942.69 92.56 910.4 87.04 896.47 71.57 887.47 55.91 884.19 37.22 868.83 23.33 842.05 23.43 841.98 23.52 842 25.51 835.65 25.45 835.55 25.48 835.4 26.08 834.85 26.17 834.98 26.88 834.59 27.08 834.92 30.76 832.83 31.25 832.6 56.28 827.52 82.29 840.3 118.61 827.35 119.58 827.52 119.7 827.5 130.24 823.83 143.12 811.32 147.06 798.14 167.31 792.31 167.43 792.31 174.37 792.17 175.22 791.06 185.86 778.66 185.96 778.5 186.54 777.79 205.74 776.92 206.64 776.71 223.64 770.5 235.67 772.58 235.88 772.73 272.91 777.6 278.85 773.7 279.06 773.19 279.45 773.28 279.89 773.15 280.29 772.65 282.14 771.51 282.63 771.25 283.3 761.88 283.52 761.57 283.83 761.4 283.96 761.05 284.24 760.83 284.4 760.62 284.51 760.44 284.79 760.21 285.06 760.18 285.5 759.69 294.01 756.87 295.12 757.08 304.03 757.65 305.73 757.61 305.99 757.17 306.69 756.64 307.06 756.7 334.75 762.21 334.87 762.22 336.04 761.06 336.61 760.48 352.02 758.43 352.35 758.21 354.31 756.02 354.88 755.41 371.97 754.34 372.66 754.77 372.79 754.63 372.95 754.25 396.14 741.25 416.24 743.57 430.5 740.79 447.58 731.86 464.96 728.79 466.37 722.87 492.55 717.49 507 711.65 525.82 696.79 546.47 687.04 563.74 684.27 565.72 683.06 578.37 689.21 580.37 689.44 583.56 689.75 584.78 689.93 598.24 687.06 598.18 686.82 599.26 686.28 599.35 686.26 599.56 686.16 610.71 677.56 611.03 677.15 627.88 665.26 628.64 665.4 640.96 661.91 642.17 661.67 654.98 659.27 667.4 647.95 667.58 647.87 683.68 641.36 684.01 641.27 685.37 640.9 685.74 640.67 705.57 626.53 705.74 626.43 707.15 626.51 707.16 626.56 708.69 626.32 708.93 626.42 711.68 625.1 713.47 624.3 713.54 624.2 713.68 623.87 714.03 622.95 715.48 621.2 720.88 620.38 720.98 620.46 721.69 620.98 723.1 620.14 723.14 620.17 726.54 619.39 726.6 619.37 728.18 618.99 728.28 618.97 730.04 618.3 Z"/>
							</a>
						<!-- </g> -->	
							
							<text class="TEXT" x="380" y="680">
								<a id="jeju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=제주특별자치도&siguSel=제주시&pageNum=1&petType=${param.petType}">
									제주시
								</a>
							</text>
							<text class="TEXT" x="420" y="810">
								<a id="seogwipo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=제주특별자치도&siguSel=서귀포시&pageNum=1&petType=${param.petType}">
									서귀포시
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
					<br>
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