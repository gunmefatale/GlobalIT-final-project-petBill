<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
	<!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">   
	
	 
    <!-- 비활성화에만 사유 텍스트박스 보이게 -->
    <script>
	$(document).ready(function(){
	    if($("#useractivenum").val() == "비활성화") {
	        if($("#span").val() == "none"){
	        	$("#span").val("");
	        }
	        $("#span").val();
	    	$("#span").show();
	      }  else {
	         $("#span").hide();
	      }
	  $("#useractivenum").change(function() {
	        if($("#useractivenum").val() == "비활성화") {
		       	if($("#span").val() == "none"){
			        $("#span").val("");
			    }
		        $("#span").val();
		        $("#span").show();
		           
	        }else {
	           $("#span").hide();
	        }
	     }) 
	  });
	</script>	

</head>

  <body>
 		
   <div class="d-flex" id="wrapper">
        <!-- 왼쪽 메인 메뉴 -->
        <div class="border-end bg-white" id="sidebar-wrapper">
        	<!-- 로고 -->
            <div class="sidebar-heading border-bottom bg-light"><a href="/petBill/user/main.pet"><img src="/petBill/resources/imgs/로고화면.png" style="width: 190px; margin-top: 10px;"></a></div>
            <div class="list-group list-group-flush">
            <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adMain.pet">관리자페이지</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adUserSearch.pet">회원 검색</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adHosModify.pet">병원 등록/수정/삭제</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adPetModify.pet">진료비 수정/삭제</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adReviewStatus.pet">전국 리뷰 현황</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adQuestionList.pet">1:1 문의</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/adNoticeList.pet">공지사항 등록</a>
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
	                        <li class="nav-item"><a class="nav-link" href="/petBill/admin/adMain.pet">관리자 페이지</a></li>
	                      </ul>
                      </div>
                 </div>
            </nav>
                
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
               
           <!-- 페이지 내용작성 영역 : Page content-->
            <div class="container-fluid form-group" align="center" >
			<br />
          	<h3>회원 정보</h3>
          	<br />
			<table class="table " style="width: 500px;"> 
				<tr>
					<th class="table-light"><label for="id">아이디</label></th>
					<td colspan="2">${dto.id}</td>
				</tr> <!-- 비밀번호 삭제함 (관리자용이라)-->
				<tr>
					<th class="table-light"><label for="name">이름</label></th>
					<td colspan="2">${dto.name}</td>
				</tr>
				<tr>
					<th class="table-light"><label for="nickname">닉네임</label></th>
					<td colspan="2">${dto.nickname}</td>
				</tr>
				<tr>
					<th class="table-light"><label for="mobile">휴대폰</label></th>
					<td colspan="2">${dto.mobile}</td>
				</tr>
                <form action="/petBill/admin/useractivenum.pet" method="post">
				<tr>   
	               	<th >
	                  상태 : <select name="useractivenum" id="useractivenum">
	                           <option value="활성화"<c:if test="${dto.useractivenum eq '활성화'}">selected</c:if>>활성화</option>
	                           <option value="비활성화"<c:if test="${dto.useractivenum eq '비활성화'}">selected</c:if>>비활성화</option>
	                        </select>
	                        <input type="submit" value="상태변경" class="btn btn-primary btn-sm"/>
	               	</th>
	               	<td  style="width: 250px;">
	               		<!-- 비활성화시 사유 -->
                  		사유 : <input type="text" id="span" name="userreason" value="${dto.userreason}" autofocus/>
                        <input type="hidden" name="id" value="${dto.id}"/> <!-- 안보이게 값 넘기기 -->
                        <input type="hidden" name="pageNum" value="${pageNum}"/><!-- 안보이게 값 넘기기 -->
            		</td>
            	</tr>
                </form>
			</table>
			<c:if test="${sel == null || search == null}">
				<input type="button" onclick="window.location='adUserSearch.pet?pageNum=${pageNum}'" value="뒤로가기" class="btn btn-dark"  style="width: 100px;"/>
			</c:if>
		
			<c:if test="${sel != null || search != null}">
				<input type="button" onclick="window.location='adUserSearch.pet?pageNum=${pageNum}&sel=${sel}&search=${search}'" value="뒤로가기" class="btn btn-dark" style="width: 100px;"/>
			</c:if>

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