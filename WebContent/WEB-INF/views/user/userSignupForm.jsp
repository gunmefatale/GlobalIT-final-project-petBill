<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		
		<%-- user 로그인,회원가입,아이디/비번 찾기 폼 userStyle.css --%>
		<link rel="stylesheet" type="text/css" href="/petBill/resources/css/userStyle.css" />
		
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
	</head>
	<script>
		//아이디 체크
		$(document).ready(function(){
			$("#id").change(function(){
				var idVal = $("#id").val();
				$.ajax({
					url : "/petBill/user/ajaxidcheck.pet",
					type : "post",
					data : {id:idVal},
					success : function(data){
						$("#id_ckeck").css("color","red");
						$("#id_ckeck").html(data)
						console.log("성공!");
						console.log("data : " + data);
						$("#id_ckeck").val(data);
					},
					error : function(e){
						console.log("error...");
						console.log(e);
					}
				});
			});
		});
		
		//=====================================================	
			
		//비밀번호 체크
		function check(){
			var inputs = document.inputForm;
			if(inputs.pw.value != inputs.pwch.value){
				alert("비밀번호를 동일하게 입력하세요");
				$("#pw").val("");
				$("#pwch").val("");
				return false;
			}
			
		    var patternPhone = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
			if(!patternPhone.test(inputs.mobile.value)){
		        alert('핸드폰 번호를 확인 해주세요');
		        $("#mobile").val("");
		        return false;
		    }  
		}
		
		//=====================================================
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
	
	
	</script>
	<script>    
	
	    $(function() {    //화면 다 뜨면 시작
	        $("#searchInput").autocomplete({
	            source : function( request, response ) {
	               
	             //위에 있는 코드랑 동일 생략//
	             
	            
	            }
	        }).autocomplete( "instance" )._renderItem = function( ul, item ) {    //요 부분이 UI를 마음대로 변경하는 부분
	                  return $( "<li>" )    //기본 tag가 li로 되어 있음 
	                  .append( "<div>" + item.value + "<br>" + item.label + "</div>" )    //여기에다가 원하는 모양의 HTML을 만들면 UI가 원하는 모양으로 변함.
	                  .appendTo( ul );
	           };
	    });
	    
	</script>
	
	<body>
		<br />
		<br />
		<br />
		<br />
		<section>
	        <div class="color"></div>
	        <div class="color"></div>
	        <div class="color"></div>
	        <div class="box">
	           
	            <div class="con">
	                <div class="form">
	                	
	                    <h2>회원가입</h2>
	                    <form action="/petBill/user/userSignupPro.pet" method="post" name="inputForm" onsubmit="return check()">
	                    	<c:if test="${id == null && pw == null}">
		                        <div class="inputBox-signup">
		                        	아이디(필수)
		                            <input type="text" placeholder="영문/숫자 조합" name="id" id="id" maxlength='20' required />
		                        	<br/>
		                        	<span id="id_ckeck"></span>
		                        </div>
		                        <div class="inputBox-signup">
	                    			비밀번호(필수)
		                            <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요." maxlength='20' required/>
		                        </div>
	                    		<div class="inputBox-signup">
		                            비밀번호 확인(필수)
		                            <input type="password" name="pwch" id="pwch" placeholder="다시 비밀번호를 입력하세요." maxlength='20' required />
		                        </div>
		                        <div class="inputBox-signup">
	                    			이름(필수)
		                            <input type="text" name="name" maxlength='10' placeholder="이름을 입력하세요." required/>
		                        </div>
	                    		<div class="inputBox-signup">
	                    			닉네임(필수)
		                            <input type="text" name="nickname" maxlength='10' id="nickname" placeholder="닉네임을 입력하세요." required />
		                            <br />
		                            <span id="nickname_ckeck"></span>
		                        </div>
		                  		<div class="inputBox-signup">
	                    			휴대폰(필수)
		                            <input type="text" name="mobile" id="mobile" placeholder="'-'를 포함하여 입력하세요." maxlength="13" required/>
		                        </div>
	                    	</c:if>
	                    	<c:if test="${id != null && pw != null}">
		                        <div class="inputBox-signup">
		                            <input type="hidden" name="id" id="id" value= "${id}"/>
		                        </div>
	                    		<div class="inputBox-signup">
		                            <input type="hidden" name="pw" id="pw" value="${pw}" required/>
		                        </div>
	                    		<div class="inputBox-signup">
		                            <input type="hidden" name="pwch" id="pwch" value="${pw}" required />
		                        </div>
	                    		<div class="inputBox-signup">
	                    			이름(필수)
		                            <input type="text" name="name" maxlength='10' required/>
		                        </div>
	                    		<div class="inputBox-signup">
	                    			닉네임(필수)
		                            <input type="text" name="nickname" maxlength='10' id="nickname"/>
		                            <br />
		                            <span id="nickname_ckeck"></span>
		                        </div>
		                  		<div class="inputBox-signup">
	                    			휴대폰(필수)
		                            <input type="text" name="mobile" id="mobile" placeholder="'-' 포함" maxlength="13" required/>
		                        </div>
	                    	</c:if>
	                    	<br />
	                        <div align="center">
                       		    <button class="btn-join" type="submit">가입</button>
	                        </div>   
	                        <div align="center">
	                            <button class="button" type="reset">재작성</button>
	                            <button 
	                            	class="btn-cancel" 
	                            	id="a" type="button"
	                            	onmouseover="this.innerHTML='메인으로';" 
	                            	onmouseout="this.innerHTML='취소';"
	                            	onclick="window.location='/petBill/user/main.pet'">취소</button>
	                        </div>
	                    </form>
	                </div>
	            </div>
	        </div>
    	</section>
		
	<footer>
	</footer>
	
	
	</body>
</html>