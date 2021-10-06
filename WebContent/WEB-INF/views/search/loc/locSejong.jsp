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
	<title>** 세종특별자치시 **</title>
	
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
			fill: rgba(247, 225, 0, 0.5);
		}
		
		.mapdiv path:hover {
			fill: #f7e100;
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
		    stroke-width: 1.2px;
		}
		.TEXT {
		    fill: #000000;
		    font-size: 0.8em;
		    /* font-weight: bold; */
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
										<a class="dropdown-item" href="/petBill/search/loc/locSejong.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    	<a class="dropdown-item" href="/petBill/search/loc/locSejong.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
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
							<h2 id="text"><span>Do not buy a pet and adopt it prudently</span><br>세 종 특 별 자 치 시</h2>
						</section>
					</div>
					
					
					<div class="mapdiv" id="region">
						
						<?xml version="1.0" encoding="utf-8"?>
					    <!-- Generator: Adobe Illustrator 22.0.1, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
					    
					    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 10 500 410" >
					    
						<defs>
						    <filter id="dropshadow">
						        <feGaussianBlur in="SourceAlpha" stdDeviation="3" />
						        <feOffset dx="1" dy="1" result="offsetblur" />
						        <feMerge>
						            <feMergeNode />
						            <feMergeNode in="SourceGraphic" />
						        </feMerge>
						    </filter>
						</defs> 
						
						<!-- <g filter="url(#dropshadow)"> -->  
					        
			            <a id="sejong" href="/petBill/search/searchResult.pet?sidoSel=세종특별자치시&siguSel=세종특별자치시&pageNum=1&petType=${param.petType}">
							<title>세종특별자치시</title>
			            	<path class="OUTLINE" d="M160.4,25.5c-4.3,1.9-5.7,3.9-5.9,7.1s-0.7,8.2-3.8,10.2S143,47,141,48.6s-4.3,3.4-5.5,4.2
								c-1.2,0.7-3.2,3.2,0.2,4.5s5.2,0.7,5.9,3.1c0.7,2.3,1.2,3.3,2.3,4.3s2,4.5,2.6,6.7s1.3,5,1.2,6.1s1.1,1.7,2.6,0.5s2.2-1,3.8-0.7
								c1.6,0.2,2.2,0.1,3.7-1.1s4.3-4,6.1-2.8s0.6,2.6,1,4.7s1.6,3.8,2.1,5.2c0.5,1.3,0.2,3.4,0.6,5.1c0.4,1.7,1.2,4.8-0.7,6.5
								s-3.7,3.9-4.9,6.7c-1.2,2.8-3.2,6.5-0.6,8.4c2.6,1.8,4.3,6.5,3.6,7.1c-0.8,0.6-4.4,4.5-5.4,5.3c-1,0.7-1.8,2.3-1.6,5.2
								c0.3,2.8-0.7,4.4,0.9,6.4c1.6,2,2.6,2.9,2.5,4.8c-0.1,1.9,0.1,3,1.1,3.9c1,1,0.7,0.4,0.1,2.9c-0.6,2.6-2.6,6-1.1,7.1
								s3.1,1.6,2.7,2.8c-0.4,1.2-2.5,1.8-3.7,1.5c-1.2-0.4-2.8,0.8-3.3,2.2c-0.5,1.5-2.3,3.7-0.6,4.7c1.8,1,4,1.5,4.1,4.2
								s-0.7,9.3,3.1,10.8s6.5,2.1,9.2,5.5c2.7,3.5,3.9,5.9,5.6,6c1.7,0.1,3.2-2,5.4-0.5s1.8,5.8,4.3,5.8s2.2-4.7,4.3-3.6
								c2.1,1.1,1.9,5.1,1.3,8c-0.6,2.9,1,6.8,3.2,7.9c2.2,1.1,3.4-1.2,5.8-1.2c2.3,0,6.1,0.8,7.2,2.3c1.1,1.5,1.6,2.7,1.6,2.7
								s-2.8,3.1-3.4,4.2c-0.6,1.1-1.1,0.7-1,2.9s-1.1,6.4-3.2,6.9c-2.1,0.5-2.7,0.1-4.3,0.6s-3.2,1.6-3.6,3.4c-0.4,1.9-1.9,6.5-2.2,7.9
								c-0.2,1.4-1,2-1.8,2.8c-0.8,0.9-1.7,2.2-0.8,3.3c0.8,1.1,4,4.7,2.9,4.9c-1.1,0.3-2.3,0.3-2.9,1.6c-0.6,1.3-2.5,2.2-3.1,1
								s-3.2-1.9-4.3-1c-1.1,1-5,3.1-4.8,5.1c0.2,2.1-0.1,4-1,4.7c-0.8,0.6-1,2.6,0,4.4s4.2,7,5.3,8.6s3.9,4.4,1.6,6.4
								c-2.3,2-6.4,7-7.5,8.1s-1.8,4.7-0.1,5.5c1.7,0.9,4.3,3.2,5,4.7c0.8,1.5,1.1,2.3-0.3,3.2c-1.5,0.9-3.8,4.5-1.7,7.6s4.3,3,6.1,2.2
								c1.9-0.7,2.9-1.5,6.5,0.2s7.7,3.5,7.4,6.2c-0.4,2.8-1.1,5-2.5,6.1s-1.7,5.4-0.5,8.7c1.2,3.3,4.7,9.7,6.9,9.1s5,0.1,5.8,4.9
								c0.7,4.8,0,7.7-2.2,8.7s-2.8,3.4-1.6,4.8c1.2,1.3,1.3,3,1.2,5.3c-0.1,2.2-0.2,4.2-0.6,5.2c-0.4,1,0.9,5,4.3,5.5
								c3.4,0.5,10.1,0.2,14,4.2c3.9,3.9,6,5.3,6.3,7s0.3,4.4,1.7,4.9c1.5,0.5,2.3-1.7,3.7-0.5s1.5,2.8,3.3,3.5c1.9,0.7,6.6-0.5,7.5,0.7
								s-0.3,2.7,1.5,3.8c1.7,1.1,2.8,1.6,4.4,4.1c1.6,2.5,3.1,6.1,4.6,5.5s1.1-2.1,3.2-1.7s3.8-0.9,3.5-2.4c-0.2-1.6-1.7-4,0.2-5.3
								c2-1.3,5.4-4.4,7.5-3.1s7.5,4.2,8.6,3.5s1.4-2.3,3.7-1.5c2.3,0.9,5.1,0.5,7.2-0.1s3.8-1.3,3.8-2.3s0.3-2.1,1.6-1.9
								c1.3,0.1,2.1,0.4,2.3-1.4c0.3-1.7,0.1-3.4,1.5-3.6c1.3-0.1,1.5,2.2,3.4,1.4c2-0.9,1.7-3.4,3.4-3.4c1.7,0,7.1-0.5,9.6,1.8
								s2.3,3.4,3.8,2.9s2.5-3.3,3.4-3.1c1,0.2,3.8,1.7,6.3,0.5s8.1-5.9,10.1-7.2c2-1.4,2.6-2.8,2.2-4.4s-0.5-4.4,0.6-5.4
								s3.1-2.1,2.6-4.4s0-3.1,1.3-4.7s3.1-4.4,5.2-4.1c2.1,0.4,4.9-1.3,4.9-3.3s-0.1-2,0.8-3.3c0.8-1.3,1.8-1.9,1.2-3.5
								c-0.6-1.6-1-5.4-0.9-7s0.7-2.5,1.6-2.9c0.8-0.5,1.3-2.5,1.5-4.1c0.1-1.6,0.5-4.2,1.4-4.8c0.9-0.6,2.6-2.5,1.2-3.6
								c-1.3-1.1-3.7-0.2-3.4-1.8c0.2-1.6,2.5-2,1.5-3.5s-2.3-1.3-2.3-2.7s0.5-2.6,1-5c0.5-2.5,0.4-5.7,2.5-4.9c2.1,0.7,5.7,2.2,8.2,0.9
								c2.6-1.4,4.9-3.3,6.3-6c1.3-2.7,4.8-8.2,7.8-5.1c3.1,3.1,9.3,9.4,12.4,7.3s4.6-2.2,6.4-2.5s6.4-1.6,4.4-4.8c-2-3.2-2-1.7-1.6-5.3
								c0.4-3.6,1-6.7-0.6-8.6c-1.6-1.8-2.4-2.8-2.6-4.9c-0.1-2.1-1.7-2.7-3-3.7c-1.2-1-3.4-2.4-2.3-4.2c1.1-1.7,7.7-0.4,8.2-2.3
								s-2.1-7.9-2.7-11.2c-0.6-3.3-2.7-6.1-6.9-6.2c-4.2-0.1-12.1-0.4-13.8-2.2c-1.6-1.9-0.7-6.9-2.9-7.9c-2.2-1-3.4-0.5-3.9-2.1
								s1.1-6.3-1.2-7.3c-2.3-1.1-3.4-1.7-3.4-3c0-1.2,3.5-6,2.1-6.5c-1.5-0.5-3.7-1.5-6.7,1.1c-3.1,2.6-4.9,5.3-6.9,5.4
								c-2,0.1-4.4-0.3-6.9,0s-3.6,1.2-5-0.3c-1.5-1.5-6.6-1-8.3-0.1c-1.7,0.9-4.6-4.4-5.2-5.8c-0.6-1.3,0.7-3.4-1.1-5.3
								c-1.9-1.8-4.2-3.1-6.4-5.1c-2.2-2.1-3.8-3.2-5.1-5.3c-1.2-2.1-3.1-4.7-3.1-4.7s-10.2,1-16.7-0.6c0,0-2.9-8.7-2.9-11.3
								s4.6-0.6,5.1-2.8s2.2-4.4,0.7-6.7s-4.1-3.3-4.4-6.5c-0.2-3.2,1.1-7-0.9-10.2s-4.9-2.9-5.8-5.4c-0.8-2.4-1.5-3.7-2.3-4.7
								c-0.9-1-1.2-2.8-0.9-5.5c0.4-2.7,0.7-7.3-1.3-8.3c-2.1-1-3.7,2.5-6,3.1s-5.3-1.9-6.4-4.2c-1.1-2.2-2.2-4.3-0.1-6.7
								c2.1-2.5,7.9-5.2,8.5-9.2s1.6-10,4.9-10.3c3.3-0.2,6.1-3.1,8.1-4.8c1.9-1.7,6.2-5.2,6-7.9c-0.2-2.7-0.9-3.7,0.1-5.4
								c1-1.7,3.4-7.4,0.9-10.2c-2.6-2.8-4.7-4.3-6.9-4.1c-2.2,0.3-6.5-1.1-8.3-2.1c-1.9-1-4.8-3.9-6.4-3.6c-1.6,0.4-2.7,0.2-3.8-0.3
								c-1.1-0.5-1.6-0.5-2.8-0.7c-1.2-0.2-1-1.1-2.5-2.2s-4.2-0.9-6.4,0.4c-2.2,1.2-5.6,1.5-7.9,1.5c-2.2,0-3.4-1-5.3-2.2
								s-2.5-3.4-3.8-2.9c-1.4,0.5-1.4,2.4-3.2,1.6c-1.9-0.9-3.5-4.7-3.7-5.9c-0.3-1.2-0.3-1.9-2-2.2c-1.7-0.4-1.8-1.1-3.4-3.4
								c-1.6-2.3-4.1-5.5-6-4.2c-2,1.3-4.4,0.2-6.3-0.9c-1.8-1.1-2.1-1.5-2.1-3.4s0.1-3.7-1.9-3.8c-2.1-0.1-4.9,0.6-5.4-0.9
								s-0.4-3.8-2.2-4s-3.1,1.6-5.3,0.5s-4.7-3.2-4.5-5c0.1-1.8-0.9-4.3-2.8-5c-2-0.7-5.2-1.5-7-2.1c-1.9-0.6-2.1,0-3.8,0.7
								c-1.7,0.8-3.4-0.2-4-1.3c-0.6-1.1-2.1-1.7-3.5-0.6c-1.3,1.1-3.5,2.1-4.9,1.5c-1.3-0.6-4-2.3-4.9-4c-0.9-1.6-3.3-1.8-4.9-1.8
								C169.4,24.7,163.5,24.2,160.4,25.5z" />
						</a>
						
				        <!-- </g> -->
				        	
				        	<text id="sejong" class="TEXT" x="240" y="170">
								<a id="sejong" class="OUTLINE" href="/petBill/search/searchResult.pet?sidoSel=세종특별자치시&siguSel=세종특별자치시&pageNum=1&petType=${param.petType}">
									세종특별자치시
								</a>
							</text>
				        
					    </svg>
						
					</div>
					<br>
					<div align="center" class="blockquote-footer">
						Copyright (c) 5-July-2021, Author Geoarchive <br>
					    <cite title="Source Title">
						    This file is licenced under a Creative Commons license: <br>
						    https://ko.wikipedia.org/wiki/파일:제21대_총선_세종특별자치시_을_결과.svg
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