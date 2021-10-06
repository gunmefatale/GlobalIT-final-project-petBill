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
	<title>** 전라남도 **</title>
	
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
			fill: rgba(254, 185, 19, 0.5);
			stroke: #545454;
			stroke-width: 1.5px;
		}
		
		.mapdiv path:hover {
			fill: #feb913;
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
		    font-size: 1.2em;
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
										<a class="dropdown-item" href="/petBill/search/loc/locSouthJeolla.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locSouthJeolla.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>전 라 남 도</h2>
						</section>
					</div>
					
					
					<div class="mapdiv" id="region">
					
					<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="50 60 900 750">
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
						
						<a id="mokpo" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=목포시&pageNum=1&petType=${param.petType}">
							<title>목포시</title>
							<path id="mokpo" class="OUTLINE" d="M 318 411 l 5 3 3 8 4 5 2 1 3 10 -6 2 -6 -7 -6 3 -5 0 0 2 -4 3 -6 0 1 -2 -6 3 -5 -2 -5 -5 0 0 3 -6 7 -9 -3 -6 15 -5 z " />
						</a>
						<a id="yeosu" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=여수시&pageNum=1&petType=${param.petType}">
							<title>여수시</title>
							<path id="yeosu" class="OUTLINE" d="M 891 565 l 5 1 4 8 2 3 3 5 3 6 -3 -1 -3 0 0 0 -1 0 0 1 5 1 7 5 -1 4 -6 1 -4 -1 0 0 -1 0 1 -1 2 -3 -7 -2 -8 -3 -3 -8 -5 -1 -5 -3 -4 -3 6 -2 5 -4 z M 891 505 l 2 -2 3 -6 0 -9 0 -5 0 0 -1 0 1 0 -1 -2 -3 -2 0 0 -1 -3 -2 -5 6 0 5 3 7 4 4 6 0 2 0 0 0 0 -4 0 -1 -4 -2 2 -2 -2 -2 0 0 2 2 2 -3 1 5 2 2 8 3 6 2 0 0 0 3 4 0 9 -1 9 -2 4 1 1 0 1 -1 1 1 2 -1 3 2 1 4 5 -10 4 -9 -3 -7 -3 -4 -5 -6 -4 -1 -7 2 -4 1 0 -2 -4 1 -6 z M 825 385 l 4 -1 -2 8 -3 4 1 2 4 5 3 5 2 -2 1 2 6 3 4 1 -3 2 -1 4 7 2 8 -2 5 -4 9 -3 0 -7 10 0 4 -1 -2 1 1 1 0 -1 3 1 4 3 1 -3 6 -3 6 1 1 4 0 0 0 4 -2 6 -1 4 2 3 -2 1 0 1 1 2 -1 2 1 3 -3 1 -3 4 -3 7 0 0 0 0 0 0 -1 2 0 2 0 0 1 2 1 11 3 3 4 -3 1 1 0 1 0 0 0 0 -6 3 -9 3 -5 3 -6 3 -5 -1 -4 -3 -4 -4 1 -1 -2 -2 -5 -4 -4 0 -1 3 0 0 -3 4 -3 7 -2 3 2 3 0 3 -2 -1 -4 -3 -3 3 -1 0 -1 0 0 0 0 0 0 1 0 1 0 1 3 3 2 5 5 3 -6 1 3 9 0 7 3 1 -2 1 2 1 -3 3 1 1 2 1 1 -1 0 4 -5 -1 -4 -4 -2 -2 0 0 0 0 0 0 -6 -2 -8 -1 -2 8 -2 -4 -4 -6 -3 -6 0 -9 1 -8 8 -1 -8 -4 -2 -4 -3 0 5 -5 1 -3 -1 0 2 -1 6 -4 3 -5 2 1 2 -1 0 -1 -2 -3 -3 -6 -3 2 -2 0 0 0 1 -4 -3 -4 2 -2 0 -1 -4 -5 -2 -7 -9 -1 -5 -2 0 -5 4 -5 3 -9 3 -4 1 -1 -1 -1 1 -1 -3 -4 -1 -7 8 -3 9 1 z " />
						</a>
						<a id="suncheon" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=순천시&pageNum=1&petType=${param.petType}">
							<title>순천시</title>
							<path id="suncheon" class="OUTLINE" d="M 753 233 l 5 4 6 5 5 3 5 3 5 5 5 7 5 4 1 0 2 0 3 3 4 4 2 6 -3 9 -2 4 0 5 3 5 4 5 5 5 2 6 2 11 -4 7 -2 3 2 1 1 4 -3 5 1 1 0 0 0 0 -1 1 0 2 4 4 4 5 4 1 1 13 0 6 1 -5 5 10 -5 5 -1 -5 -3 -3 1 3 -2 2 1 0 4 3 -9 -1 -8 3 1 8 3 2 -1 2 1 1 -1 1 -3 4 -8 0 -2 -8 0 -10 2 -5 1 1 -1 -1 -4 4 -8 4 -6 -3 3 3 1 7 0 8 -3 4 0 0 -4 -1 -8 1 -3 3 -1 -1 -4 -3 1 -2 0 0 1 -2 1 -3 -1 2 -1 2 0 0 -1 -1 1 -3 -2 5 -2 5 0 0 -3 2 -3 -1 -1 -1 0 0 -4 -3 -9 -1 -4 -6 -5 -4 -9 -3 -3 -6 -1 -5 -1 0 -3 2 -4 -4 -8 -4 -9 3 -5 3 0 0 -1 0 0 -1 -5 2 -4 0 -5 -6 1 -10 -2 -10 -2 -7 -1 -2 0 0 -3 -2 -4 -8 -2 -5 -4 -1 -2 6 -7 -2 2 -3 1 -2 -1 -2 1 -3 -1 -1 0 -2 1 -2 0 -1 2 -2 2 -7 -1 -11 2 -9 -2 -9 0 -9 2 -10 2 -10 9 2 2 5 7 4 3 5 1 0 1 -3 5 6 1 7 4 -1 4 -2 2 2 6 2 8 4 2 3 3 -1 4 -5 3 -8 9 -1 5 -3 3 -7 3 -6 5 -5 4 -7 0 -10 -1 -9 z " />
						</a>
						<a id="naju" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=나주시&pageNum=1&petType=${param.petType}">
							<title>나주시</title>
							<path id="naju" class="OUTLINE" d="M 421 269 l 10 2 9 -1 11 0 5 3 5 4 4 5 2 6 -4 4 -1 3 6 3 12 0 3 3 0 0 5 -1 9 -6 5 -2 5 -4 12 0 3 3 1 6 -2 5 -1 5 -5 10 -3 4 -1 2 7 5 3 3 1 3 -3 4 -3 6 -2 10 -3 4 0 4 1 4 -1 5 1 4 0 2 0 1 1 3 -3 5 -5 2 -8 4 -8 4 -5 2 -2 0 -4 -4 -5 -4 -5 -6 -10 -1 -7 2 -7 -6 -1 -4 -4 -11 -3 -5 -6 -2 -6 0 -2 8 3 5 2 3 -1 2 1 2 1 6 -2 4 1 2 -3 0 -3 -3 -10 0 -5 -4 3 -1 -1 -6 -1 -3 0 -1 -2 -1 -4 -3 -6 -1 -4 5 -7 3 -1 9 -2 8 -7 3 -4 -7 -4 -4 -5 -6 -3 -5 -1 -5 6 -1 5 4 -2 -7 -2 -9 3 -11 2 -4 3 -3 9 2 1 3 5 -4 3 -5 3 -5 -2 -6 -3 -1 3 -5 -1 -9 0 -8 1 -9 4 -12 7 3 10 -3 4 -4 z " />
						</a>
						<a id="gwangyang" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=광양시&pageNum=1&petType=${param.petType}">
							<title>광양시</title>
							<path id="gwangyang" class="OUTLINE" d="M 888 358 l 1 5 11 3 7 7 -1 16 -7 -5 -2 -6 -4 1 -2 0 -3 -1 -1 0 -2 0 -10 -4 0 -8 7 -8 z M 848 243 l 4 2 7 6 4 4 4 4 2 9 2 8 4 5 4 5 7 4 3 5 7 5 5 3 1 6 4 7 2 10 -3 10 -8 10 -4 4 -4 1 -4 -5 -1 8 -4 3 -3 4 -5 5 -1 3 0 0 -3 2 -2 -3 0 1 -2 -2 -4 -1 -3 5 -3 4 1 1 3 4 -7 4 4 -4 -2 -1 -2 -1 -5 1 -2 0 -1 -1 -2 1 -5 -4 -2 -3 -4 -7 -1 -9 0 7 -2 6 -8 2 -1 -10 -4 -1 -4 -5 -4 -4 0 -2 1 -1 0 0 0 0 -1 -1 3 -5 -1 -4 -2 -1 2 -3 4 -7 -2 -11 -2 -6 -5 -5 -4 -5 -3 -5 0 -5 2 -4 3 -9 9 1 4 -6 7 -4 7 -2 3 -8 -1 -8 3 -8 3 -5 2 -4 4 4 z " />
						</a>
						<a id="damyang" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=담양군&pageNum=1&petType=${param.petType}">
							<title>담양군</title>
							<path id="damyang" class="OUTLINE" d="M 507 173 l 2 -9 1 -5 7 -2 -1 -11 3 -8 5 -4 4 -5 6 -3 2 -9 9 3 11 -2 1 -10 3 -4 5 -7 3 -5 1 -2 0 -3 5 -1 7 -2 3 -1 0 4 2 11 3 3 1 6 -1 9 -5 3 1 7 8 3 4 4 1 4 -1 3 0 1 1 5 0 4 -3 1 -3 -2 -2 6 -2 4 0 1 5 2 9 4 6 2 2 5 -1 11 1 7 -4 5 -1 4 3 6 2 6 3 9 4 4 1 2 -7 4 -8 2 -7 0 1 3 1 2 -1 1 1 3 4 8 4 9 1 2 -2 1 -4 4 -6 -1 -5 -3 -6 -2 -10 -2 -2 -8 3 -12 -2 -5 -9 -3 -10 0 -2 -8 -3 -4 -2 -7 -4 -7 -3 -4 -5 -5 -9 -1 -5 3 -5 1 -1 -6 -3 -5 -2 -4 z " />
						</a>
						<a id="gokseong" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=곡성군&pageNum=1&petType=${param.petType}">
							<title>곡성군</title>
							<path id="gokseong" class="OUTLINE" d="M 649 157 l 3 3 7 2 3 -5 6 -3 6 5 5 4 8 1 10 2 12 0 7 -4 9 0 10 4 0 7 1 10 3 8 2 5 1 6 -4 3 -5 4 -4 2 2 5 -1 0 0 5 1 4 4 4 10 2 1 9 0 10 -4 7 -5 5 -3 6 -3 7 -5 3 -9 1 -3 8 -4 5 -3 1 -2 -3 -8 -4 -6 -2 -2 -2 -4 2 -4 1 -1 -7 -5 -6 -1 3 -1 0 -3 -5 -7 -4 -2 -5 -9 -2 1 -10 -2 -8 2 -7 2 -3 -1 -2 0 -1 0 -1 -2 -6 -4 -5 -2 1 -6 5 -5 4 -1 0 -1 0 -4 1 -5 0 -3 -2 -3 2 -1 -2 -4 -4 -3 -9 -2 -6 -3 -6 1 -4 4 -5 -1 -7 1 -11 10 -3 4 -3 7 -2 4 -6 5 -3 z " />
						</a>
						<a id="gurye" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=구례군&pageNum=1&petType=${param.petType}">
							<title>구례군</title>
							<path id="gurye" class="OUTLINE" d="M 775 138 l 3 2 1 0 3 0 5 1 5 5 9 8 6 4 6 4 4 4 3 8 4 9 2 4 5 4 3 10 2 4 1 7 -1 9 2 12 -2 4 -3 5 -3 8 1 8 -3 8 -7 2 -7 4 -4 6 -9 -1 -2 -6 -4 -4 -3 -3 -2 0 -1 0 -5 -4 -5 -7 -5 -5 -5 -3 -5 -3 -6 -5 -5 -4 -8 -2 -10 -2 -4 -4 -1 -4 0 -5 1 0 -2 -5 4 -2 5 -4 4 -3 -1 -6 -2 -5 -3 -8 -1 -10 0 -7 6 -4 5 -7 3 -5 3 -6 6 -5 6 -1 z " />
						</a>
						<a id="goheung" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=고흥군&pageNum=1&petType=${param.petType}">
							<title>고흥군</title>
							<path id="goheung" class="OUTLINE" d="M 766 606 l 2 1 5 3 6 2 -1 2 6 -1 4 -3 -1 -1 4 3 3 5 6 5 0 8 -6 3 -5 2 -7 2 0 -6 -7 -4 -5 -3 -2 -1 6 0 4 -2 -5 -2 -7 -1 0 -2 0 0 -1 -5 z M 664 597 l 0 0 0 1 0 0 0 1 0 0 4 3 -2 8 -2 6 -1 4 -5 9 -7 0 -12 0 -9 2 -8 -3 -3 -3 -1 0 -1 0 -1 -1 1 -3 -6 -1 -1 -11 5 -3 2 -3 -1 -3 5 1 5 3 0 2 0 1 2 0 4 -3 8 -3 6 -3 3 -2 4 3 3 -1 3 -2 0 2 z M 718 421 l 4 3 5 4 6 5 4 6 0 9 8 0 -4 8 -5 4 -6 7 2 4 4 8 3 5 4 3 5 5 1 0 0 1 1 0 1 -1 2 5 6 4 1 1 1 -1 1 4 9 3 3 4 2 -1 0 2 4 3 -8 0 -4 0 2 4 2 1 0 0 4 1 6 2 3 11 2 7 1 2 -4 2 -5 6 -5 0 -6 -2 2 0 0 -1 -4 -3 -4 5 -4 0 -5 -3 -3 1 -1 0 -2 -2 -8 1 0 3 5 4 8 1 2 3 -3 -1 -1 0 0 1 0 0 -4 1 -4 -2 -2 1 0 2 4 2 7 0 -2 2 5 1 0 8 -1 9 -8 1 -3 6 -6 0 -2 10 -9 -1 -4 0 0 1 -5 2 -6 3 0 2 3 3 -5 2 4 3 0 1 -1 0 1 0 2 0 0 4 -7 2 -7 -3 4 -2 -1 -2 -1 0 0 -1 -5 -4 -4 -4 -6 -3 0 -6 2 1 -1 -6 -5 -5 -4 -3 -6 -2 1 -1 -1 0 1 2 -1 0 0 2 0 0 1 0 -4 -2 -5 -6 -2 -1 -6 5 -3 -2 -3 -3 -7 1 -3 3 -11 0 -4 0 0 0 -2 -2 -1 0 0 0 -1 -1 -2 1 -1 -6 -3 -3 0 -1 1 -2 -1 -1 1 -2 -1 -1 2 -2 4 -4 4 -2 -1 -2 3 -1 3 -7 8 0 3 -9 1 -8 2 -4 0 1 2 -1 4 -6 9 -4 6 -2 1 -4 4 -11 1 -6 4 -5 4 -4 7 -1 3 8 1 4 0 0 -2 6 2 7 7 0 7 -1 2 -7 3 -8 3 -5 2 -4 -4 -5 -1 -7 -3 -7 -7 0 -5 7 -7 0 -7 1 -6 -10 -7 -2 4 -6 3 -5 5 -5 6 -2 6 -6 5 -3 8 -2 5 -5 z " />
						</a>
						<a id="boseong" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=보성군&pageNum=1&petType=${param.petType}">
							<title>보성군</title>
							<path id="boseong" class="OUTLINE" d="M 651 338 l 4 1 2 5 4 8 3 2 0 0 1 2 2 7 2 10 -1 10 5 6 4 0 5 -2 0 1 1 0 0 0 5 -3 9 -3 8 4 4 4 3 -2 1 0 1 5 3 6 9 3 5 4 4 6 9 1 5 4 -12 2 -4 -3 -3 0 -2 0 -5 -1 -4 -2 3 3 5 2 7 4 5 5 6 0 6 2 -5 4 -4 3 -3 3 1 2 -3 -2 -4 -6 -6 -5 -5 -4 -4 -3 -8 2 -5 5 -8 2 -5 3 -6 6 -6 2 -5 5 -3 5 -4 6 -5 5 -4 8 -2 7 -3 4 -5 7 -8 3 -12 -1 -8 -3 -5 5 -2 6 -5 5 -7 2 -7 3 -4 8 -3 5 -1 0 -1 -5 -5 -9 -2 -6 -5 -3 -9 -1 -7 -2 -2 -8 1 -5 7 -6 4 -4 5 -4 1 -10 0 -6 1 -12 1 -10 1 -6 4 -4 2 -6 9 -4 3 -7 6 -4 5 -7 -2 -9 -1 -9 2 -8 6 -5 4 -3 3 -5 5 -6 7 1 12 -6 7 2 z " />
						</a>
						<a id="hwasun" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=화순군&pageNum=1&petType=${param.petType}">
							<title>화순군</title>
							<path id="hwasun" class="OUTLINE" d="M 648 216 l 4 5 2 6 0 1 0 1 1 2 -2 3 -2 7 2 8 -1 10 -2 10 -2 10 0 9 2 9 -2 9 1 11 -2 7 -2 2 0 1 -1 2 0 2 1 1 -1 3 1 2 -1 2 -2 3 -12 6 -7 -1 -5 6 -3 5 -4 3 -6 5 -2 8 1 9 2 9 -5 7 -6 4 -3 7 -9 4 -9 -1 -10 1 -9 -4 -8 3 -4 7 -5 -2 -5 -5 -5 -4 -2 -8 -3 -5 -5 -2 -9 2 -4 5 -4 -3 -2 -1 -3 1 -4 -1 -3 -1 8 -4 8 -4 5 -2 3 -5 -1 -3 0 -1 0 -2 -1 -4 1 -5 -1 -4 0 -4 3 -4 2 -10 3 -6 3 -4 -1 -3 -3 -3 -7 -5 1 -2 3 -4 5 -10 1 -5 2 -5 -1 -6 -3 -3 7 -3 4 -3 3 -1 4 6 9 2 5 -4 4 -4 7 -4 2 -6 6 -6 4 -7 10 2 6 2 5 3 6 1 4 -4 2 -1 -1 -2 -4 -9 -4 -8 -1 -3 1 -1 -1 -2 -1 -3 7 0 8 -2 7 -4 3 -2 3 2 5 0 4 -1 1 0 1 0 5 -4 6 -5 z " />
						</a>
						<a id="jangheung" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=장흥군&pageNum=1&petType=${param.petType}">
							<title>장흥군</title>
							<path id="jangheung" class="OUTLINE" d="M 518 394 l 5 2 3 5 2 8 5 4 5 5 5 2 4 -7 8 -3 9 4 10 -1 9 1 -2 6 -4 4 -1 6 -1 10 -1 12 0 6 -1 10 -5 4 -4 4 -7 6 -1 5 2 8 7 2 9 1 5 3 2 6 5 9 1 5 -2 0 0 0 -1 0 -4 2 -6 3 -12 0 -9 0 -6 -2 5 4 11 1 3 4 4 3 -3 2 -3 6 -3 7 -3 3 7 3 4 -1 0 0 0 2 -4 5 -4 7 -7 1 -5 5 1 1 1 2 -1 0 0 0 0 0 5 5 1 3 0 0 -2 0 -1 0 -1 6 3 8 1 6 -3 -2 -3 2 0 1 0 0 0 1 0 0 -3 -1 -4 -5 -4 2 1 2 2 5 2 4 -1 0 -2 1 -4 2 -11 -3 -4 0 -6 -1 -5 0 0 2 3 4 0 11 -3 -6 -2 -1 -2 1 -2 -3 -8 -2 5 -9 1 -4 0 -2 -2 -5 -2 -9 1 -7 4 -5 4 -4 7 -6 -1 -6 -1 -10 -2 -4 -3 -6 -5 -9 -1 -4 0 -1 5 -2 6 -2 -2 -4 0 -5 1 -1 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 -1 -1 0 1 -2 0 0 -3 -5 -4 -11 -2 -6 -1 -6 -1 -6 -6 -10 -3 -3 -2 -5 -3 -11 -1 -5 -2 1 -3 0 -4 -4 3 -10 2 -8 4 -5 5 -3 6 -2 6 -5 2 -7 4 -5 z " />
						</a>
						<a id="gangjin" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=강진군&pageNum=1&petType=${param.petType}">
							<title>강진군</title>
							<path id="gangjin" class="OUTLINE" d="M 470 443 l 7 -2 4 4 3 0 2 -1 1 4 3 12 2 5 3 3 6 10 1 6 1 6 2 6 4 11 3 5 0 0 -1 2 1 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 -1 1 0 5 2 4 -6 2 -5 2 0 1 1 4 5 9 3 6 2 4 1 10 1 6 -7 6 -4 4 -4 5 -1 7 2 9 2 5 0 2 -1 4 -5 9 -9 -2 -4 -3 0 0 0 0 -1 0 -1 1 -2 -6 -7 -3 0 -3 4 -4 -1 -9 -1 -6 -1 -1 1 -4 0 -7 2 -11 0 -7 -3 -5 1 -1 0 -3 -4 -4 0 -7 1 -10 0 -5 -2 4 -3 8 -1 10 -1 14 0 6 -1 3 0 0 0 2 0 1 1 1 -1 1 0 2 0 2 2 2 1 1 -2 0 -2 0 -2 3 2 9 1 2 -4 3 -5 2 0 0 0 0 -2 3 3 4 2 2 1 0 -1 1 -9 7 -7 -6 -13 -1 -1 -6 1 -7 0 -10 -1 -8 -4 -3 3 -4 5 -6 -1 -8 -4 -7 -3 -6 2 -3 4 -4 3 -7 3 -5 -5 0 1 -6 2 -9 3 -3 -1 -3 0 -1 1 -4 -6 -3 -6 -1 -2 -4 2 -7 3 -4 -5 -4 -3 -5 5 -7 5 -4 5 -4 4 -2 4 2 1 0 1 0 5 2 7 0 5 -6 3 -5 z " />
						</a>
						<a id="haenam" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=해남군&pageNum=1&petType=${param.petType}">
							<title>해남군</title>
							<path id="haenam" class="OUTLINE" d="M 270 460 l 3 5 1 -1 1 0 0 4 5 8 4 6 0 1 -1 1 5 3 5 -5 0 0 4 -5 4 -7 -1 8 5 2 2 3 1 0 2 4 1 7 3 -1 2 -1 2 1 1 -5 7 -1 2 10 -5 5 -1 0 0 -1 -1 1 -1 -1 0 3 6 5 4 3 1 0 0 -1 5 4 10 3 6 2 5 3 5 2 -2 -6 -3 -4 -5 -5 -6 -2 -6 -4 0 -7 3 3 4 4 7 3 11 2 5 2 4 3 8 4 8 3 3 0 9 1 -9 -2 -10 -3 -7 -4 -2 -8 4 -5 5 -3 10 -1 10 1 7 0 5 -5 8 -3 2 4 6 1 6 3 -1 4 0 1 1 3 -3 3 -2 9 -1 6 5 0 -3 5 -3 7 -4 4 -2 3 3 6 4 7 1 8 -5 6 -3 4 4 3 1 8 0 10 -1 7 1 6 13 1 7 6 -2 7 -7 2 -6 1 -5 4 -4 4 -1 4 -4 -4 -3 1 0 1 -3 -1 0 2 -2 0 -1 3 -7 6 0 2 -7 6 0 3 2 4 -1 5 1 -1 0 3 -1 1 0 1 -5 3 0 5 -1 11 -8 -1 -12 1 -3 4 -7 5 -6 0 -1 -10 3 -8 -1 -10 -5 -6 -3 0 -5 4 -8 3 -3 -6 0 0 1 0 3 3 1 -3 1 1 1 -1 1 0 1 1 0 -1 -4 -6 0 -5 3 -1 -1 -1 4 -1 1 -8 8 -3 0 -9 -1 -6 -4 1 -2 2 -3 -1 -2 1 -1 2 1 2 -2 -1 -6 -7 -3 -4 2 -2 0 -1 4 3 -1 -6 -1 -6 -2 1 -1 -1 -1 -4 4 -3 -3 -3 0 0 1 -3 -2 -2 4 -3 -2 -7 -3 -2 -2 -3 4 -2 -6 -3 -4 0 1 -1 0 -1 0 0 -1 0 -3 -5 -6 -4 1 4 -6 2 -3 5 -6 0 1 -8 -4 -5 -1 1 -2 -1 -1 1 -1 -1 -1 1 -2 -3 -9 -3 -9 0 -5 -1 1 -2 0 -1 0 0 -1 0 0 0 0 1 0 -1 2 -4 -2 -2 1 0 -3 -1 -2 -4 -3 3 -2 -1 -1 0 0 0 0 -3 2 -2 -3 -3 1 -4 3 -4 0 -4 -2 1 -2 0 -4 -2 -4 -5 2 -1 -1 -4 -1 -1 1 -1 -2 -3 0 -7 2 -5 0 -1 -1 -4 0 -5 1 -1 -1 0 1 0 -1 0 1 0 2 2 3 -5 1 -9 2 -6 2 -6 4 -4 z M 279 488 l 1 10 3 4 3 5 2 9 4 8 4 5 4 2 8 4 5 3 5 3 9 4 6 -4 5 -3 3 -5 1 -4 -3 1 -4 1 -1 -1 -1 1 -4 2 -1 -8 -2 -5 -3 3 -2 0 -4 -8 -3 -8 -2 -1 0 -1 0 -1 1 -1 -6 3 -5 4 -2 2 -3 -4 -1 -11 3 7 1 -3 1 1 1 0 0 0 0 0 0 0 0 -1 1 -5 -1 -3 1 0 0 -1 -2 -4 3 3 2 1 0 -5 -2 -4 -1 0 0 -1 -4 -1 -7 6 2 2 -1 3 -4 3 -7 -1 0 -4 2 -3 z " />
						</a>
						<a id="yeongam" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=영암군&pageNum=1&petType=${param.petType}">
							<title>영암군</title>
							<path id="yeongam" class="OUTLINE" d="M 292 460 l 4 -3 0 -7 11 -3 7 -2 3 -9 11 6 3 3 0 -1 0 0 0 -1 1 -1 -3 -2 6 -2 8 6 4 5 8 -1 3 -9 1 -5 5 -3 5 -6 1 -5 2 -8 1 -10 1 -8 7 -3 2 -8 1 -9 7 -3 4 -5 6 1 4 3 2 1 0 1 1 3 1 5 -3 2 5 4 10 0 3 3 3 0 -1 -2 2 -4 -1 -6 -1 -2 1 -2 -2 -3 -3 -5 2 -8 6 0 6 2 3 5 4 11 1 4 7 6 7 -2 10 1 5 6 5 4 4 4 2 0 5 -2 3 1 4 1 3 -1 2 1 4 3 -2 7 -6 5 -6 2 -5 3 -4 5 -2 8 -3 10 -7 2 -5 2 -3 5 -5 6 -7 0 -5 -2 -1 0 -1 0 -4 -2 -4 2 -5 4 -5 4 -5 7 3 5 5 4 -3 4 -2 7 -8 3 -5 5 -7 0 -10 -1 -10 1 -5 3 -4 5 1 -8 -7 3 -8 6 0 -5 -6 -3 1 -6 5 0 0 0 -5 -2 -6 -5 -2 -3 4 -2 -5 0 -8 -4 2 -6 1 -4 -6 0 -6 1 -2 -4 -4 2 -4 0 -3 -3 -6 -1 -5 4 -4 5 -9 -6 z " />
						</a>
						<a id="muan" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=무안군&pageNum=1&petType=${param.petType}">
							<title>무안군</title>
							<path id="muan" class="OUTLINE" d="M 332 428 l -2 -1 -4 -5 -3 -8 -5 -3 -9 -2 -1 -7 -3 -9 -7 -1 5 -4 0 -1 -1 -1 3 -5 2 -9 -4 -5 -1 -2 1 0 -1 0 3 -3 -2 -3 -1 -3 1 -5 1 -5 -4 -3 -2 -8 -3 -6 -2 1 0 1 0 0 0 2 0 0 0 3 1 3 0 2 -4 4 5 3 0 5 -3 3 3 2 -1 2 -2 3 2 4 -1 2 -1 0 -4 -1 -3 2 -5 1 -4 -6 -8 0 1 -11 -3 -5 -6 -4 4 -6 5 -1 4 3 6 1 5 -2 4 -6 -2 -4 -5 -1 -2 2 2 -3 7 -5 5 -2 4 -4 6 -4 0 -4 -1 -4 -3 -4 -2 2 -2 -1 -1 0 -5 2 -3 -6 -6 -4 3 -2 1 -3 -2 -3 -4 -6 -6 1 -2 8 -5 4 0 1 0 0 -1 0 4 4 -2 5 -2 1 1 -1 0 -2 -6 -5 -10 2 -2 -7 -5 -4 -1 -12 7 0 0 -3 -8 -5 3 -8 4 -3 4 -6 5 3 2 2 4 -2 5 1 2 3 6 0 3 -8 5 -4 2 -1 0 1 0 0 -1 5 0 6 -2 5 -3 8 1 7 6 2 -3 4 0 2 4 2 6 0 -1 1 1 3 0 2 0 1 3 0 3 -5 3 -5 2 -1 0 2 -2 5 1 3 1 1 3 -3 2 7 -3 9 4 6 2 0 5 0 0 -5 2 -6 7 -4 3 -10 6 3 5 3 2 1 -3 5 -3 8 2 7 7 3 6 3 -1 2 0 1 1 1 -3 2 1 5 1 1 0 0 6 3 7 3 4 5 -3 11 2 9 1 7 -4 -4 -6 1 1 5 3 5 5 6 4 4 4 7 -1 8 -1 10 -2 8 -1 5 -5 6 -5 3 -1 5 -3 9 -8 1 -4 -5 -8 -6 z " />
						</a>
						<a id="hampyeong" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=함평군&pageNum=1&petType=${param.petType}">
							<title>함평군</title>
							<path id="hampyeong" class="OUTLINE" d="M 297 238 l 5 -3 5 -2 5 -3 0 -1 5 1 6 5 1 1 4 -4 7 -4 5 -2 2 -1 2 1 1 0 2 2 9 2 8 0 10 -1 6 -2 4 -4 5 -4 2 -7 0 -10 9 4 4 5 4 4 5 4 4 5 4 2 4 10 1 1 -4 3 -5 8 -2 3 3 2 0 6 3 10 -5 4 -4 4 -10 3 -7 -3 -4 12 -1 9 0 8 1 9 -3 5 3 1 2 6 -3 5 -3 5 -5 4 -1 -3 -9 -2 -3 3 -2 4 -4 -5 -7 -3 -6 -3 0 0 -1 -1 -1 -5 3 -2 -1 -1 0 -1 1 -2 -6 -3 -7 -3 -2 -7 3 -8 3 -5 -2 -1 -5 -3 -6 -3 -2 -6 8 -4 -1 -4 -7 -2 -9 -2 -5 -7 -3 -5 -1 -3 -2 1 -3 -3 -3 -5 z " />
						</a>
						<a id="yeonggwang" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=영광군&pageNum=1&petType=${param.petType}">
							<title>영광군</title>
							<path id="yeonggwang" class="OUTLINE" d="M 329 101 l 5 1 5 1 2 -1 1 0 4 5 3 10 -3 4 0 0 0 4 5 5 0 5 -1 5 0 2 2 0 4 -4 3 3 2 5 -1 5 -1 3 3 3 2 5 11 1 9 2 4 3 0 0 0 1 1 0 1 -5 -2 -3 0 -1 0 -1 0 -1 4 -4 11 1 10 2 0 6 -9 5 -2 5 -2 11 -4 2 -6 6 1 10 0 10 -2 7 -5 4 -4 4 -6 2 -10 1 -8 0 -9 -2 -2 -2 -1 0 -2 -1 -2 1 -5 2 -7 4 -4 4 -1 -1 -6 -5 -5 -1 0 1 -5 3 -5 2 -5 3 -6 -1 0 -7 5 -2 0 -6 2 -7 -4 3 -5 4 -7 0 2 -5 0 -2 -2 -1 -2 4 -8 0 -2 -5 -3 -11 4 -7 3 2 3 2 5 -4 3 1 -2 -4 1 -2 -5 3 1 -8 4 0 -1 -1 3 -2 -6 1 2 -6 6 -1 8 -1 2 -7 2 2 -1 -7 2 -9 2 -4 0 0 0 0 0 -1 0 0 1 -4 5 -11 3 2 0 0 5 0 9 3 1 7 4 -1 0 -3 -6 -6 -6 -4 -3 -5 -4 -5 1 0 -1 -3 -1 -1 2 -2 -1 -2 1 0 -2 -1 1 -1 3 -5 5 -6 2 1 z " />
						</a>
						<a id="jangseong" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=장성군&pageNum=1&petType=${param.petType}">
							<title>장성군</title>
							<path id="jangseong" class="OUTLINE" d="M 391 202 l -1 -10 6 -6 4 -2 2 -11 2 -5 9 -5 0 -6 7 -4 2 -6 9 -2 8 -2 3 -6 7 -3 4 -7 -2 -9 6 -4 4 -6 -1 -11 -1 -8 6 -5 6 -2 8 -1 9 -2 3 -7 4 1 5 5 0 7 3 -1 2 -1 4 2 6 2 8 5 3 7 3 9 3 2 4 7 -2 9 -6 3 -4 5 -5 4 -3 8 1 11 -7 2 -1 5 -2 9 3 10 2 4 3 5 1 6 -9 4 -6 3 -4 2 -4 0 0 0 -5 4 -9 0 -6 -2 -4 -3 -6 -4 2 -4 1 -4 -8 1 -4 1 -2 5 -5 11 -3 4 -6 1 -2 -1 -2 -1 -4 5 -2 7 -2 -1 0 0 -2 0 -2 0 -1 0 -4 -2 -4 -5 -5 -4 -4 -4 -4 -5 z " />
						</a>
						<a id="wando" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=완도군&pageNum=1&petType=${param.petType}">
							<title>완도군</title>
							<path id="wando" class="OUTLINE" d="M 384 771 l -5 6 0 1 0 0 -5 4 -6 4 -4 2 -8 1 -5 -2 1 0 0 0 1 0 -1 -1 -3 -5 1 -3 0 -1 -1 0 2 -3 -2 -3 2 -2 5 -4 4 -2 0 0 3 -2 10 4 5 4 1 0 5 -3 6 1 2 1 0 0 0 0 1 0 2 1 4 3 -6 1 -1 5 -3 -5 z M 415 751 l 5 3 6 5 1 1 -6 3 -6 3 1 3 3 4 2 5 0 -1 1 1 1 -1 3 1 -4 2 -3 11 -2 5 -1 1 0 -1 1 0 -4 -5 -2 -5 -1 1 0 0 0 0 0 0 -2 1 -2 1 -2 -8 1 -6 3 -4 2 -3 1 0 0 -5 -5 -3 2 -1 0 -1 -2 -1 z M 519 743 l 5 3 2 9 0 4 3 -1 2 0 1 5 -2 4 -3 5 -6 1 0 0 -6 2 -6 -6 -1 -1 -2 2 -4 3 0 -2 0 0 0 0 -1 -1 1 -2 1 -2 -2 -3 2 -1 -1 -2 0 -2 2 -5 6 -7 z M 377 735 l 6 1 10 2 3 3 4 5 -1 4 -4 3 3 5 0 0 -2 1 -2 -1 -2 1 -3 -3 -4 0 -2 6 -8 -1 -2 -5 -5 -2 2 -3 1 -2 1 0 1 -5 z M 496 670 l 4 4 1 -2 2 -1 1 3 4 -2 4 1 0 1 -1 0 1 1 0 0 4 2 5 -1 -4 4 -3 5 0 7 -3 0 -2 -4 -4 4 -1 0 -1 1 -5 2 -3 -5 -6 -6 -3 -2 -1 1 -7 3 -9 -3 -3 -1 -5 -3 9 -2 8 1 9 -2 2 -6 z M 414 681 l -1 2 -1 -1 -2 1 2 -5 -1 -9 -2 -10 3 -9 8 -4 2 -2 1 0 0 0 2 1 1 0 2 -1 5 1 7 4 6 4 2 6 1 8 4 11 2 3 0 1 0 0 0 0 0 0 3 5 7 3 0 3 -2 4 2 3 1 3 -3 -1 -2 -1 -2 1 -2 -1 -1 1 -1 -1 -4 -4 -2 6 -3 -2 -6 -2 -9 -1 -5 -3 1 -1 -5 -7 -5 -5 0 0 0 0 -1 0 -1 1 z M 544 641 l -2 8 -3 4 -1 1 1 0 1 0 2 4 -6 4 -4 3 -6 3 -6 -1 1 0 -2 -1 -3 -3 -8 -5 2 -10 -1 -6 1 2 1 0 0 1 1 1 0 -1 1 0 2 -2 5 3 0 -2 2 0 1 1 2 -1 3 4 8 0 4 -4 1 -1 -1 -2 z M 495 624 l 1 7 -1 4 -2 -1 -3 -1 1 3 8 3 5 3 1 2 0 0 1 4 -7 3 -6 3 -1 1 1 0 -2 0 -3 -2 -1 1 -1 0 -1 0 -1 0 -3 -1 -3 1 0 0 -3 1 -4 6 -3 7 -4 -1 0 0 0 -2 0 -2 3 -5 -2 -4 -1 0 -1 0 -3 0 -2 1 2 -5 5 -5 0 -1 -1 -2 2 -4 4 -6 8 -4 8 -1 3 -3 z " />
						</a>
						<a id="jindo" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=진도군&pageNum=1&petType=${param.petType}">
							<title>진도군</title>
							<path id="jindo" class="OUTLINE" d="M 242 545 l 7 0 5 4 2 0 2 1 3 2 4 3 -1 4 0 0 -1 0 0 2 3 4 6 4 1 -2 5 -1 4 5 2 2 -1 3 3 0 4 5 5 4 1 2 1 0 -2 3 -2 1 2 3 1 5 -7 3 -1 9 0 9 -4 6 -3 5 -2 4 -1 0 -2 3 -5 2 -2 -7 -3 6 -5 0 -4 6 -2 1 0 0 -4 0 -3 -2 -1 1 -1 -1 -1 0 -2 4 3 3 -1 2 1 0 0 1 -1 0 -4 -1 -2 1 -2 -1 -1 0 -1 1 0 0 -4 2 -10 2 -5 1 3 0 -1 5 -8 1 -7 1 -6 -2 0 -1 2 -2 -4 0 -4 3 -2 -1 -2 -2 2 -1 -2 -1 2 -1 -1 -2 2 -2 2 0 0 0 0 0 0 0 0 -2 -9 0 -4 -1 0 -1 -1 -4 -4 -6 -4 -5 -1 -1 1 -1 -1 -1 2 -1 -2 -1 2 -2 1 -3 0 0 0 0 1 1 2 -5 5 -5 1 0 3 2 -1 -6 6 -5 4 -4 8 -5 4 -1 0 0 1 -3 3 -6 4 -3 1 6 5 0 -1 -4 -1 -2 5 -3 5 -2 -1 -1 -2 -3 4 -4 1 -4 2 3 5 -5 1 -3 1 -7 -3 -2 1 -3 -1 -1 1 -1 1 -2 -2 -1 z " />
						</a>
						<a id="sinan" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=신안군&pageNum=1&petType=${param.petType}">
							<title>신안군</title>
							<path id="sinan" class="OUTLINE" d="M 222 269 l 5 3 -1 -1 5 0 5 3 0 0 3 -1 2 2 1 12 5 4 2 7 2 9 -2 7 -6 3 -4 -6 -1 4 -4 0 0 -9 2 -3 -5 -6 -7 1 -1 6 -2 -7 -3 -5 -1 2 -3 0 0 -1 0 0 -4 -3 -5 -3 3 -4 -5 -5 1 -5 0 1 2 -2 6 -3 z M 171 377 l -1 2 -1 1 5 4 -1 6 -4 -1 -2 -1 1 5 2 3 -4 1 -4 3 -6 2 -3 5 -1 0 0 0 0 -1 -1 1 0 -1 -5 -5 -3 -7 -3 2 -4 2 -3 -2 -3 0 0 1 -5 -2 -3 -3 0 0 -2 -1 5 -1 6 -5 4 -3 4 -9 7 -1 3 -4 2 0 3 3 5 -3 1 -1 0 0 0 0 -1 -3 1 -2 -1 -2 0 -2 1 1 0 0 1 1 2 -1 3 5 6 4 -2 1 -1 1 z M 264 368 l 0 1 0 0 1 0 2 2 2 2 9 2 4 4 3 4 -7 1 -3 5 -4 1 3 3 -3 2 0 4 8 0 5 -1 -1 1 6 2 4 5 0 0 0 0 1 2 -2 3 2 3 -2 2 -4 6 -11 1 4 -8 3 -1 -4 -4 -3 -4 -6 0 -1 1 -2 -2 -8 -1 -8 0 -1 3 -1 0 -2 2 -7 0 -4 -3 -4 -4 7 -1 7 0 3 -6 3 3 3 0 0 -3 -2 -3 1 -4 0 -1 0 -1 2 0 4 2 3 -1 1 -2 -2 -4 -5 -8 z M 171 444 l 5 3 9 1 5 5 1 1 0 0 4 1 2 -1 4 -1 4 5 3 4 2 8 -1 7 -2 5 0 1 1 0 -3 0 -5 -1 -2 1 -1 0 -1 -6 -4 -7 -6 1 -3 4 -3 -2 0 0 0 -1 -1 0 0 0 -1 0 -1 1 -1 0 -2 0 0 0 -4 1 -4 3 0 -4 1 0 -2 -5 0 -9 -1 -10 6 -2 z M 131 428 l 0 1 0 1 1 3 0 3 -3 4 -2 5 1 0 2 0 1 0 1 -1 0 3 -1 3 0 1 -3 0 -6 3 -3 -2 -4 3 0 -5 -3 -2 1 4 0 2 -1 0 -2 -1 -5 2 -2 0 0 -1 0 0 -1 0 0 2 4 4 3 5 -3 -1 -1 5 -4 3 -3 1 -1 0 -1 1 -2 -1 -5 -5 -5 -4 0 0 -1 -2 2 -5 1 -8 4 -7 8 0 10 -1 4 -3 0 -1 3 0 4 -5 3 -3 0 0 z M 116 463 l 3 6 3 5 1 0 2 -2 4 6 7 4 -1 6 -5 4 -5 4 -4 4 1 1 0 0 -4 3 -7 0 0 -3 2 -2 -6 0 -4 -1 0 -2 -4 -2 -3 -6 2 -11 7 -2 4 -4 5 -6 z M 201 250 l -8 4 -4 1 -2 4 -1 10 0 11 -2 8 -1 6 -4 2 1 2 -6 0 -6 -4 -5 -4 -2 4 -1 1 0 -2 0 -1 -2 -1 -2 2 -1 -4 2 -6 0 0 -1 -5 2 -5 0 1 -1 -2 7 -2 8 -3 4 -5 6 -5 4 -6 8 0 4 -1 0 0 z M 184 388 l 3 1 7 2 6 4 0 4 -6 2 4 6 0 1 -3 4 -2 5 -3 -2 -4 -1 -2 8 -1 7 -4 2 0 0 -5 -1 -2 -7 -6 -3 -2 -7 -5 -6 0 -2 7 -3 8 -1 9 1 -2 -11 z M 156 520 l 0 1 0 0 2 0 7 4 4 6 5 4 3 6 2 1 -4 4 -2 8 0 6 -8 4 -5 4 0 1 -2 -1 -4 3 -9 0 0 -4 2 2 1 -1 0 0 0 0 2 1 1 -2 -1 -1 1 -1 -1 -1 5 -2 0 -3 -1 0 0 0 -2 0 -2 0 -2 -1 -4 2 2 -4 8 0 8 -5 2 -8 -3 -6 -1 -2 0 -1 -1 -3 -3 -1 -3 1 0 -1 -1 1 -1 -1 1 1 0 -5 z M 195 313 l 8 3 3 7 5 5 0 8 -3 5 -5 1 -7 4 0 4 -1 -1 -2 2 -5 1 1 -1 2 -5 1 -13 1 -3 2 2 -2 -5 -10 0 -5 -3 2 -2 4 -4 5 -4 -1 -1 3 -1 1 -1 z M 201 500 l 5 3 2 2 -1 1 3 2 2 7 6 2 -1 2 0 0 -3 1 -2 1 -1 0 -2 2 -6 0 -8 3 -9 -1 1 -7 2 -3 -5 -2 1 -5 7 -4 4 -4 z " />
						</a>
						
					<!-- </g> -->
					
						<%-- line 
						<a id="sinan" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=신안군&pageNum=1&petType=${param.petType}">
							<title>신안군</title>
							<path class="LINE" d="M 231 288 l -8 100 " />
							<path class="LINE" d="M 265 396 l -42 -8 " />
							<path class="LINE" d="M 205 329 l 18 59 " />
							<path class="LINE" d="M 176 280 l 47 108 " />
							<path class="LINE" d="M 152 385 l 71 3 " />
							<path class="LINE" d="M 188 396 l 35 -8 " />
							<path class="LINE" d="M 186 463 l 37 -75 " />
							<path class="LINE" d="M 200 513 l 23 -125 " />
							<path class="LINE" d="M 105 449 l 118 -61 " />
							<path class="LINE" d="M 117 484 l 106 -96 " />
							<path class="LINE" d="M 169 540 l 54 -152 " />
						</a>
						<a id="wando" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=완도군&pageNum=1&petType=${param.petType}">
							<title>완도군</title>
							<path class="LINE" d="M 482 645 l -16 73 " />
							<path class="LINE" d="M 436 677 l 30 41 " />
							<path class="LINE" d="M 503 684 l -37 34 " />
							<path class="LINE" d="M 523 655 l -57 63 " />
							<path class="LINE" d="M 515 760 l -49 -42 " />
							<path class="LINE" d="M 416 760 l 50 -42 " />
							<path class="LINE" d="M 386 746 l 80 -28 " />
							<path class="LINE" d="M 368 774 l 98 -56 " /> 
						</a>
						<a id="yeosu" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=여수시&pageNum=1&petType=${param.petType}">
							<title>여수시</title>
							<path class="LINE" d="M 844 445 l 14 71 " />
							<path class="LINE" d="M 901 522 l -43 -6 " />
							<path class="LINE" d="M 895 578 l -37 -62 " />
						</a>
						--%>
					
						<text id="LCD46110" class="TEXT" x="315" y="420">
							<a id="mokpo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=목포시&pageNum=1&petType=${param.petType}">
								목포시
							</a>	
						</text>
						<text id="LCD46130" class="TEXT" x="858" y="450">
							<a id="yeosu" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=여수시&pageNum=1&petType=${param.petType}">
								여수시
							</a>	
						</text>
						<text id="LCD46150" class="TEXT" x="737" y="332">
							<a id="suncheon" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=순천시&pageNum=1&petType=${param.petType}">
								순천시
							</a>	
						</text>
						<text id="LCD46170" class="TEXT" x="446" y="334">
							<a id="naju" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=나주시&pageNum=1&petType=${param.petType}">
								나주시
							</a>	
						</text>
						<text id="LCD46230" class="TEXT" x="852" y="318">
							<a id="gwangyang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=광양시&pageNum=1&petType=${param.petType}">
								광양시
							</a>	
						</text>
						<text id="LCD46710" class="TEXT" x="560" y="180">
							<a id="damyang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=담양군&pageNum=1&petType=${param.petType}">
								담양군
							</a>	
						</text>
						<text id="LCD46720" class="TEXT" x="682" y="215">
							<a id="damyang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=곡성군&pageNum=1&petType=${param.petType}">
								곡성군
							</a>	
						</text>
						<text id="LCD46730" class="TEXT" x="786" y="205">
							<a id="gurye" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=구례군&pageNum=1&petType=${param.petType}">
								구례군
							</a>	
						</text>
						<text id="LCD46770" class="TEXT" x="708" y="554">
							<a id="goheung" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=고흥군&pageNum=1&petType=${param.petType}">
								고흥군
							</a>	
						</text>
						<text id="LCD46780" class="TEXT" x="638" y="427">
							<a id="boseong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=보성군&pageNum=1&petType=${param.petType}">
								보성군
							</a>	
						</text>
						<text id="LCD46790" class="TEXT" x="582" y="325">
							<a id="hwasun" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=화순군&pageNum=1&petType=${param.petType}">
								화순군
							</a>	
						</text>
						<text id="LCD46800" class="TEXT" x="533" y="499">
							<a id="jangheung" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=장흥군&pageNum=1&petType=${param.petType}">
								장흥군
							</a>	
						</text>
						<text id="LCD46810" class="TEXT" x="469" y="497">
							<a id="gangjin" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=강진군&pageNum=1&petType=${param.petType}">
								강진군
							</a>	
						</text>
						<text id="LCD46820" class="TEXT" x="379" y="570">
							<a id="haenam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=해남군&pageNum=1&petType=${param.petType}">
								해남군
							</a>	
						</text>
						<text id="LCD46830" class="TEXT" x="407" y="434">
							<a id="yeongam" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=영암군&pageNum=1&petType=${param.petType}">
								영암군
							</a>	
						</text>
						<text id="LCD46840" class="TEXT" x="330" y="372">
							<a id="muan" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=무안군&pageNum=1&petType=${param.petType}">
								무안군
							</a>	
						</text>
						<text id="LCD46860" class="TEXT" x="367" y="268">
							<a id="hampyeong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=함평군&pageNum=1&petType=${param.petType}">
								함평군
							</a>	
						</text>
						<text id="LCD46870" class="TEXT" x="332" y="190">
							<a id="yeonggwang" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=영광군&pageNum=1&petType=${param.petType}">
								영광군
							</a>	
						</text>
						<text id="LCD46880" class="TEXT" x="469" y="165">
							<a id="jangseong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=장성군&pageNum=1&petType=${param.petType}">
								장성군
							</a>	
						</text>
						<text id="LCD46890" class="TEXT" x="466" y="730">
							<a id="wando" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=완도군&pageNum=1&petType=${param.petType}">
								완도군
							</a>	
						</text>
						<text id="LCD46900" class="TEXT" x="238" y="617">
							<a id="jindo" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=진도군&pageNum=1&petType=${param.petType}">
								진도군
							</a>	
						</text>
						<text id="LCD46910" class="TEXT" x="223" y="388">
							<a id="sinan" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=전라남도&siguSel=신안군&pageNum=1&petType=${param.petType}">
								신안군
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