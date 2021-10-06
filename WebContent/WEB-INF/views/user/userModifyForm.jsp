<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	    <meta name="description" content="" />
	    <meta name="author" content="" />
	    <title>회원정보 수정</title>
	    
	    
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    
	    <!--1. 부트스트랩 css 사용 -->
	    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
	    
		<!-- footer css 태준(09/29)-->
		<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
	    
	    <%-- user 로그인,회원가입,아이디/비번 찾기 폼 userStyle.css --%>
		<link rel="stylesheet" type="text/css" href="/petBill/resources/css/userStyle.css" />
		
	   	<script>
	  	//닉네임체크
	    $(document).ready(function(){
	       $("#nickname").change(function(){
	          var regExp = /[~!@#$%^&*()_+|<>?:;{}ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔㅁㄴㅇㄹㅎㅓㅏㅣㅋㅌㅊㅠㅍㅗㅜㅡㅖㅒ,/.]/;
	          var nicknameVal = $("#nickname").val();
	          if(regExp.test(nicknameVal)){
	             alert("닉네임은 한글, 영어, 숫자만 입력 가능합니다.");
	             $("#nickname").val("");
	             return false;
	          }
	          $.ajax({
	             url : "/petBill/user/ajaxnicknamecheck.pet",
	             type : "post",
	             data : {nickname:nicknameVal},
	             success : function(data){
	                if(data == 0){
	                $("#nickname_ckeck").css("color","red");
	                $("#nickname_ckeck").html("사용 가능한 닉네임")
	                console.log("성공!");
	                console.log("data : " + data);
	                $("#nickname_ckeck").val("사용 가능한 닉네임");
	                }else if(data == 1){
	                   alert("이미 사용중인 닉네임 입니다");
	                   $("#nickname").val("");
	                   $("#nickname_ckeck").html("")
	                   $("#nickname_ckeck").val("");
	                }
	             },
	             error : function(e){
	                alert("다시 입력해주세요!");
	                console.log("error...");
	                console.log(e);
	             }
	          });
	       });
	    });
		
		//핸드폰 체크
		function check(){
			var inputs = document.inputForm;
		    var patternPhone = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
			if(!patternPhone.test(inputs.mobile.value)){
		        alert('핸드폰 번호를 확인 해주세요');
		        $("#mobile").val("");
		        return false;
		    }  
		}
	   	</script>
	
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
	            	<br />
	            	<br />
	            	<br />
	            	<section>
				        <div class="color"></div>
				        <div></div>
				        <div class="color"></div>
				        <div class="box">
				           <!--  <div class="square" style="--i:0;"></div>
				            <div class="square" style="--i:1;"></div>
				            <div class="square" style="--i:2;"></div>
				            <div class="square" style="--i:3;"></div>
				            <div class="square" style="--i:4;"></div> -->
				            <div class="con">
				                <div class="form">
				                
				                    <h2>회원 정보 수정</h2>
				                    <form action="/petBill/user/userModifyPro.pet" name="inputForm" onsubmit="return check()" method="post">
				                    	<c:if test="${sessionScope.kakaoId == null}">
					                        <div class="inputBox-signup">
					                        	아이디
					                        	<input type="text" value="${dto.id}" disabled="disabled"/>
				                    		</div>
					                        <div class="inputBox-signup">
					                        	비밀번호
					                        	<button 
					                        		class="btn-modify" 
					                        		type="button"
					                        		onclick="window.location='pwModifyForm.pet'">수정</button>
					                        	<input type="text" value="${dto.pw}" disabled="disabled"/>
				                    		</div>
				                    	</c:if>
				                    	
			                    		<div class="inputBox-signup">
				                        	이름
				                        	<input type="text" value="${dto.name}" required disabled="disabled"/>
			                    		</div>
			                    		<div class="inputBox-signup" >
				                        	닉네임
				                        	<input type="text" name="nickname" maxlength='10' id="nickname" value="${dto.nickname}" style="background: #ffffff" required/>
				                        	<br />
				                        	<span id="nickname_ckeck"></span>
			                    		</div>
			                    		<div class="inputBox-signup">
				                        	휴대폰
				                        	<input type="text" name="mobile" id="mobile" value="${dto.mobile}" required placeholder="'-'포함" maxlength="13" style="background: #ffffff" />
			                    		</div>
					                    <br />
				                        <div align="center">
			                       		    <button class="btn-join" type="submit">수정하기</button>
				                        </div>   
				                        <div align="center">
				                            <button class="button" type="reset">재작성</button>
				                            <button 
				                            	class="btn-cancel" 
				                            	id="a" type="button"
				                            	onmouseover="this.innerHTML='마이페이지';" 
				                            	onmouseout="this.innerHTML='취소';"
				                            	onclick="window.location='/petBill/user/userMypage.pet'">취소</button>
				                        </div>	
			                    	</form>
				                </div>
				            </div>
				        </div>
			    	</section>
				</div>
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