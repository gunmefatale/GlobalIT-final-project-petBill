<!-- *** 전체내용 복붙해서 사용하시면 됩니다 *** -->
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
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">	
   	<!-- footer css -->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
</head>
  <body>
 		
   <div class="d-flex" id="wrapper">
        <!-- 왼쪽 메인 메뉴 -->
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
        <!-- Page content wrapper-->
        <div id="page-content-wrapper">
            <!-- 상단 네비게이션 -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                   <!-- 반응형 동작시 버튼생김 -->
                   <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
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
									<a class="dropdown-item" href="/petBill/admin/noticeContent.pet?petType=${'dog'}&diagnosis=${'dAllTest'}&noticeNo=${dto.noticeNo}&pageNum=${pageNum}">강아지</a>
                                   	<a class="dropdown-item" href="/petBill/admin/noticeContent.pet?petType=${'cat'}&diagnosis=${'cAllTest'}&noticeNo=${dto.noticeNo}&pageNum=${pageNum}">고양이</a>
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
                
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
  			<br />
  			<div align="center"  style="white-space:nowrap; overflow:auto;">
			<table class="table table-bordered">
			<caption>공지사항</caption>
				<tr>
					<th class="table-light" align="center">작성자</th>
					<td>
						<c:if test="${dto.noticeId eq 'admin'}">
							관리자
						</c:if>
					</td>
					<th class="table-light" align="center">등록날짜</th>
					<td>
						<fmt:formatDate value="${dto.reg}" pattern="yyyy-MM-dd"/>
					</td>
			
				</tr>
				<tr>
					<th class="table-light" align="center">제 목</th>
					<td colspan="3">
						${dto.noticeSubject}
					</td>
				</tr>
				<tr>
					<th class="table-light">내 용</th>
					<td colspan="3" align="center">
						<c:if test="${dto.noticePhoto != null}">
							<img src="/petBill/Notice/${dto.noticePhoto}" width="700">
							<br />
						</c:if>
						<br />
						${dto.noticeContent}
						<br /><br />
					</td>
				</tr>
			</table>
		    <input type="button" value="뒤로가기" onclick="window.location='/petBill/admin/noticeList.pet?pageNum=${pageNum}&petType=${param.petType}'" class="btn btn-dark"/>
  			</div>
  			<br /><br /><br /><br />
   		 	
   		 	</div><!-- container-fluid 내용작성 영역 -->
    		</div> <!-- page-content-wrapper 꺼 -->
    		
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