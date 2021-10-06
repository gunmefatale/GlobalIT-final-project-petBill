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
    <title>petBill</title>
    
    <script type="text/javascript">
    function insert(){
    	
    	alert("등록하시겠습니까?");
    }
    function update(){
    	
    	alert("수정하시겠습니까?");
    	
    }
    function del(){
    	
    	var result = confirm("정말 삭제하시겠습니까?");
    	
    	if(result){
    		// 확인 선택시 처리
	    	window.location='adQuestiondelete.pet?mtmno=${mtmdto.mtmno}&pageNum=${pageNum}';
	    	
    	}
    }
    
    </script>
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
    <!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">    	

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
           <div class="container-fluid" align="center" style="white-space:nowrap; overflow:auto;"
           >
           <c:if test="${mtmdto.ref eq 'none'}"><!-- ref값이 있으면 글작성 -->
			<form action="/petBill/admin/adQuestionContentPro.pet?pageNum=${pageNum}" method="post">
				<br />
				<h3>1:1 문의</h3>	
				<br />
				<table class="table table-bordered" style="width: 450px;">
					<tr>
						<th class="table-light">제 목</th>
						<td><input type="text" name="mtmsubject" value="${mtmdto.mtmsubject}" class="form-control-plaintext" readonly/>
							<input type="hidden" name="mtmno" value="${mtmdto.mtmno}" />
						</td>
					</tr>
					<tr>
						<th class="table-light">작성자</th>
						<td><input type="text" value="${mtmdto.mtmuserid}" class="form-control-plaintext" readonly/>
						</td>
					</tr>
					<tr>
						<th class="table-light">문의내용</th>
						<td><textarea rows=10px cols=60px style="resize: none;" name="mtmcontent" readonly>${mtmdto.mtmcontent}</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="table-dark" align="center">
							관리자 답변
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea rows=10px cols=70px style="resize: none;" name="ref" required placeholder="답변내용 작성" autofocus>답변)</textarea>
						</td>
					</tr>
				</table>
				<input type="submit" onclick="insert()" value="답변하기" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${sel == null || search == null}">
					<input type="button" onclick="window.location='adQuestionList.pet?pageNum=${pageNum}'" value="뒤로가기" class="btn btn-dark" style="width:100pt;"/>
				</c:if>
				<c:if test="${sel != null || search != null}">
					<input type="button" onclick="window.location='adQuestionList.pet?pageNum=${pageNum}&sel=${sel}&search=${search}'" value="뒤로가기" class="btn btn-dark" style="width:100pt;"/>
				</c:if>
				</form>
			</c:if> 
			
         <c:if test="${mtmdto.ref ne 'none'}">  <!-- ref값이 있으면 수정/삭제 -->
		 <form action="/petBill/admin/adQuestionContentPro.pet?pageNum=${pageNum}" method="post">
				<br />
				<h3>1:1 문의</h3>	
				<br />
				<table class="table table-bordered" style="width: 450px;">
					<tr>
						<th class="table-light">제 목</th>
						<td><input type="text" name="mtmsubject" value="${mtmdto.mtmsubject}" class="form-control-plaintext" readonly/>
							<input type="hidden" name="mtmno" value="${mtmdto.mtmno}" />
						</td>
					</tr>
					<tr>
						<th class="table-light">작성자</th>
						<td><input type="text" value="${mtmdto.mtmuserid}" class="form-control-plaintext" readonly/>
						</td>
					</tr>
					<tr>
						<th class="table-light">문의내용</th>
						<td><textarea rows=10px cols=60px style="resize: none;" name="mtmcontent" readonly>${mtmdto.mtmcontent}</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="table-dark" align="center">
							관리자 답변
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea rows=10px cols=70px style="resize: none;" name="ref" required autofocus>${mtmdto.ref}</textarea>
						</td>
					</tr>
				</table>
				<input type="submit" value="수정하기" onclick="update()" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" onclick="del()" value="삭제하기" class="btn btn-secondary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${sel == null||search == null}">
					<input type="button" onclick="window.location='adQuestionList.pet?pageNum=${pageNum}'" value="뒤로가기" class="btn btn-dark" style="width:100pt;"/>
				</c:if>
				<c:if test="${sel != null||search != null}">
					<input type="button" onclick="window.location='adQuestionList.pet?pageNum=${pageNum}&sel=${sel}&search=${search}'" value="뒤로가기" class="btn btn-dark" style="width:100pt;"/>
				</c:if>
			</form>
		</c:if> 
		<br />
		</div><!-- container-fluid 내용작성 영역 -->
      </div> <!-- page-content-wrapper 꺼 -->
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