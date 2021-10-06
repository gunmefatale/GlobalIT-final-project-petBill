<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>아이디 찾기</title>
		
		<%-- user 로그인,회원가입,아이디/비번 찾기 폼 userStyle.css --%>
		<link rel="stylesheet" type="text/css" href="/petBill/resources/css/userStyle.css" />
		
	</head>
	
	<body>
		
		<section>
	        <div class="color"></div>
	        <div class="color"></div>
	        <div class="color"></div>
	        <div class="box">
	            <!-- <div class="square" style="--i:0;"></div>
	            <div class="square" style="--i:1;"></div>
	            <div class="square" style="--i:2;"></div>
	            <div class="square" style="--i:3;"></div>
	            <div class="square" style="--i:4;"></div> -->
	            <div class="con">
	                <div class="form">
		                <form action="/petBill/user/findIdPro.pet" method="post">
		                    <h2>아이디 찾기</h2>
		                    <div class="inputBox">
		                    	회원 이름
	                            <input type="text" name="Name" placeholder="이름을 입력하세요."/>
	                        </div>
		                    <div class="inputBox">
		                    	휴대폰
	                            <input type="text" name="Mobile" maxlength="13" placeholder="'-'를 포함하여 입력하세요."/>
	                        </div>
		                    <div align="center">
	                     		<button class="btn-join" type="submit">아이디 찾기</button>
		                    </div>   
	                        <div align="center">
	                            <button class="button" 
	                            type="button" 
	                            onclick="window.location='/petBill/user/findPwForm.pet'">비밀번호 찾기</button>
	                            <button 
	                            	class="btn-cancel" 
	                            	id="a" type="button"
	                            	onmouseover="this.innerHTML='로그인 페이지로';" 
	                            	onmouseout="this.innerHTML='취소';"
	                            	onclick="window.location='/petBill/user/loginForm.pet'">취소</button>
	                        </div>
		                </form>
	  
	                </div>
	            </div>
	        </div>
    	</section>
		
	</body>
</html>