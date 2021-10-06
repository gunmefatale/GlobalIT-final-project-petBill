<!-- *** 전체내용 복붙해서 사용하시면 됩니다 *** -->
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
		   <div class="container-fluid" style="white-space:nowrap;">
			
			<br />
			<div align="center">
			<%-- 작성자/내용 검색 --%>
			<form action="/petBill/admin/adNoticeList.pet">
				<select name="sel">
					<option value="noticeSubject">제목</option>
				</select>
				<input type="text" name="search" />
				<input type="submit" value="검색"  class="btn btn-secondary btn-sm"/>
			</form>

			<c:if test="${count == 0}">
			<br />
			<table class="table table-bordered">
				<caption>
				<button onclick="window.location='/petBill/admin/adNoticeWrite.pet'" class="btn btn-primary">공지사항 등록하기</button>
				</caption>
				<tr>
					<td align="center">게시글이 없습니다.</td>
				</tr>
			</table>
			</c:if>
			
			<c:if test="${count != 0}">
			<table class="table table-bordered">
				<caption>
				<button onclick="window.location='/petBill/admin/adNoticeWrite.pet'" class="btn btn-primary">공지사항 등록하기</button>
				</caption>
				<tr class="table-dark" align="center">
					<td>No.</td>
					<td>제목</td>
					<td>날짜</td>
				</tr>
				<c:forEach var="article" items="${articleList}">
				<tr>
					<td align="center">
						${number}
						<c:set var="number" value="${number - 1}"></c:set>
					</td>
					<td>	
					<c:if test="${sel == null || search == null}"><!-- 검색안했을때 -->
						<a href="/petBill/admin/adNoticeContent.pet?pageNum=${pageNum}&noticeNo=${article.noticeNo}" class="nav-link">${article.noticeSubject}</a>
					</c:if>			
					<c:if test="${sel != null || search != null}"><!-- 검색했을때 -->
						<a href="/petBill/admin/adNoticeContent.pet?pageNum=${pageNum}&noticeNo=${article.noticeNo}&sel=${sel}&search=${search}" class="nav-link">${article.noticeSubject}</a>
					</c:if>			
					</td>
					<td align="center">
						<fmt:formatDate value="${article.reg}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				</c:forEach>
				</table>
				</c:if>
			
			    <br /> 
				 <%-- 페이지 번호 --%>
			     <%--하단 페이지 번호--%>
		         <c:if test="${count > 0}">
		            <c:set var="pageBlock" value="3" /> <%--하단에 보여줄 번호 개수 넘으면 > 꺽쇄로 --%>
		            <fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" /><%--integerOnly="true" 소수점 안나오게 --%>
		            <c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" /> <%--값이 0이면 0 아니면 1 --%>
		            <fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
		            <fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
		            <fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
		            
		            <c:if test="${endPage > pageCount}">
		               <c:set var="endPage" value="${pageCount}" /> 
		            </c:if>
		            
		            <!-- 검색을 했을때 -->
		            <c:if test="${sel != null && search != null}">
			            <c:if test="${startPage > pageBlock}">
			               <a href="/petBill/admin/adNoticeList.pet?pageNum=${startPage-pageBlock}&sel=${sel}&search=${search}" class="page-link"> &lt;</a>
			            </c:if>
			            <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			               <a href="/petBill/admin/adNoticeList.pet?pageNum=${i}&sel=${sel}&search=${search}" class="page-link">${i}</a>
			            </c:forEach>
			            <c:if test="${endPage < pageCount}">
			               <a href="/petBill/admin/adNoticeList.pet?pageNum=${startPage+pageBlock}&sel=${sel}&search=${search}" class="page-link"> &gt; </a>
			            </c:if>
		            </c:if>
		            
			        <%-- 검색 안했을때 페이지번호들   --%> 
					<c:if test="${sel == null || search == null}">
			            <c:if test="${startPage > pageBlock}">
			               <a href="/petBill/admin/adNoticeList.pet?pageNum=${startPage-pageBlock}" class="page-link"> &lt;</a>
			            </c:if>
			            <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			               <a href="/petBill/admin/adNoticeList.pet?pageNum=${i}" class="page-link">${i}</a>
			            </c:forEach>
			            <c:if test="${endPage < pageCount}">
			               <a href="/petBill/admin/adNoticeList.pet?pageNum=${startPage+pageBlock}" class="page-link"> &gt; </a>
			            </c:if>
			        	 </c:if>
			         </c:if>
		         
					</div>
		
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
