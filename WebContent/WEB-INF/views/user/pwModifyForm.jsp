<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정</title>
		
		<%-- user 로그인,회원가입,아이디/비번 찾기 폼 userStyle.css --%>
		<link rel="stylesheet" type="text/css" href="/petBill/resources/css/userStyle.css" />
		<!-- footer css 태준(09/29)-->
		<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
		<!--1. 부트스트랩 css 사용 -->
	    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
		
	</head>
	<body>
	
		<section>
	        <div class="color"></div>
	        <div></div>
	        <div class="color"></div>
	        <div class="box">
	            <!-- <div class="square" style="--i:0;"></div>
	            <div class="square" style="--i:1;"></div>
	            <div class="square" style="--i:2;"></div>
	            <div class="square" style="--i:3;"></div>
	            <div class="square" style="--i:4;"></div> -->
	            <div class="con">
	                <div class="form">
	                    <h2>비밀번호 수정</h2>
	                    <form action = "pwModiFyPro.pet" method = "post">
	                        <div class="inputBox">
	                       		기존 비밀번호
	                            <input type="password" name="pw" required="required"/>
	                        </div>
	                        <div class="inputBox">
	                        	수정 비밀번호
	                            <input type="password" name="pwModify" required="required"/>
	                        </div>
	                        <div class="inputBox">
	                        	수정 비밀번호 확인
	                            <input type="password" name="pwModifych" required="required"/>
	                        </div>
	                        <br />
	                        <div align="center">
	                            <!-- <input type="submit" value="로그인" /> -->
	                            <button class="button" type="submit">수정</button>
	                            <button 
										class="btn-cancel" 
		                            	id="a" type="button"
		                            	onmouseover="this.innerHTML='마이페이지';" 
		                            	onmouseout="this.innerHTML='취소';"
		                            	onclick="window.location='/petBill/user/userMypage.pet'">취소
		                       	</button>
	                        </div> 
	                    </form>
	                </div>
	            </div>
	        </div>
    	</section>
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