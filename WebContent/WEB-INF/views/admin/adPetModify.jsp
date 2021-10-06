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
    
    <!-- jquery/ajax 사용시 라이브러리를 밑의 링크거는방식: cdm방식으로 추가 (인터넷 될 경우. 안되면 다운받아야함)-->
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
	<!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
	
   <script type="text/javascript">
       // 병원 입력시키는 새창
       function selHospital(a){ //this.name 객체 받음
          // 팝업띄우기
          var url ="ajaxSearch.pet";
          open(url, "selHospital", "toolbar=no, location=no, status=no, menubar=no, resizable=no, width=1000, height=580");
       }
    </script>
    
    <script type="text/javascript">
      // 진료비 비교 ajax
       function ajaxAction() {
            let hosName = $("#hosName").val(); // 값을 변수에 담아서
            let hosNo = $("#hosNo").val(); // 값을 변수에 담아서(우선 string)
            $.ajax({ // 설정하는 부분
              // 띄워질 페이지 dog/cat진료비테이블
               url: 'http://localhost:8080/petBill/admin/diagnosisTable.pet', 
               method:'get', 
               data: {hosName, hosNo},// 위 변수에 담긴 데이터를 전송해준다
           }).done(function(response){ // == success 랑 같은기능. 지금 error처리는 없는상태.
               $('#adPetModify').html(response); 
           });
       }
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
                           <li class="nav-item dropdown"></li>
                         </ul>
                      </div>
                 </div>
            </nav>
                
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
               
      <!-- 페이지 내용작성 영역 : Page content-->
      <div class="container-fluid" style="white-space:nowrap; overflow:auto;">
      <br />
      <div id="title" align="center">
        <h3>진료비 수정/삭제</h3>
          <p class="lead">
          	수정할 병원을 검색해 주세요.
          </p>
      </div>
        
      <!-- 병원검색 새창띄움 -->
      <div align="center">
      <table class="table">
      <tr align="center">
      	<td>
	      <button type="button" class="btn btn-secondary" name="a" onclick="selHospital(this.name)">병원검색</button>&nbsp;&nbsp;
	      <!-- 병원명, 고유번호 입력받아서 -->
	      <input type="text" name="hosName" id="hosName" class="form-control-plaintext" readonly/>
	      <input type="hidden" name="hosNo" id="hosNo"/>
      	</td>
      </tr>
      </table>
      <br />
   
      <!-- 버튼선택시 dog/cat 진료비테이블 오픈될 ajax -->
      <div class="d-grid gap-2 col-6 mx-auto">
				               		
      	<button onclick="ajaxAction()" class="btn btn-primary btn-lg">진료비 보기</button>
      </div>
      
      <!-- ajax 진료비 테이블 뜨는 영역 -->
      <div id="adPetModify" class="divtest"></div>
      <br /><br /><br /><br />
   
      </div><!-- container-fluid 내용작성 영역 -->
     </div> <!-- page-content-wrapper 꺼 -->
  </div>  
 </div>     
  	<!-- footer -->
	<footer class="footer" style="margin-top: 50px">
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