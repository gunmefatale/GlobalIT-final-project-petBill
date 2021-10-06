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
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
    <!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">    
    
    	
<script type="text/javascript">
	//업데이트 버튼 클릭시 처리
	function update(){
		
	 alert("수정하시겠습니까?");
	 		
	}
	//삭제 버튼 클릭시 처리
   	function del(){
		var result = confirm("정말 삭제하시겠습니까?");
		
		if(result){
			// 확인 선택시 처리
			window.location='/petBill/admin/adNoticeDelete.pet?pageNum=${pageNum}&noticeNo=${dto.noticeNo}';
		   
		}
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
	                      </ul>
                      </div>
                 </div>
            </nav>
                
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
               
           <!-- 페이지 내용작성 영역 : Page content-->
            <div class="container-fluid" style="white-space:nowrap; overflow:auto;" align="center">
            
            <br />
			<c:if test="${dto.noticeSubject == null}"> <!--제목에 값이 없으면 글저장 -->
			<h3> 공지사항 작성 </h3>
			<br />
			<form action="/petBill/admin/adNoticeWritePro.pet" method="post" enctype="multipart/form-data">
				<%-- 숨겨서 글 속성 값 전송 --%>
				<table class="table table-bordered" style="width: 600px;" >
					<tr>
						<th class="table-light">제 목</th>
						<td align="left">
							<input type="text" name="noticeSubject" required="required" autofocus/>
						</td>
					</tr>
					<tr>
						<th class="table-light">작성자</th>
						<td align="left"><input type="text" class="form-control-plaintext" readonly name="noticeId" value="${sessionScope.userId}"/></td>
					</tr>
					<tr>
						<th class="table-light">이미지 업로드</th>
						<td align="left"><input type="file" name="noticePhoto"/></td>
					</tr>
					<tr>
						<th class="table-light">공지사항 내용</th>
						<td>
							<textarea rows="20" cols="70" name="noticeContent" required="required"></textarea>
						</td>
					</tr>
				</table>
				<input type="submit" value="등록하기" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="재작성" class="btn btn-secondary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="취소하기" onclick="window.location='/petBill/admin/adNoticeList.pet'" class="btn btn-dark" style="width:100pt;"/>
						
			</form>    
		  </c:if>
		  
		  <c:if test="${dto.noticeSubject != null}"><!--  제목 값이 있으면 수정/삭제 -->
			<h1 align="center"> 공지사항 </h1>
			<form action="/petBill/admin/adNoticeModifyForm.pet?pageNum=${pageNum}&noticeNo=${dto.noticeNo}&noticePhoto=${dto.noticePhoto}" method="post" enctype="multipart/form-data">
				<%-- 숨겨서 글 속성 값 전송 --%>
				<table class="table table-bordered" style="width: 600px;" >
					<tr>
						<th class="table-light">제 목</th>
						<td align="left">
							<input type="text" name="noticeSubject" value="${dto.noticeSubject}" required="required" autofocus/>
							<input type="hidden" name="noticeNo" value="${dto.noticeNo}"/>
						</td>
					</tr>
					<tr>
						<th class="table-light">작성자</th>
						<td align="left"><input type="text" value="${sessionScope.userId}" class="form-control-plaintext" readonly name="noticeId" value="${sessionScope.userId}"/></td>
						
					</tr>
					<tr>
						<th class="table-light">이미지</th>
						<td align="left">
							<img src="/petBill/Notice/${dto.noticePhoto}" width="150" />
							<input type="file" name="noticePhoto" />
							<input type="hidden" name="noticePhoto" value="${dto.noticePhoto}"/>
						</td>
					</tr>
					<tr>
						<th class="table-light">공지사항 내용</th>
						<td>
							<textarea rows="20" cols="70" name="noticeContent" required="required">${dto.noticeContent}</textarea>
						</td>
					</tr>
					
				</table>
					<input type="submit" onclick="update()" value="수정하기" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="삭제하기" onclick="del()" class="btn btn-secondary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="뒤로가기" onclick="window.location='/petBill/admin/adNoticeList.pet?pageNum=${pageNum}'" class="btn btn-dark" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</form>    
		  </c:if>

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