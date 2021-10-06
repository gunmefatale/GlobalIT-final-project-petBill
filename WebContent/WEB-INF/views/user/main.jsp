<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
   
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
<!-- footer css 태준(09/29)-->
<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>main</title>
</head>
<script>
function kakaoLogout(){
	Kakao.init("5acd7d0abad958ae8f6e5399abee0118");
	Kakao.isInitialized();
	
	if (!Kakao.Auth.getAccessToken()) {
		  console.log('Not logged in.');
		  return;
		}
		Kakao.Auth.logout(function() {
		  console.log(Kakao.Auth.getAccessToken());
		  kakaoLogoutPro()
		});
	
}
function kakaoLogoutPro(){
	$.ajax({
		type : 'POST',
		url : '/petBill/user/kakaologout.pet',
		success : function(){
				location.href='main.pet'
		},
		error:function(error){
			alert("error");
		}
	});
}
</script>


<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
		<div class="container-fluid">
			<%-- 반응형 동작시 버튼생김 --%>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mt-2 mt-lg-0">
	
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
				</ul>
			</div>
		</div>
	</nav>
	<div style ="text-align: center; margin-bottom: 110px; margin-top: 200px">
		<a href="/petBill/search/mapMain.pet?petType=${'cat'}">
		<img src="/petBill/resources/imgs/6.png"
		onmouseover="this.src='/petBill/resources/imgs/7.png'"
		onmouseout="this.src='/petBill/resources/imgs/6.png'" id="cat" ></a>
		
		<a href="/petBill/search/mapMain.pet?petType=${'dog'}">
		<img src="/petBill/resources/imgs/4.png"
		onmouseover="this.src='/petBill/resources/imgs/2.png'"
		onmouseout="this.src='/petBill/resources/imgs/4.png'" id="dog"></a>
		<br />
		<br />
   	<div style ="text-align: center; height: 150px;">
		<img src="/petBill/resources/imgs/제목1.png"/>
	</div>
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

	
</body>

</html>