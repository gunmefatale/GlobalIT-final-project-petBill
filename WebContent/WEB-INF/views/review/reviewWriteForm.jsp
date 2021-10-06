<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
    <!-- footer css -->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">	

<script type="text/javascript">
function changes(fr) {
    if(fr=="dog") {
    //뿌려줄값을 배열로정렬
    num = new Array("종합검진", "혈액검사", "초음파 검사",
    		"X-ray 검사", "알러지 검사", "심장사상충 키트", "기본 신체검사", "1차(종합백신 + 코로나)",
    		"2차(종합백신 + 코로나)", "3차(종합백신 + 켄넬코프)", "4차(종합백신 + 켄넬코프)", "5차(종합백신 + 인플루엔자)",
    		"6차(광견병 + 인플루엔자)", "심장사상충 예방약", "항체가 검사", "추가 접종", "방광결석", "요도결석",
    		"유선종양", "자궁축농증", "기타종양", "다리검진", "슬개골탈구", "대퇴골두", "전십자인대", "구토",
    		"설사", "혈변/혈뇨", "기본진료", "안과진료", "체리아이", "중성화수술(남아)", "중성화수술(여아)", "스케일링",
    		"전발치 수술", "유치 발치", "치과진료", "영구치 발치", "탈장", "피부진료");
    
    vnum = new Array("dAllTest","dBloodTest","dUltrasonicWave",
    		"dXray", "dAllergy", "dHeartbugKit", "dBasicPhysicalTest", "d1",
    		"d2", "d3", "d4", "d5",
    		"d6", "dCIPM", "dAntibodyTest", "dBoosterVcc", "dBladderStone", "dYodoStone",
    		"dBreastTumor", "dPyometra", "dEtcTumors", "dLegTest", "dPatellaDislocation", "dFemoralHead", "dACL", "dThrowUp",
    		"dDiarrhea", "dBloodPoop", "dBasicCare", "dEyeCare", "dCherryEye", "dTNRM", "dTNRW", "dScaling",
    		"dAllTooth", "dMilkTooth", "dDentalCare", "dForeverTooth", "dHernia", "dSkinCare");
    
   } else if(fr=="cat") {
     num = new Array("종합검진", "혈액검사", "초음파 검사",
    		 "X-ray 검사", "알러지 검사", "심장사상충 키트", "기본 신체검사",
    		 "PCR 검사", "방광결석", "요도결석", "1차 예방접종",
    		 "2차 예방접종", "3차 예방접종", "심장사상충 예방약", "항체가 검사", "추가 접종",
    		 "광견병 접종", "유선 종양", "자궁축농증", "기타 종양", "다리 검진", "슬개골 탈구",
    		 "대퇴골두", "전십자인대", "구토", "설사", "혈변/혈뇨", "기본진료", "안과진료",
    		 "체리아이", "중성화수술(남아)", "중성화수술(여아)", "스케일링", "전발치 수술", 
    		 "유치 발치", "치과진료", "영구치 발치", "탈장", "피부진료");
     
    vnum = new Array("cAllTest","cBloodTest","cUltrasonography",
    		"cXray", "cAllergy", "cHeartbugKit", "cBasicPhysicalTest",
    		"cPCR", "cBladderStone", "cYodoStone", "c1",
 			"c2", "c3", "cCIPM", "cAntibodyTest", "cBoosterVcc",
    		"cRabies", "cBreastTumor", "cPyometra", "cEtcTumors", "cLegTest", "cPatellaDislocation",
    		"cFemoralHead", "cACL", "cThrowUp", "cDiarrhea", "cBloodPoop", "cBasicCare", "cEyeCare",
    		"cCherryEye", "cTNRM", "cTNRW", "cScaling", "cAllTooth",
    		"cMilkTooth", "cDentalCare", "cForeverTooth", "cHernia", "cSkinCare");
    }
    // 셀렉트안의 리스트를 기본값으로 한다..
 	 for(i=0; i<form.reviewArticle.length; i++) {
    form.reviewArticle.options[0] = null;
  }
   //포문을 이용하여 두번째(test2)셀렉트 박스에 값을 뿌려줍니당)
  	for(i=0;i < num.length;i++) {
    document.form.reviewArticle.options[i] = new Option(num[i],vnum[i]);
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
               	<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/search/mapMain.pet?petType=${param.petType}">지도 병원검색</a> 
				<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/search/searchResult.pet?pageNum=1&petType=${param.petType}">시/도 병원검색</a> 
				<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/hospital/hosCompare.pet?petType=${param.petType}">병원 비교하기</a> 
				<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/petBill/admin/noticeList.pet?petType=${param.petType}">공지사항</a>
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
	                        	
	                        <li>
								<%-- 위치 변경필요할듯 search(검색)form 조장님 수정부분 --%>
								<form action="/petBill/search/searchResult.pet">
									<input type="search" name="search" placeholder="병원명 입력"/>
									<input type="hidden" name="petType" value="${param.petType}"/>
									<input type="submit" value="검색" class="btn btn-secondary btn-sm"/>                 
								</form>
							</li>
					
	                        <li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
	                        <li class="nav-item"><a class="nav-link" href="/petBill/user/userMypage.pet">마이페이지</a></li>
	                      </ul>
                      </div>
                 </div>
            </nav>
            
            
           	<!-- 페이지 내용작성 영역 : Page content-->
            <div class="container-fluid" align="center" style="white-space:nowrap; overflow:auto;">
			
			<br />
			<h3>리뷰 작성</h3>	
			<form action="/petBill/review/reviewWritePro.pet" name="form" method="Post" enctype="multipart/form-data" >
				<input type="hidden" name="reviewHosNo" value="${hosNo}" />
				<input type="hidden" name="pageNum" value="${pageNum}" />
				<input type="hidden" name="petType" value="${petType}" />
				<input type="hidden" name="hosSi" value="${hosSi}" />
				<input type="hidden" name="hosGu" value="${hosGu}" />
				<input type="hidden" name="diagnosis" value="${diagnosis}" />
			<br/>
			<table class="table table-bordered" style="width: 450px;">
				<tr>
					<th class="table-light">제 목</th>
					<th><input type="text" name="reviewSubject" required autofocus/></th>
				</tr>
				<tr>
					<th class="table-light">작성자</th>
					<td><input type="text" name="reviewId" value="${dto.nickname}" class="form-control-plaintext" readonly/></td>
				</tr>
				<tr>
					<th class="table-light">강아지/고양이(필수)</th>
					<td><select name="reviewPetType" onchange="changes(document.form.reviewPetType.value)">
							<option value="dog">강아지</option>
							<option value="cat">고양이</option>
						</select>
					</td>			
				</tr>
				<tr>
					<th class="table-light">진단명</th>
					<td><select name="reviewArticle">
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
					</td>			
				</tr>
				<tr>
					<th class="table-light">사진첨부</th>
					<td>
						<input type="file" name="reviewPhoto" />
					</td>
				</tr>
				<tr>
					<th class="table-light">진료비용</th>
					<td><input type="number" name="reviewPrice" required="required"/> 원</td>
				</tr>
				<tr>
					<th class="table-light">진료 후기</th>
					<td><textarea name="reviewContent" cols="50" rows="10"></textarea>
					</td>
				</tr>
			</table>
				<input type="submit" value="등록" class="btn btn-primary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="재작성" class="btn btn-secondary" style="width:100pt;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" onclick= "window.location='/petBill/hospital/hosContent.pet?pageNum=${pageNum}&petType=${petType}&hosNo=${hosNo}&hosSi=${hosSi}&hosGu=${hosGu}&diagnosis=${diagnosis}'" value="취소" class="btn btn-dark" style="width:100pt;"/>
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
	
<footer>
</footer>


</body>
</html>