<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>마이페이지</title>
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">	
    
    <%-- user 로그인,회원가입,아이디/비번 찾기 폼 userStyle.css --%>
	<link rel="stylesheet" type="text/css" href="/petBill/resources/css/userStyle.css" />
	
	<!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">

</head>
  <body>
 		
   <div class="d-flex">
        <!-- 왼쪽 메인 메뉴 -->
        <div class="border-end bg-white" id="sidebar-wrapper">
        	<!-- 로고 -->
            <div class="sidebar-heading border-bottom bg-light"><a href="/petBill/user/main.pet"><img src="/petBill/resources/imgs/로고화면.png" style="width: 190px; margin-top: 10px;"></a></div>
            <div class="list-group list-group-flush">
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/user/userMypage.pet">회원 정보</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/user/userReviewList.pet">마이 리뷰</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/user/userQuestion.pet">1:1 문의</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/user/userDeleteForm.pet">회원탈퇴</a>
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
	                        <li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
	                        <li class="nav-item"><a class="nav-link" href="/petBill/user/userMypage.pet">마이페이지</a></li>
	                      </ul>
                      </div>
                 </div>
            </nav>
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
           <!-- 페이지 내용작성 영역 : Page content-->
            <div class="container-fluid">
            
            	<section>
			        <div class="color"></div>
			        <div ></div>
			        <div class="color"></div>
			        <div class="box">
			            <!-- <div class="square" style="--i:0;"></div>
			            <div class="square" style="--i:1;"></div>
			            <div class="square" style="--i:2;"></div>
			            <div class="square" style="--i:3;"></div>
			            <div class="square" style="--i:4;"></div> -->
			            <div class="con">
			                <div class="form">
			                
		                    <h2>회원 정보</h2>
	                    	<c:if test="${sessionScope.kakaoId == null }">
		                        <div class="inputBox-signup">
		                        	아이디
		                        	<input type="text" value="${dto.id}" disabled="disabled"/>
	                    		</div>
		                        <div class="inputBox-signup">
		                        	비밀번호
		                        	<input type="text" value="${dto.pw}" disabled="disabled"/>
	                    		</div>
	                    	</c:if>
	                    	
	                        <div class="inputBox-signup">
	                        	이름
	                        	<input type="text" value="${dto.name}" disabled="disabled"/>
                    		</div>
	                        <div class="inputBox-signup">
	                        	닉네임
	                        	<input type="text" value="${dto.nickname}" disabled="disabled"/>
                    		</div>
	                        <div class="inputBox-signup">
	                        	휴대폰
	                        	<input type="text" value="${dto.mobile}" disabled="disabled"/>
                    		</div>
                    		
		                    <c:if test="${dto.useractivenum eq '활성화'}">
		                    	<div class="inputBox-signup">
		                        	상태 : <input type="text" value="활성화" disabled="disabled"/>
	                    		</div>
		                    </c:if>	
		                    <c:if test="${dto.useractivenum eq '비활성화'}">
		                    	<div class="inputBox-signup">
		                    		상태 : <input type="text" value="비활성화 " disabled="disabled"/>
									사유 : <input type="text" value="${dto.userreason}" disabled="disabled"/>
		                    	</div>
		                    </c:if>
		                    	
	                    	<br />
	                        <div align="center">
                     			<button 
                     				class="btn-join" 
                     				onclick="window.location='/petBill/user/userModifyForm.pet'">수정하기</button>
		                    </div>   
	                        <div align="center">
	                            <button 
	                            	class="btn-cancel-findPw" 
	                            	id="a" type="button"
	                            	onmouseover="this.innerHTML='메인으로';" 
	                            	onmouseout="this.innerHTML='취소';"
	                            	onclick="window.location='/petBill/user/main.pet'">취소
	                           	</button>
	                        </div>
		                        
			                </div>
			            </div>
			        </div>
		    	</section>
			</div><!-- container-fluid 내용작성 영역 -->
      </div> <!-- page-content-wrapper 꺼 -->
  </div>     
  
    	
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