<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
    <!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function del(){
	
	var result = confirm("정말 삭제하시겠습니까?");
	
	if(result){
		// 확인 선택시 처리
    	window.location='/petBill/review/reviewDeletePro.pet?reviewNo=${review.reviewNo}&pageNum=${pageNum}&reviewHosNo=${review.reviewHosNo}';
    	
	}
}
</script>

</head>
 <c:if test="${sessionScope.userId ne 'admin'}"><!--일반유저 마이페이지 수정,삭제-->
  <body>
   <div class="d-flex" id="wrapper">
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
            
        <!-- 페이지 내용작성 영역 : Page content-->
        <div class="container-fluid"  align="center" style="white-space:nowrap; overflow:auto;">
        
		<br />
		<h3>리 뷰</h3>	
		<form action="/petBill/review/reviewModifyPro.pet?reviewNo=${review.reviewNo}&reviewPhoto=${review.reviewPhoto}" method="Post" enctype="multipart/form-data" >
		<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
		<br/>
			<table class="table table-bordered" style="width: 610px;">
				<tr>
					<th class="table-light">제 목</th>
					<td><input type="text" name="reviewSubject" value="${review.reviewSubject}" required="required"/></td>
				</tr>
				<tr>
					<th class="table-light">작성자</th>
					<td><input type="text" value="${review.reviewId}" class="form-control-plaintext" disabled/></td>
				</tr>
				<tr>
					<th class="table-light">강아지/고양이(필수)</th>
					<td><c:if test="${review.reviewPetType eq 'dog'}">강아지</c:if>
						<c:if test="${review.reviewPetType eq 'cat'}">고양이</c:if>
					</td>	
				</tr>
				<tr>
					<th class="table-light">진단명</th>
					<td><c:if test="${review.reviewPetType eq 'dog'}">
						<select name="reviewArticle" required="required">
							<option value="dAllTest" <c:if test="${review.reviewArticle eq 'dAllTest'}">selected</c:if>>종합검진</option>
							<option value="dBloodTest" <c:if test="${review.reviewArticle eq 'dBloodTest'}">selected</c:if>>혈액검사</option>
							<option value="dUltrasonicWave" <c:if test="${review.reviewArticle eq 'dUltrasondicWave'}">selected</c:if>>초음파 검사</option>
							<option value="dXray" <c:if test="${review.reviewArticle eq 'dXray'}">selected</c:if>>X-ray 검사</option>
							<option value="dAllergy" <c:if test="${review.reviewArticle eq 'dAllergy'}">selected</c:if>>알러지 검사</option>
							<option value="dHeartbugKit" <c:if test="${review.reviewArticle eq 'dHeartbugKit'}">selected</c:if>>심장사상충 키트</option>
							<option value="dBasicPhysicalTest" <c:if test="${review.reviewArticle eq 'dBasicPhysicalTest'}">selected</c:if>>기본 신체검사</option>
							<option value="d1" <c:if test="${review.reviewArticle eq 'd1'}">selected</c:if>>1차(종합백신 + 코로나)</option>
							<option value="d2" <c:if test="${review.reviewArticle eq 'd2'}">selected</c:if>>2차(종합백신 + 코로나)</option>
							<option value="d3" <c:if test="${review.reviewArticle eq 'd3'}">selected</c:if>>3차(종합백신 + 켄넬코프)</option>
							<option value="d4" <c:if test="${review.reviewArticle eq 'd4'}">selected</c:if>>4차(종합백신 + 켄넬코프)</option>
							<option value="d5" <c:if test="${review.reviewArticle eq 'd5'}">selected</c:if>>5차(종합백신 + 인플루엔자)</option>
							<option value="d6" <c:if test="${review.reviewArticle eq 'd6'}">selected</c:if>>6차(광견병 + 인플루엔자)</option>
							<option value="dCIPM" <c:if test="${review.reviewArticle eq 'dCIPM'}">selected</c:if>>심장사상충 예방약</option>
							<option value="dAntibodyTest" <c:if test="${review.reviewArticle eq 'dAntibodyTest'}">selected</c:if>>항체가 검사</option>
							<option value="dBoosterVcc" <c:if test="${review.reviewArticle eq 'dBoosterVcc'}">selected</c:if>>추가 접종</option>
							<option value="dBladderStone" <c:if test="${review.reviewArticle eq 'dBladderStone'}">selected</c:if>>방광결석</option>
							<option value="dYodoStone" <c:if test="${review.reviewArticle eq 'dYodoStone'}">selected</c:if>>요도결석</option>
							<option value="dBreastTumor" <c:if test="${review.reviewArticle eq 'dBreastTumor'}">selected</c:if>>유선종양</option>
							<option value="dPyometra" <c:if test="${review.reviewArticle eq 'dPyometra'}">selected</c:if>>자궁축농증</option>
							<option value="dEtcTumors" <c:if test="${review.reviewArticle eq 'dEtcTumors'}">selected</c:if>>기타종양</option>
							<option value="dLegTest" <c:if test="${review.reviewArticle eq 'dLegTest'}">selected</c:if>>다리검진</option>
							<option value="dPatellaDislocation" <c:if test="${review.reviewArticle eq 'dPatellaDisLocation'}">selected</c:if>>슬개골탈구</option>
							<option value="dFemoralHead" <c:if test="${review.reviewArticle eq 'dFemoralHead'}">selected</c:if>>대퇴골두</option>
							<option value="dACL" <c:if test="${review.reviewArticle eq 'dACL'}">selected</c:if>>전십자인대</option>
							<option value="dThrowUp" <c:if test="${review.reviewArticle eq 'dThrowUp'}">selected</c:if>>구토</option>
							<option value="dDiarrhea" <c:if test="${review.reviewArticle eq 'dDiarrhea'}">selected</c:if>>설사</option>
							<option value="dBloodPoop" <c:if test="${review.reviewArticle eq 'dBloodpoop'}">selected</c:if>>혈변/혈뇨</option>
							<option value="dBasicCare" <c:if test="${review.reviewArticle eq 'dBasicCare'}">selected</c:if>>기본진료</option>
							<option value="dEyeCare" <c:if test="${review.reviewArticle eq 'dEyeCare'}">selected</c:if>>안과진료</option>
							<option value="dCherryEye" <c:if test="${review.reviewArticle eq 'dCherryEye'}">selected</c:if>>체리아이</option>
							<option value="dTNRM" <c:if test="${review.reviewArticle eq 'dTNRM'}">selected</c:if>>중성화수술(남아)</option>
							<option value="dTNRW" <c:if test="${review.reviewArticle eq 'dTNRW'}">selected</c:if>>중성화수술(여아)</option>
							<option value="dScaling" <c:if test="${review.reviewArticle eq 'dScaling'}">selected</c:if>>스케일링</option>
							<option value="dAllTooth" <c:if test="${review.reviewArticle eq 'dAllTooth'}">selected</c:if>>전발치 수술</option>
							<option value="dMilkTooth" <c:if test="${review.reviewArticle eq 'dMilkTooth'}">selected</c:if>>유치 발치</option>
							<option value="dDentalCare" <c:if test="${review.reviewArticle eq 'dDentalCare'}">selected</c:if>>치과진료</option>
							<option value="dForeverTooth" <c:if test="${review.reviewArticle eq 'dForeverTooth'}">selected</c:if>>영구치 발치</option>
							<option value="dHernia" <c:if test="${review.reviewArticle eq 'dHernia'}">selected</c:if>>탈장</option>
							<option value="dSkinCare" <c:if test="${review.reviewArticle eq 'dSkinCare'}">selected</c:if>>피부 진료</option>
						</select>
					 </c:if>
					 <c:if test="${review.reviewPetType eq 'cat'}">
				 		<select name="reviewArticle">
							<option value="cAllTest" <c:if test="${review.reviewArticle eq 'cAllTest'}">selected</c:if>>종합검진</option>
							<option value="cBloodTest" <c:if test="${review.reviewArticle eq 'cBloodTest'}">selected</c:if>>혈액 검사</option>
							<option value="cUltrasonography" <c:if test="${review.reviewArticle eq 'cUltrasonography'}">selected</c:if>>초음파 검사</option>
							<option value="cXray" <c:if test="${review.reviewArticle eq 'cXray'}">selected</c:if>>X-ray 검사</option>
							<option value="cAllergy" <c:if test="${review.reviewArticle eq 'cAllergy'}">selected</c:if>>알러지 검사</option>
							<option value="cHeartbugKit" <c:if test="${review.reviewArticle eq 'cHeartbugKit'}">selected</c:if>>심장사상충키트</option>
							<option value="cBasicPhysicalTest" <c:if test="${review.reviewArticle eq 'cBasicPhysicalTest'}">selected</c:if>>기본 신체검사</option>
							<option value="cPCR" <c:if test="${review.reviewArticle eq 'cPCR'}">selected</c:if>>PCR 검사</option>
							<option value="cBladderStone" <c:if test="${review.reviewArticle eq 'cBladderStone'}">selected</c:if>>방광결석</option>
							<option value="cYodoStone" <c:if test="${review.reviewArticle eq 'cYodoStone'}">selected</c:if>>요도결석</option>
							<option value="c1" <c:if test="${review.reviewArticle eq 'c1'}">selected</c:if>>1차</option>
							<option value="c2" <c:if test="${review.reviewArticle eq 'c2'}">selected</c:if>>2차</option>
							<option value="c3" <c:if test="${review.reviewArticle eq 'c3'}">selected</c:if>>3차</option>
							<option value="cCIPM" <c:if test="${review.reviewArticle eq 'cCIPM'}">selected</c:if>>심장사상충 예방약</option>
							<option value="cAntibodyTest" <c:if test="${review.reviewArticle eq 'cAntibodyTest'}">selected</c:if>>항체가검사</option>
							<option value="cBoosterVcc" <c:if test="${review.reviewArticle eq 'cBoosterVcc'}">selected</c:if>>추가 접종</option>
							<option value="cRabies" <c:if test="${review.reviewArticle eq 'cRabies'}">selected</c:if>>광견병 접종</option>
							<option value="cBreastTumor" <c:if test="${review.reviewArticle eq 'cBreastTumor'}">selected</c:if>>유선 종양</option>
							<option value="cPyometra" <c:if test="${review.reviewArticle eq 'cPyometra'}">selected</c:if>>자궁축농증</option>
							<option value="cEtcTumors" <c:if test="${review.reviewArticle eq 'cEtcTumors'}">selected</c:if>>기타 종양</option>
							<option value="cLegTest" <c:if test="${review.reviewArticle eq 'cLegTest'}">selected</c:if>>다리 검진</option>
							<option value="cPatellaDislocation" <c:if test="${review.reviewArticle eq 'cPatellaDisLocation'}">selected</c:if>>슬개골 탈구</option>
							<option value="cFemoralHead" <c:if test="${review.reviewArticle eq 'cFemoralHead'}">selected</c:if>>대퇴골두</option>
							<option value="cACL" <c:if test="${review.reviewArticle eq 'cACL'}">selected</c:if>>전십자인대</option>
							<option value="cThrowUp" <c:if test="${review.reviewArticle eq 'cThrowUp'}">selected</c:if>>구토</option>
							<option value="cDiarrhea" <c:if test="${review.reviewArticle eq 'cDiarrhea'}">selected</c:if>>설사</option>
							<option value="cBloodPoop" <c:if test="${review.reviewArticle eq 'cBloodPoop'}">selected</c:if>>혈변/혈뇨</option>
							<option value="cBasicCare" <c:if test="${review.reviewArticle eq 'cBasicCare'}">selected</c:if>>기본 진료</option>
							<option value="cEyeCare" <c:if test="${review.reviewArticle eq 'cEyeCare'}">selected</c:if>>안과진료</option>
							<option value="cCherryEye" <c:if test="${review.reviewArticle eq 'cCherryEye'}">selected</c:if>>체리아이</option>
							<option value="cTNRM" <c:if test="${review.reviewArticle eq 'cTNRM'}">selected</c:if>>중성화수술(남아)</option>
							<option value="cTNRW" <c:if test="${review.reviewArticle eq 'cTNRW'}">selected</c:if>>중성화수술(여아)</option>
							<option value="cScaling" <c:if test="${review.reviewArticle eq 'cScaling'}">selected</c:if>>스케일링</option>
							<option value="cAllTooth" <c:if test="${review.reviewArticle eq 'cAllTooth'}">selected</c:if>>전발치 수술</option>
							<option value="cMilkTooth" <c:if test="${review.reviewArticle eq 'cMilkTooth'}">selected</c:if>>유치 발치</option>
							<option value="cDentalCare" <c:if test="${review.reviewArticle eq 'cDentalCare'}">selected</c:if>>치과진료</option>
							<option value="cForeverTooth" <c:if test="${review.reviewArticle eq 'cForeverTooth'}">selected</c:if>>영구치 발치</option>
							<option value="cHernia" <c:if test="${review.reviewArticle eq 'cHernia'}">selected</c:if>>탈장</option>
							<option value="cSkinCare" <c:if test="${review.reviewArticle eq 'cSkinCare'}">selected</c:if>>피부진료</option>
						</select>
					 </c:if>
					</td>			
				</tr>
				<tr>
					<th class="table-light">사진첨부</th>
					<td>
						<c:if test="${review.reviewPhoto == null}">
							<img src="/petBill/resources/imgs/리뷰 이미지1.png" width="100" />
						</c:if>
						<c:if test="${review.reviewPhoto != null}">
							<img src="/petBill/photo/${review.reviewPhoto}" width="150" />
						</c:if>
						<input type="file" name="reviewPhoto" />
						<input type="hidden" name="reviewPhoto" value="${review.reviewPhoto}">
					</td>
				</tr>
				<tr>
					<th class="table-light">진료비용</th>
					<td><input type="number" name="reviewPrice" value="${review.reviewPrice}" required="required"/>원</td>
				</tr>
				<tr>
					<th class="table-light">진료 후기</th>
					<td><textarea name="reviewContent" cols="50" rows="10">${review.reviewContent}</textarea>
					</td>
				</tr>
			</table>
				<input type="submit" value="수정" class="btn btn-primary"/>&nbsp;&nbsp;
				<input type="reset" value="재작성" class="btn btn-secondary"/>&nbsp;&nbsp;
				<input type="button" onclick="del()" value="삭제" class="btn btn-secondary"/>&nbsp;&nbsp;
				<input type="button" onclick= "window.location='/petBill/user/userReviewList.pet?pageNum=${pageNum}'" value="취소" class="btn btn-dark"/>
		</form>
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
</c:if>


<!-- ------------------------------------------------------------------------------------ -->

<c:if test="${sessionScope.userId eq 'admin'}"><!-- 관리자 리뷰삭제 -->
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
        
        <!-- 페이지 내용작성 영역 : Page content-->
        <div class="container-fluid" align="center">
		<br />
		<h3>회원 리뷰</h3>
		<form action="/petBill/review/reviewModifyPro.pet?reviewNo=${review.reviewNo}&reviewPhoto=${review.reviewPhoto}" method="Post" enctype="multipart/form-data" >
		<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
		<br/>
			<table class="table table-bordered" style="width: 610px;">
				<tr>
					<th class="table-light">제 목</th>
					<td><%-- <input type="text" name="reviewSubject" value="${review.reviewSubject}" disabled="disabled"/> --%>
					${review.reviewSubject}</td>
				</tr>
				<tr>
					<th class="table-light">작성자</th>
					<td><%-- <input type="text" value="${review.reviewId}" disabled="disabled"/> --%>
					${review.reviewId}</td>
				</tr>
				<tr>
					<th class="table-light">강아지/고양이(필수)</th>
					<td><c:if test="${review.reviewPetType eq 'dog'}">강아지</c:if>
						<c:if test="${review.reviewPetType eq 'cat'}">고양이</c:if>
					</td>	
				</tr>
				<tr>
					<th class="table-light">진단명</th>
					<td><c:if test="${review.reviewPetType eq 'dog'}">
						<select name="reviewArticle" disabled="disabled">
							<option value="dAllTest" <c:if test="${review.reviewArticle eq 'dAllTest'}">selected</c:if>>종합검진</option>
							<option value="dBloodTest" <c:if test="${review.reviewArticle eq 'dBloodTest'}">selected</c:if>>혈액검사</option>
							<option value="dUltrasonicWave" <c:if test="${review.reviewArticle eq 'dUltrasondicWave'}">selected</c:if>>초음파 검사</option>
							<option value="dXray" <c:if test="${review.reviewArticle eq 'dXray'}">selected</c:if>>X-ray 검사</option>
							<option value="dAllergy" <c:if test="${review.reviewArticle eq 'dAllergy'}">selected</c:if>>알러지 검사</option>
							<option value="dHeartbugKit" <c:if test="${review.reviewArticle eq 'dHeartbugKit'}">selected</c:if>>심장사상충 키트</option>
							<option value="dBasicPhysicalTest" <c:if test="${review.reviewArticle eq 'dBasicPhysicalTest'}">selected</c:if>>기본 신체검사</option>
							<option value="d1" <c:if test="${review.reviewArticle eq 'd1'}">selected</c:if>>1차(종합백신 + 코로나)</option>
							<option value="d2" <c:if test="${review.reviewArticle eq 'd2'}">selected</c:if>>2차(종합백신 + 코로나)</option>
							<option value="d3" <c:if test="${review.reviewArticle eq 'd3'}">selected</c:if>>3차(종합백신 + 켄넬코프)</option>
							<option value="d4" <c:if test="${review.reviewArticle eq 'd4'}">selected</c:if>>4차(종합백신 + 켄넬코프)</option>
							<option value="d5" <c:if test="${review.reviewArticle eq 'd5'}">selected</c:if>>5차(종합백신 + 인플루엔자)</option>
							<option value="d6" <c:if test="${review.reviewArticle eq 'd6'}">selected</c:if>>6차(광견병 + 인플루엔자)</option>
							<option value="dCIPM" <c:if test="${review.reviewArticle eq 'dCIPM'}">selected</c:if>>심장사상충 예방약</option>
							<option value="dAntibodyTest" <c:if test="${review.reviewArticle eq 'dAntibodyTest'}">selected</c:if>>항체가 검사</option>
							<option value="dBoosterVcc" <c:if test="${review.reviewArticle eq 'dBoosterVcc'}">selected</c:if>>추가 접종</option>
							<option value="dBladderStone" <c:if test="${review.reviewArticle eq 'dBladderStone'}">selected</c:if>>방광결석</option>
							<option value="dYodoStone" <c:if test="${review.reviewArticle eq 'dYodoStone'}">selected</c:if>>요도결석</option>
							<option value="dBreastTumor" <c:if test="${review.reviewArticle eq 'dBreastTumor'}">selected</c:if>>유선종양</option>
							<option value="dPyometra" <c:if test="${review.reviewArticle eq 'dPyometra'}">selected</c:if>>자궁축농증</option>
							<option value="dEtcTumors" <c:if test="${review.reviewArticle eq 'dEtcTumors'}">selected</c:if>>기타종양</option>
							<option value="dLegTest" <c:if test="${review.reviewArticle eq 'dLegTest'}">selected</c:if>>다리검진</option>
							<option value="dPatellaDislocation" <c:if test="${review.reviewArticle eq 'dPatellaDisLocation'}">selected</c:if>>슬개골탈구</option>
							<option value="dFemoralHead" <c:if test="${review.reviewArticle eq 'dFemoralHead'}">selected</c:if>>대퇴골두</option>
							<option value="dACL" <c:if test="${review.reviewArticle eq 'dACL'}">selected</c:if>>전십자인대</option>
							<option value="dThrowUp" <c:if test="${review.reviewArticle eq 'dThrowUp'}">selected</c:if>>구토</option>
							<option value="dDiarrhea" <c:if test="${review.reviewArticle eq 'dDiarrhea'}">selected</c:if>>설사</option>
							<option value="dBloodPoop" <c:if test="${review.reviewArticle eq 'dBloodpoop'}">selected</c:if>>혈변/혈뇨</option>
							<option value="dBasicCare" <c:if test="${review.reviewArticle eq 'dBasicCare'}">selected</c:if>>기본진료</option>
							<option value="dEyeCare" <c:if test="${review.reviewArticle eq 'dEyeCare'}">selected</c:if>>안과진료</option>
							<option value="dCherryEye" <c:if test="${review.reviewArticle eq 'dCherryEye'}">selected</c:if>>체리아이</option>
							<option value="dTNRM" <c:if test="${review.reviewArticle eq 'dTNRM'}">selected</c:if>>중성화수술(남아)</option>
							<option value="dTNRW" <c:if test="${review.reviewArticle eq 'dTNRW'}">selected</c:if>>중성화수술(여아)</option>
							<option value="dScaling" <c:if test="${review.reviewArticle eq 'dScaling'}">selected</c:if>>스케일링</option>
							<option value="dAllTooth" <c:if test="${review.reviewArticle eq 'dAllTooth'}">selected</c:if>>전발치 수술</option>
							<option value="dMilkTooth" <c:if test="${review.reviewArticle eq 'dMilkTooth'}">selected</c:if>>유치 발치</option>
							<option value="dDentalCare" <c:if test="${review.reviewArticle eq 'dDentalCare'}">selected</c:if>>치과진료</option>
							<option value="dForeverTooth" <c:if test="${review.reviewArticle eq 'dForeverTooth'}">selected</c:if>>영구치 발치</option>
							<option value="dHernia" <c:if test="${review.reviewArticle eq 'dHernia'}">selected</c:if>>탈장</option>
							<option value="dSkinCare" <c:if test="${review.reviewArticle eq 'dSkinCare'}">selected</c:if>>피부 진료</option>
						</select>
					 </c:if>
					
					 <c:if test="${review.reviewPetType eq 'cat'}">
				 		<select name="reviewArticle" disabled="disabled">
							<option value="cAllTest" <c:if test="${review.reviewArticle eq 'cAllTest'}">selected</c:if>>종합검진</option>
							<option value="cBloodTest" <c:if test="${review.reviewArticle eq 'cBloodTest'}">selected</c:if>>혈액 검사</option>
							<option value="cUltrasonography" <c:if test="${review.reviewArticle eq 'cUltrasonography'}">selected</c:if>>초음파 검사</option>
							<option value="cXray" <c:if test="${review.reviewArticle eq 'cXray'}">selected</c:if>>X-ray 검사</option>
							<option value="cAllergy" <c:if test="${review.reviewArticle eq 'cAllergy'}">selected</c:if>>알러지 검사</option>
							<option value="cHeartbugKit" <c:if test="${review.reviewArticle eq 'cHeartbugKit'}">selected</c:if>>심장사상충키트</option>
							<option value="cBasicPhysicalTest" <c:if test="${review.reviewArticle eq 'cBasicPhysicalTest'}">selected</c:if>>기본 신체검사</option>
							<option value="cPCR" <c:if test="${review.reviewArticle eq 'cPCR'}">selected</c:if>>PCR 검사</option>
							<option value="cBladderStone" <c:if test="${review.reviewArticle eq 'cBladderStone'}">selected</c:if>>방광결석</option>
							<option value="cYodoStone" <c:if test="${review.reviewArticle eq 'cYodoStone'}">selected</c:if>>요도결석</option>
							<option value="c1" <c:if test="${review.reviewArticle eq 'c1'}">selected</c:if>>1차</option>
							<option value="c2" <c:if test="${review.reviewArticle eq 'c2'}">selected</c:if>>2차</option>
							<option value="c3" <c:if test="${review.reviewArticle eq 'c3'}">selected</c:if>>3차</option>
							<option value="cCIPM" <c:if test="${review.reviewArticle eq 'cCIPM'}">selected</c:if>>심장사상충 예방약</option>
							<option value="cAntibodyTest" <c:if test="${review.reviewArticle eq 'cAntibodyTest'}">selected</c:if>>항체가검사</option>
							<option value="cBoosterVcc" <c:if test="${review.reviewArticle eq 'cBoosterVcc'}">selected</c:if>>추가 접종</option>
							<option value="cRabies" <c:if test="${review.reviewArticle eq 'cRabies'}">selected</c:if>>광견병 접종</option>
							<option value="cBreastTumor" <c:if test="${review.reviewArticle eq 'cBreastTumor'}">selected</c:if>>유선 종양</option>
							<option value="cPyometra" <c:if test="${review.reviewArticle eq 'cPyometra'}">selected</c:if>>자궁축농증</option>
							<option value="cEtcTumors" <c:if test="${review.reviewArticle eq 'cEtcTumors'}">selected</c:if>>기타 종양</option>
							<option value="cLegTest" <c:if test="${review.reviewArticle eq 'cLegTest'}">selected</c:if>>다리 검진</option>
							<option value="cPatellaDislocation" <c:if test="${review.reviewArticle eq 'cPatellaDisLocation'}">selected</c:if>>슬개골 탈구</option>
							<option value="cFemoralHead" <c:if test="${review.reviewArticle eq 'cFemoralHead'}">selected</c:if>>대퇴골두</option>
							<option value="cACL" <c:if test="${review.reviewArticle eq 'cACL'}">selected</c:if>>전십자인대</option>
							<option value="cThrowUp" <c:if test="${review.reviewArticle eq 'cThrowUp'}">selected</c:if>>구토</option>
							<option value="cDiarrhea" <c:if test="${review.reviewArticle eq 'cDiarrhea'}">selected</c:if>>설사</option>
							<option value="cBloodPoop" <c:if test="${review.reviewArticle eq 'cBloodPoop'}">selected</c:if>>혈변/혈뇨</option>
							<option value="cBasicCare" <c:if test="${review.reviewArticle eq 'cBasicCare'}">selected</c:if>>기본 진료</option>
							<option value="cEyeCare" <c:if test="${review.reviewArticle eq 'cEyeCare'}">selected</c:if>>안과진료</option>
							<option value="cCherryEye" <c:if test="${review.reviewArticle eq 'cCherryEye'}">selected</c:if>>체리아이</option>
							<option value="cTNRM" <c:if test="${review.reviewArticle eq 'cTNRM'}">selected</c:if>>중성화수술(남아)</option>
							<option value="cTNRW" <c:if test="${review.reviewArticle eq 'cTNRW'}">selected</c:if>>중성화수술(여아)</option>
							<option value="cScaling" <c:if test="${review.reviewArticle eq 'cScaling'}">selected</c:if>>스케일링</option>
							<option value="cAllTooth" <c:if test="${review.reviewArticle eq 'cAllTooth'}">selected</c:if>>전발치 수술</option>
							<option value="cMilkTooth" <c:if test="${review.reviewArticle eq 'cMilkTooth'}">selected</c:if>>유치 발치</option>
							<option value="cDentalCare" <c:if test="${review.reviewArticle eq 'cDentalCare'}">selected</c:if>>치과진료</option>
							<option value="cForeverTooth" <c:if test="${review.reviewArticle eq 'cForeverTooth'}">selected</c:if>>영구치 발치</option>
							<option value="cHernia" <c:if test="${review.reviewArticle eq 'cHernia'}">selected</c:if>>탈장</option>
							<option value="cSkinCare" <c:if test="${review.reviewArticle eq 'cSkinCare'}">selected</c:if>>피부진료</option>
						</select>
					 </c:if>
					</td>			
				</tr>
				<tr>
					<th class="table-light">사진첨부</th>
					<td>
						<c:if test="${review.reviewPhoto == null}">
							<img src="/petBill/resources/imgs/리뷰 이미지1.png" width="100" />
						</c:if>
						<c:if test="${review.reviewPhoto != null}">
							<img src="/petBill/photo/${review.reviewPhoto}" width="150" />
						</c:if>
					</td>
				</tr>
				<tr>
					<th class="table-light">진료비용</th>
					<td>${review.reviewPrice} 원</td>
				</tr>
				<tr>
					<th class="table-light">진료 후기</th>
					<td><textarea name="reviewContent" cols="50" rows="10" disabled="disabled">${review.reviewContent}</textarea>
					</td>
				</tr>
			</table>
			<c:if test="${sel == null || search == null }">
			<input type="button" onclick="del()" value="삭제" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onclick= "window.location='/petBill/admin/adReviewStatus.pet?&pageNum=${pageNum}'" value="취소" class="btn btn-dark" style="width:100pt;"/>
			</c:if>
			<c:if test="${sel != null || search != null }">
			<input type="button" onclick="del()" value="삭제" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onclick= "window.location='/petBill/admin/adReviewStatus.pet?&pageNum=${pageNum}&sel=${sel}&search=${search}'" value="취소" class="btn btn-dark" style="width:100pt;"/>
			</c:if>
		</form>
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
</c:if>
</html>