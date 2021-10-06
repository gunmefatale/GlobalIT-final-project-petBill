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
	<title>** 경상북도 **</title>
	
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
			fill: rgba(10, 80, 160, 0.4);
		}
		
		.mapdiv path:hover {
			/* fill: #0a50a0; */
			fill: rgba(10, 80, 160, 0.7);
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
		    stroke-width: 0.7px;
		}
		.TEXT {
		    fill: #000000;
		    font-size: 0.5em;
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
										<a class="dropdown-item" href="/petBill/search/loc/locNorthGyeongsang.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locNorthGyeongsang.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>경 상 북 도</h2>
						</section>
					</div>
					
					<div class="mapdiv" id="region">
					
						<?xml version="1.0" encoding="UTF-8" standalone="no"?>
						<!-- Created with Inkscape (http://www.inkscape.org/) -->
						
						<svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-30 -10 350 310" >
							
							<g transform="translate(-309.61112,-642.37589)">
						  	
						  	<defs>
							    <filter id="dropshadow">
							        <feGaussianBlur in="SourceAlpha" stdDeviation="2" />
							        <feOffset dx="0" dy="0" result="offsetblur" />
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
						  		
							  	<a id="mungyeong" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=문경시&pageNum=1&petType=${param.petType}">
								  	<title>문경시</title>
								    <path class="OUTLINE"
								       d="m 357.34454,742.16597 4.58212,2.90098 8.9741,4.25516 1.33569,8.31654 6.30042,0.38641 0.76407,-3.28739 3.24529,-0.77398 -0.19016,-5.60818 -2.67367,-5.22177 6.87319,-6.76858 3.24644,0.5802 0.57276,-1.93438 -3.43659,-4.25516 2.29106,-11.99034 3.81806,-0.38641 -0.28638,-9.81461 -2.57745,-2.46699 -4.29574,-1.59554 -7.44596,-8.848 -3.57978,-0.87029 -3.96125,3.48117 -0.19131,6.18838 -3.05513,0.96661 -7.82741,-3.38487 -7.15958,6.09207 -1.5751,-1.88564 -2.33918,-0.43399 -1.52699,6.18838 -3.00702,5.5606 7.01638,7.10741 -4.00936,1.16039 -5.44128,-3.91633 -2.29106,2.03069 -4.72532,-3.04603 -2.86383,5.80197 -3.72297,2.75593 -2.72064,0.33883 6.30042,6.76858 -2.14787,8.12275 2.14787,8.31654 -0.1913,5.02798 4.96473,1.74059 2.67253,-4.44779 6.49173,0.5802 3.05398,-5.41555 -0.57276,-2.51458 4.20066,-3.67496 3.05513,-0.38641 1.90846,-1.74059 z"
								       id="mungyeong" />
							  	</a>
							    <a id="sangju" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=상주시&pageNum=1&petType=${param.petType}">
								  	<title>상주시</title>
								    <path class="OUTLINE"
								       d="m 358.10861,810.43654 2.48236,-4.25516 2.67253,-6.18838 8.97409,-0.5802 2.86383,-7.93012 4.19952,-3.2874 3.6279,2.7072 3.05513,-5.41439 4.39082,-5.22177 -2.67252,-5.60934 -2.67367,-4.44779 -5.34505,-2.127 -1.14668,-10.05713 -6.30042,-0.38641 -1.33569,-8.31654 -8.9741,-4.25516 -4.58212,-2.90098 -1.90846,1.74059 -3.05513,0.38757 -3.81806,3.67497 0.19131,3.09476 -3.05513,4.83536 -6.49173,-0.58019 -2.67253,4.44778 -4.58212,-1.93437 -0.19131,-5.60934 -2.14787,-7.54256 -6.25231,-6.76857 -1.19364,-1.64428 -3.4366,3.91633 1.00234,2.61088 -9.54571,2.07943 1.33569,3.09477 5.15489,2.90098 4.00936,0 1.14553,4.25516 4.39197,5.41555 0.19016,3.09477 -3.81806,2.32079 -0.1913,10.635 1.14667,2.51457 -2.86497,3.09361 3.24644,4.44895 0.38146,4.06137 -6.49058,7.34877 2.09976,6.18838 3.81805,0.5802 3.24529,-4.64158 3.81921,4.83536 6.10912,3.2874 3.05513,-2.90099 4.96359,0.19379 2.48236,2.32079 3.24529,2.90098 4.20067,-0.96661 3.24529,0.5802 z"
								       id="sangju" />
							  	</a>   
							    <a id="yecheon" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=예천군&pageNum=1&petType=${param.petType}">
							  		<title>예천군</title>
								    <path class="OUTLINE"
								       d="m 404.69394,758.41147 3.05398,-6.38216 4.20067,-3.09477 0,-5.99459 5.15489,-0.77398 -0.1913,-3.67497 7.44595,-3.09477 2.86383,-0.19378 0.95537,-7.92897 -4.96473,-6.57595 -3.62675,-6.38216 -5.3462,-0.19146 -5.72766,-1.54681 0.19131,-7.15614 0.38146,-2.7072 -3.57979,-4.44779 -4.29574,6.67227 -4.43893,-0.29126 -4.00936,3.91632 -0.28639,9.81461 -3.24529,0.38641 -2.29106,11.99034 3.05399,3.67497 -0.19016,2.51457 -3.24644,-0.5802 -6.87319,6.76858 2.29107,5.41555 0.57276,5.41556 -3.24529,0.77398 -0.76407,3.28739 0.76407,9.66956 5.72766,2.51457 3.62675,-4.44779 1.14553,-6.57595 5.15489,-0.19378 1.33684,3.09477 4.39082,-3.67497 4.01051,0 z"
								       id="yecheon" />
							  	</a>   
							    <a id="yeongju" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영주시&pageNum=1&petType=${param.petType}">
								  	<title>영주시</title>
								    <path class="OUTLINE"
								       d="m 446.12323,724.95386 -0.38146,-15.66531 -1.14553,-3.48118 1.9096,-5.99575 -2.86383,-3.67497 -7.06449,0.77399 0,3.67496 -3.4366,-4.44779 2.48237,-11.02373 2.86383,-8.50916 2.67252,-13.53831 -6.87319,-3.28739 -3.15021,3.67496 -7.15957,0.14505 -5.15489,9.28315 -3.00702,1.01534 -11.02574,10.73364 -2.19599,6.09206 1.76641,4.35147 1.14553,3.19108 3.57979,4.44779 -0.57277,9.86334 5.72766,1.54681 5.3462,0.19378 3.62675,6.38216 2.48237,3.09361 9.35555,-0.38641 4.19952,2.51457 2.67367,-1.35418 4.19952,0.38642 z"
								       id="yeongju" />
							  	</a>   
							    <a id="bonghwa" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=봉화군&pageNum=1&petType=${param.petType}">
							  		<title>봉화군</title>
								    <path class="OUTLINE"
								       d="m 483.73561,716.05712 -3.05513,0.5802 -4.39082,-4.64157 -5.91896,-0.38641 -10.50109,-6.38217 -2.86383,1.35418 -1.52699,-2.90098 -4.20067,2.51457 -5.91781,1.93322 -0.57277,-3.09477 1.7183,-5.22177 -2.86383,-3.67497 -7.06449,0.77399 0,3.67496 -3.4366,-4.44779 2.48237,-11.02373 2.86383,-8.50916 2.67252,-13.53831 6.68189,1.74059 -0.76293,-3.48118 5.72766,-6.38216 6.30042,4.44779 5.53636,1.5468 4.77343,-0.77398 3.43659,-7.34877 4.96359,2.90098 3.43659,-1.16039 10.88255,2.51457 0.76407,-2.7072 3.24529,-2.70719 4.20067,0.9666 9.92717,8.50917 -4.00936,4.64157 -3.24529,-2.127 -6.87319,3.86759 1.14554,7.92896 -1.527,3.67497 7.82742,5.22177 2.67252,6.57595 -4.58212,4.06137 -2.29107,5.02798 -7.25465,4.83536 -4.00936,4.44779 -6.30042,1.16039 0.76407,3.09477 1.14553,2.51341 z"
								       id="bonghwa" />
							  	</a>   
							    <a id="yeongyang" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영양군&pageNum=1&petType=${param.petType}">
								  	<title>영양군</title>
								    <path class="OUTLINE"
								       d="m 524.21068,729.01523 2.67252,-7.73634 -3.62675,-5.22177 6.30042,-7.92896 -5.72766,-7.92897 0.19016,-6.18838 -3.43659,-0.9666 -1.90846,3.09476 -4.77343,-2.90098 -7.63726,-2.32078 -4.58212,4.06137 -2.29107,5.02798 -7.25465,4.8342 -4.00936,4.44779 -6.10912,1.74059 0.57277,2.51457 1.14553,2.51457 -0.1913,2.32079 0.76407,7.92896 -0.19131,13.15074 2.09976,5.22177 4.20067,0.5802 4.00936,6.57595 6.87319,0.77398 3.05513,4.25516 0,2.51457 4.39082,-0.19495 8.40018,2.12701 1.9096,-2.7072 1.33684,-9.66956 -3.6279,-5.99575 2.86383,-6.96236 -1.14553,-4.83536 1.7183,-1.93437 4.00936,-0.19263 z"
								       id="yeongyang" />
							  	</a>   
							    <a id="uljin" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울진군&pageNum=1&petType=${param.petType}">
								  	<title>울진군</title>
								    <path class="OUTLINE"
								       d="m 546.73984,730.36941 -9.73701,0.19379 -2.67367,2.32078 -4.58213,-2.90098 -5.53635,-0.96777 2.67252,-7.73634 -3.62675,-5.22177 6.30042,-7.92896 -5.72766,-7.92897 -0.3826,-6.18838 -2.29107,-0.9666 -2.86383,3.09476 -4.58212,-3.48117 -7.44596,-1.74059 -2.67252,-6.57711 -7.82742,-5.22177 1.527,-3.67497 -1.14554,-7.92896 6.87319,-3.86759 3.6279,1.93437 3.62675,-4.44778 6.49173,-0.19379 -0.38146,-6.18954 6.68188,-6.57594 4.20067,-0.38642 4.19952,-4.83535 4.00936,0 2.86383,8.12275 7.06449,6.76857 -2.67253,3.28739 0.95423,9.08936 -1.14553,4.06138 2.48237,5.60818 -0.95538,7.15614 0.95538,8.89674 5.15489,5.22177 2.86383,8.89673 -0.76407,3.09477 0.95423,3.86759 -0.57277,8.50916 -5.91782,4.83652 z"
								       id="uljin" />
							  	</a>   
							    <a id="andong" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=안동시&pageNum=1&petType=${param.petType}">
								  	<title>안동시</title>
								    <path class="OUTLINE"
								       d="m 470.75216,798.44503 -3.24529,-11.41014 -5.53636,-8.89673 -1.9096,-6.18838 -11.45531,-6.76857 -2.48237,1.74059 -2.48122,-0.38642 -0.76407,6.18838 -13.74638,5.80197 -5.15489,-5.22177 -4.58213,-9.28315 -5.91896,-1.74059 -3.81805,-2.12816 -2.86383,3.48118 -4.00936,-1.74059 0,-3.28739 1.33683,-0.19379 4.00936,-6.96236 3.81806,-2.51457 0,-5.99459 5.15489,-0.77398 -0.1913,-3.67497 7.44595,-3.09477 2.86383,-0.19378 0.95537,-7.92897 -2.48236,-3.48118 9.35555,-0.38641 4.19952,2.51457 2.67367,-1.35418 4.19952,0.38642 -0.76292,-16.8257 5.91781,-1.93438 4.20067,-2.51457 1.52699,2.90098 2.86383,-1.35418 9.92832,6.18838 6.49173,0.5802 4.39082,4.64157 2.67252,-0.5802 0.95538,10.24975 -0.19131,13.15422 2.09976,5.22177 -2.86383,3.86759 0.38261,3.67497 -2.86383,2.70719 4.19952,4.44779 -2.67252,6.76973 -1.33684,4.64158 1.9096,6.18837 -2.67252,7.15615 0,7.54255 -6.87319,6.57595 -2.67367,0.19262 z"
								       id="andong" />
							  	</a>   
							    <a id="uiseong" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=의성군&pageNum=1&petType=${param.petType}">
								  	<title>의성군</title>
								    <path class="OUTLINE"
								       d="m 406.02963,795.15764 -5.72766,6.96236 -8.40018,-11.21752 -5.5375,3.48118 -3.43545,-3.48118 3.24529,-6.18838 3.81806,-4.44778 -4.96359,-10.05713 3.62675,-4.44779 1.14553,-6.57595 5.15489,-0.19378 1.33684,3.09477 4.39082,-3.67497 2.10091,0.19379 0,3.28739 4.00936,1.74059 2.86383,-3.48118 3.81805,2.127 5.91896,1.74059 4.19952,9.28315 5.5375,5.22177 13.74638,-5.80197 0.76407,-6.18838 2.48122,0.38642 2.48237,-1.74059 11.45531,6.76973 1.527,5.80196 5.53635,9.47693 3.6279,11.21636 -2.29107,0.38758 -0.38146,3.86759 -3.6279,2.51457 5.72766,2.51341 -2.09976,3.28855 2.67253,4.254 -0.76293,1.93438 -6.49172,-3.67497 -6.68303,3.48118 -9.54572,-0.19262 -9.54571,-3.67497 -4.20067,1.54681 -0.38146,-6.57479 -8.01872,-5.41555 -4.20066,0.77398 -1.14553,-3.86875 -7.44596,-0.77282 -4.00936,-3.67497 -2.29106,0 0,0 z"
								       id="uiseong" />
							  	</a>   
							    <a id="gimcheon" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=김천시&pageNum=1&petType=${param.petType}">
								  	<title>김천시</title>
								    <path class="OUTLINE"
								       d="m 351.42672,882.76732 2.67367,-5.60818 -4.96473,-11.9915 2.86383,-0.38641 2.67367,2.70719 3.43659,-5.99459 3.24529,-1.35418 4.00936,-5.41555 0,-6.38216 4.00936,-0.77282 3.81806,-3.86875 12.02808,0 -1.7183,-4.8342 0.95423,-2.51457 -2.48236,-2.7072 0.38146,-4.25516 0.95537,-5.22177 -3.24644,-3.2874 -0.76292,-2.32078 -5.15489,-1.35418 -0.1913,-3.86759 -8.40019,-4.83536 -5.34619,-1.74059 -2.48237,3.48118 -2.86268,-0.38641 -4.20067,0.96661 -3.24529,-2.90098 -2.1009,2.70719 4.96473,8.51033 -3.6279,0.38641 -4.96473,-1.93438 -3.62675,0.96777 1.14553,4.8342 1.52699,3.48118 -3.43659,5.02914 -1.7183,10.44354 -7.44595,2.51341 -4.77343,5.22177 0.1913,4.44894 5.53635,8.70295 -4.39082,3.2874 0.38146,6.57594 6.11027,2.127 1.33569,5.22177 7.06449,-0.38641 4.20066,4.254 7.63726,-1.5468 z"
								       id="gimcheon" />
							  	</a>   
							    <a id="gimchgumieon" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=구미시&pageNum=1&petType=${param.petType}">
								  	<title>구미시</title>
								    <path class="OUTLINE"
								       d="m 396.10245,842.15356 4.77343,-5.80196 c 0,0 8.01987,3.28739 8.21003,2.70719 0.19015,-0.58019 4.39082,-7.73518 4.39082,-7.73518 l 10.30978,0.5802 -3.6279,-7.54256 1.33684,-2.51457 -4.00936,-4.44778 -4.39197,2.70719 -1.7183,-7.73634 -5.15489,1.16039 -5.15489,-5.41439 -0.76407,-5.99575 -8.40018,-11.21752 -5.5375,3.48118 -3.43545,-3.48118 -3.6279,-2.7072 -4.19952,3.2874 -2.86383,7.93012 -8.97409,0.5802 -3.05513,6.76857 6.10912,1.93438 7.63726,4.64157 0.1913,3.86759 5.15489,1.35418 0.76292,2.32078 3.24644,3.2874 -0.95537,5.22177 -0.38146,4.25516 2.48236,2.7072 3.62676,0.38641 8.01986,5.41555 z"
								       id="gumi" />
							  	</a>   
							    <a id="seongju" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=성주군&pageNum=1&petType=${param.petType}">
							  		<title>성주군</title>
								    <path class="OUTLINE"
								       d="m 365.1731,894.17747 1.52699,-2.12701 -0.57276,-3.86759 6.10912,-1.16039 4.20066,5.4144 5.91896,-6.57479 4.00936,1.93321 6.30043,2.90099 5.53635,-7.92897 0,-8.50916 2.67253,-5.80197 -1.527,-3.67496 -4.77343,-2.127 -8.01872,-7.34993 0.38261,-6.76858 -1.71944,-4.83535 -12.02808,0 -3.81806,3.86875 -4.00936,0.77282 0,6.38216 -3.4366,4.64157 -3.81805,2.12816 -3.4366,5.99459 -2.67252,-2.70719 -2.86383,0.38641 4.96473,11.9915 -2.67367,5.60818 7.2558,2.90098 3.05513,6.76858 3.43545,1.74059 z"
								       id="seongju" />
							  	</a>   
							    <a id="goryeong" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=고령군&pageNum=1&petType=${param.petType}">
								  	<title>고령군</title>
								    <path class="OUTLINE"
								       d="m 364.79049,915.45211 0.38261,-2.32078 6.87319,-5.02915 -2.67367,-7.92896 -4.19952,-5.99575 1.52699,-2.12701 -0.57276,-3.86759 6.10912,-1.16039 4.20066,5.4144 6.10912,-6.96236 10.11963,4.64157 5.53635,-8.31538 5.53635,-1.35418 7.63726,3.86759 -0.76407,2.90099 -7.44595,0.58019 -2.67253,6.18954 -1.71829,3.28739 6.87319,5.60818 -0.76407,5.99575 -10.49995,-1.16039 0.76293,5.41556 5.5375,5.22177 0,5.60818 -3.8192,0.38641 -3.62676,-5.22177 -5.15489,-2.51341 -8.97409,0.38641 -3.24529,2.32078 -4.39083,-0.77398 -1.52814,-1.74059 -5.15489,-1.35302 z"
								       id="goryeong" />
							  	</a>   
							    <a id="chilgok" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=칠곡군&pageNum=1&petType=${param.petType}">
								  	<title>칠곡군</title>
								    <path class="OUTLINE"
								       d="m 415.00372,872.13 -4.96473,-1.54681 -0.38146,-5.99575 -2.86383,-1.35302 -5.91896,5.22177 -1.527,-3.67496 -5.34619,-2.7072 -7.44596,-6.76973 -0.19016,-7.34877 -2.86497,-9.08936 0.95537,-2.51457 3.62676,0.38641 8.01872,5.41555 4.77343,-5.80196 8.21002,2.70719 4.96359,-7.54255 9.73702,0.38757 0.3826,8.31538 8.40019,-2.127 0.38146,11.79771 -4.19952,5.22177 -6.87319,3.48118 -2.86383,-1.93437 -1.52814,1.5468 1.14553,4.25516 -0.95422,4.83536 -2.67253,4.8342 z"
								       id="chilgok" />
							  	</a>   
							    <a id="gunwi" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=군위군&pageNum=1&petType=${param.petType}">
								  	<title>군위군</title>
								    <path class="OUTLINE"
								       d="m 443.06924,849.88874 0.76293,-9.86334 5.34619,-6.96236 6.30043,2.12816 4.00936,0.96661 4.96358,-8.12275 7.82857,-1.35418 -0.76407,-6.57479 -1.52814,-2.90098 -6.49058,-3.67497 -6.30043,3.2874 -9.92832,10e-4 -9.54571,-3.67497 -4.20067,1.54681 -0.38146,-6.57479 -8.01872,-5.41555 -4.20066,0.38641 -1.14553,-3.48118 -7.44596,-0.77282 -4.00936,-3.67497 -2.29106,0 -5.34505,6.18838 0.19016,5.99575 5.34619,6.18837 5.15489,-1.16039 1.7183,7.34877 4.39082,-2.31962 4.00936,4.44778 -0.95422,2.90098 3.05513,6.57479 0.57276,8.89674 8.40019,-2.127 0.38146,11.79771 10.11962,-10e-4 z"
								       id="gunwi" />
							  	</a>   
							    <a id="yeongdeok" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영덕군&pageNum=1&petType=${param.petType}">
								  	<title>영덕군</title>
								    <path class="OUTLINE"
								       d="m 540.5345,801.8299 -11.7417,-0.5802 1.14553,-6.67226 -2.57744,-2.90098 -4.00936,0.5802 -4.86851,-5.22177 -0.28638,-5.80197 -3.72298,-7.54255 -4.29574,-0.8703 -2.57745,-5.22177 -0.28638,-7.83265 1.43191,-0.5802 8.40018,2.12701 1.33684,-1.83691 1.9096,-10.53985 -3.6279,-5.99575 2.86383,-6.96236 -1.14553,-4.83536 1.7183,-1.93437 4.00936,-0.19263 5.53635,0.96661 4.58213,2.90098 2.67367,-2.32078 9.73701,-0.19379 -1.62321,6.47847 0.28638,7.54256 5.15489,6.67342 -0.57277,7.54256 -1.43191,8.12275 -0.28638,10.15344 -7.44596,12.76432 -0.28638,12.18413 z"
								       id="yeongdeok" />
							  	</a>   
							    <a id="yeongdeok" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=청송군&pageNum=1&petType=${param.petType}">
								  	<title>청송군</title>
								    <path class="OUTLINE"
								       d="m 496.14515,812.56354 2.29107,-3.77128 -5.44128,-4.35147 3.15021,-2.03069 9.45064,2.61088 6.30042,6.96236 6.87319,-11.02373 0,-4.93167 4.58213,-3.77128 -4.86851,-5.22177 -0.28638,-5.80197 -3.72298,-7.54255 -4.29574,-0.8703 -2.57745,-6.09206 -0.28638,-6.96236 -2.95891,-0.38641 0,-2.51457 -3.05513,-4.25516 -6.87319,-0.77399 -4.00936,-6.57478 -4.20067,-0.5802 -2.86383,3.86759 0.38261,3.67497 -2.86383,2.70719 4.19952,4.44779 -4.00936,11.41015 1.9096,6.18837 -2.67252,7.15615 0,7.54255 -6.87319,6.57595 -4.96474,0.5802 -0.38146,3.86875 -3.6279,2.51457 5.72766,2.51341 -2.09976,3.28855 2.67253,4.254 -0.76293,1.93438 1.52814,2.90098 6.30043,0.5802 5.15489,2.32079 6.5868,-3.48118 2.86383,-6.09207 3.72183,-0.87029 z"
								       id="cheongsong" />
							  	</a>
							    <a id="pohang" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=포항시&pageNum=1&petType=${param.petType}">
								  	<title>포항시</title>
								    <path class="OUTLINE"
								       d="m 527.36089,836.93179 -4.86851,0.5802 -1.43192,4.35147 -6.30042,1.74059 -4.58212,-3.48118 -3.4366,-0.87029 -0.57277,-2.61089 -4.8685,-3.77127 0,-2.61089 -3.72298,-0.2901 -3.15021,-5.22177 -10.30979,-2.03068 5.44128,-3.19108 2.86383,-6.09207 3.72297,-0.87029 2.29107,-3.77128 -5.44128,-4.35147 3.15021,-2.03069 9.45064,2.61088 6.30042,6.96236 6.87319,-11.02373 0,-4.93167 4.58213,-3.77128 4.00936,-0.5802 2.57744,2.90098 -1.14553,6.67226 11.7417,0.5802 1.14553,5.22177 1.7183,1.45049 -2.00468,4.64157 -1.43192,0.5802 1.14554,2.32079 2.86382,2.61088 0.85915,6.38216 5.15489,4.93167 -1.43191,2.90099 -6.87319,6.96236 3.72298,5.22176 2.57744,3.77128 6.01404,3.19108 3.15022,-4.64157 3.72297,-2.61088 6.58681,-10.15344 2.29106,2.32078 1.43192,8.70295 -3.15021,7.54256 -1.43192,6.38216 -4.58212,2.90098 2.29106,8.12275 -0.28638,7.25246 -2.00468,2.90098 -6.87319,-3.77128 -5.44128,-5.80196 -2.57744,4.35147 -7.15958,-0.58019 -0.85914,-3.77128 -2.29107,-2.90098 -4.00936,-13.05443 -6.01404,-9.28314 2.00468,-6.96236 -1.43191,-2.03069 z"
								       id="pohang" />
							  	</a>   
							    <a id="yeongcheon" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영천시&pageNum=1&petType=${param.petType}">
								  	<title>영천시</title>
								    <path class="OUTLINE"
								       d="m 480.96686,881.60693 -8.01872,-1.1604 -4.86851,-5.80196 0.57277,-3.48118 -2.00468,-4.35148 -0.57277,-6.96235 -7.44595,-2.32079 -4.00936,-3.19108 -5.72766,0.87029 -1.43191,-4.06137 -4.39083,-1.25787 0.76293,-9.86334 5.34619,-6.96236 10.30979,3.09477 4.96358,-8.12275 7.82857,-1.35418 -0.76407,-6.57479 6.30042,0.5802 5.15489,2.32079 11.45532,1.74058 3.15021,5.22177 3.72298,0.2901 0.28638,3.48118 4.58212,2.90098 0.57277,2.61089 1.14553,0.87029 -1.14553,3.77128 1.14553,6.09206 -3.43659,-0.87029 -2.00468,-1.16039 1.71829,10.73363 3.72298,5.22177 -3.15021,1.1604 -2.86383,-3.19109 -5.44127,0 -4.00936,6.96236 -0.57277,8.41285 -6.58681,5.22177 -4.29574,-0.87029 z"
								       id="yeongcheon" />
							  	</a>   
							    <a id="gyeongsan" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=경산시&pageNum=1&petType=${param.petType}">
								  	<title>경산시</title>
								    <path class="OUTLINE"
								       d="m 477.24388,894.66135 -4.58212,0.87029 -6.01404,2.32079 -9.16425,0.5802 -4.29575,8.41285 -6.30042,-3.48118 -4.29574,-4.93167 1.43191,-3.19108 -1.14553,-3.77128 3.72298,-2.90098 0,-5.51187 1.71829,-4.35148 4.00936,-2.32078 0,-8.70295 -2.86382,-2.03069 -0.57277,-10.44354 5.72766,-0.87029 3.15021,3.19108 8.3051,2.32079 0.57277,6.96235 2.00468,4.35148 -0.57277,3.48118 4.86851,5.80196 9.16425,1.4505 -1.14553,6.09206 -3.72298,6.67226 z"
								       id="gyeongsan" />
							  	</a>   
							    <a id="cheongdo" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=청도군&pageNum=1&petType=${param.petType}">
								  	<title>청도군</title>
								    <path
								       d="m 438.5822,926.57216 -6.30043,2.90098 -10.59616,-8.70295 -2.29107,-6.09206 -0.85914,-4.35147 0.85914,-4.93167 5.1549,-4.06138 8.3051,0.2901 -0.57277,5.22177 8.01872,-2.90099 2.29107,-5.51186 3.15021,4.06137 7.44595,4.35148 4.29575,-8.41285 7.15957,-0.8703 8.01872,-2.03069 4.58212,-0.87029 3.72298,-6.67226 1.14553,-6.09206 3.15021,0.58019 5.1549,-3.77128 -3.15021,7.54256 -2.86383,9.28314 5.72765,10.73364 2.57745,1.45049 3.15021,9.28315 -6.01404,2.32078 -4.00936,3.77128 -4.00936,-4.06138 -4.86851,-2.03068 -7.15957,2.61088 -2.86383,6.09206 -6.30042,0.2901 -3.15021,4.35148 -8.30511,-0.8703 -6.01404,-2.03069 -4.58212,-0.87029 z"
								       id="cheongdo" />
							  	</a>   
							    <a id="gyeongju" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=경주시&pageNum=1&petType=${param.petType}">
								  	<title>경주시</title>
								    <path class="OUTLINE"
								       d="m 540.5345,908.58607 -8.3051,5.51186 -5.1549,-1.45049 -0.57276,-8.12275 -7.44596,-2.03069 -7.73233,0.2901 -1.43192,-1.16039 -3.43659,2.90098 -5.44128,0.8703 -3.72297,7.54255 3.43659,4.06138 -4.86851,-0.8703 -3.15021,-8.41285 -2.57745,-1.45049 -5.72765,-10.73364 6.01404,-16.8257 1.43191,-1.45049 0.57277,-8.41285 4.00936,-6.96236 5.44127,0 2.86383,3.19109 3.15021,-1.1604 -3.72298,-5.22177 -1.71829,-10.73363 5.15489,1.16039 -0.85915,-5.22177 1.14553,-3.77128 3.15021,0.2901 3.72298,3.19108 6.30042,-1.74059 1.43192,-4.35147 4.86851,-0.5802 1.43191,3.19108 -2.00468,5.80197 6.01404,9.28314 4.00936,13.05443 2.29107,2.90098 0.85914,3.77128 7.15958,0.58019 2.57744,-4.35147 5.44128,5.80196 6.87319,3.77128 0.57276,3.19108 -3.15021,3.77128 -0.57277,10.15344 -2.00468,6.96236 0.28639,3.19108 -4.86851,5.51187 -11.7417,-4.93167 z"
								       id="gyeongju" />
							  	</a>   
							    <a id="ulleungdo" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울릉군&pageNum=1&petType=${param.petType}">
								  	<title>울릉도</title>
								    <path class="OUTLINE"
								       d="m 580.91449,786.45469 -3.72298,-0.2901 -2.57745,1.74059 -4.29574,2.90099 -4.86851,0.2901 -3.15021,0.58019 1.43191,2.90098 1.14553,2.90099 0,2.32078 9.16426,3.48118 0.85914,-2.32078 4.58213,-3.19108 0.28638,-6.96236 1.14554,-4.35148 z"
								       id="ulleungdo" />
							  	</a>   
							    <a id="ulleungdo" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울릉군&pageNum=1&petType=${param.petType}">
								  	<title>울릉도</title>
								    <path class="OUTLINE"
								       inkscape:connector-curvature="0"
								       i:knockout="Off"
								       d="m 585.21023,808.21206 -27.49276,0 0,-27.84943 27.49276,0 0,27.84943 z"
								       id="ulleungdo-outline"
								       style="fill:none;stroke:#7f7f7f;stroke-width:1.15293837000000000;stroke-opacity:1" />
							  	</a>   
							    <a id="ulleungdo" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울릉군&pageNum=1&petType=${param.petType}">
								  	<title>독도는 우리땅!</title>
								    <path class="OUTLINE"
								       d="m 593.51533,801.5398 -1.43191,2.90099 2.29106,1.16039 1.43191,-2.90098 -2.29106,-1.1604 z"
								       id="dokdo" />
							  	</a>   
							    <a id="ulleungdo" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울릉군&pageNum=1&petType=${param.petType}">
								  	<title>독도는 우리땅!</title>
								    <path class="OUTLINE"
								       inkscape:connector-curvature="0"
								       i:knockout="Off"
								       d="m 598.38384,807.92197 -9.45063,0 0,-9.57325 9.45063,0 0,9.57325 z"
								       id="dokdo-outline"
								       style="fill:none;stroke:#7f7f7f;stroke-width:1.15293837000000000;stroke-opacity:1" />
							  	</a>   
							       
							  	<!-- </g> -->
							       
							    <text class="TEXT" x="525" y="825" id="pohang" >
							    	<a id="pohang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=포항시&pageNum=1&petType=${param.petType}">
							    		포항시
							    	</a>	
							    </text>
							    <text class="TEXT" x="390"  y="815" id="gumi" >
							    	<a id="gumi" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=구미시&pageNum=1&petType=${param.petType}">
							    		구미시
									</a>
								</text>
							    <text class="TEXT" x="460" y="890" id="gyeongsan" >
							    	<a id="gyeongsan" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=경산시&pageNum=1&petType=${param.petType}">
							    		경산시
							    	</a>	
							    </text>
							    <text class="TEXT" x="520" y="885" id="gyeongju" >
							    	<a id="gyeongju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=경주시&pageNum=1&petType=${param.petType}">
							    		경주시
							    	</a>	
							    </text>
							    <text class="TEXT" x="450" y="750" id="andong" >
							    	<a id="andong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=안동시&pageNum=1&petType=${param.petType}">
							    		안동시
							    	</a>	
							    </text>
							    <text class="TEXT" x="352" y="843" id="gimcheon" >
							    	<a id="gimcheon" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=김천시&pageNum=1&petType=${param.petType}">
							    		김천시
							    	</a>	
							    </text>
							    <text class="TEXT" x="420" y="700" id="yeongju" >
							    	<a id="yeongju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영주시&pageNum=1&petType=${param.petType}">
							    		영주시
							    	</a>
							    </text>
							    <text class="TEXT" x="350" y="780" id="sangju" >
							    	<a id="sangju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=상주시&pageNum=1&petType=${param.petType}">
							    		상주시
							    	</a>	
							    </text>
							    <text class="TEXT" x="478" y="850" id="yeongcheon" >
							    	<a id="yeongcheon" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영천시&pageNum=1&petType=${param.petType}">
							    		영천시
							    	</a>	
							   	</text>
							    <text class="TEXT" x="365" y="730" id="mungyeong" >
							    	<a id="mungyeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=문경시&pageNum=1&petType=${param.petType}">
							    		문경시
							    	</a>		
							    </text>
							    <text class="TEXT" x="410" y="853" id="chilgok" >
							    	<a id="chilgok" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=칠곡군&pageNum=1&petType=${param.petType}">
							    		칠곡군
							    	</a>	
							    </text>
							    <text class="TEXT" x="430" y="793" id=""uiseong"" >
							    	<a id="uiseong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=의성군&pageNum=1&petType=${param.petType}">
							    		의성군
							    	</a>	
							    </text>
							    <text class="TEXT" x="525" y="685" id="uljin" >
							    	<a id="uljin" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울진군&pageNum=1&petType=${param.petType}">
							   			울진군
							   		</a>	
							   	</text>
							    <text class="TEXT" x="405" y="735" id="yecheon" >
							    	<a id="yecheon" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=예천군&pageNum=1&petType=${param.petType}">
							    		예천군
									</a>
								</text>
							    <text class="TEXT" x="455" y="917" id="cheongdo" >
							    	<a id="cheongdo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=청도군&pageNum=1&petType=${param.petType}">
							    		청도군
							    	</a>	
							    </text>
							    <text class="TEXT" x="375" y="873" id="seongju" >
							       	<a id="seongju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=성주군&pageNum=1&petType=${param.petType}">
							       		성주군
							    	</a>
							    </text>
							    <text class="TEXT" x="530" y="770" id="yeongdeok" >
							    	<a id="yeongdeok" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영덕군&pageNum=1&petType=${param.petType}">
							    		영덕군
							    	</a>	
							    </text>
							    <text class="TEXT" x="383" y="905" id="goryeong" >
							    	<a id="goryeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=고령군&pageNum=1&petType=${param.petType}">
							    		고령군
							    	</a>	
							    </text>
							    <text class="TEXT" x="467" y="685" id="bonghwa" >
							    	<a id="bonghwa" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=봉화군&pageNum=1&petType=${param.petType}">
							    		봉화군
							    	</a>	
							    </text>
							    <text class="TEXT" x="497" y="790" id="cheongsong" >
							    	<a id="cheongsong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=청송군&pageNum=1&petType=${param.petType}">
							    		청송군
							    	</a>	
							    </text>
							    <text class="TEXT" x="440" y="830" id="gunwi" >
							    	<a id="gunwi" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=군위군&pageNum=1&petType=${param.petType}">
							    		군위군
							    	</a>
							    </text>
							    <text class="TEXT" x="503" y="730" id="yeongyang" >
							    	<a id="yeongyang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=영양군&pageNum=1&petType=${param.petType}">
							    		영양군
							    	</a>	
							    </text>
							    <text class="TEXT" x="580" y="820" id="text3097" >
							    	<a id="ulleungdo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=경상북도&siguSel=울릉군&pageNum=1&petType=${param.petType}">
							    		울릉도/독도
							    	</a>	
							    </text>
							</g>
							
						</svg>
		
					</div>
					<br>
					<div align="center" class="blockquote-footer">
						Copyright (c) 25-April-2012, Author ASDFGH <br>
					    <cite title="Source Title">
						    This file is licenced under a Creative Commons license: <br>
						    https://commons.wikimedia.org/wiki/File:North_Gyeongsang_Municipal.svg
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