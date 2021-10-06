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
    <title>병원비교</title>
    
    <!-- jquery/ajax 사용시 라이브러리를 밑의 링크거는방식: cdm방식으로 추가 (인터넷 될 경우. 안되면 다운받아야함)-->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">

   	<!-- footer css -->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
    
    <!-- 네이버 클라우드 플랫폼 네이버지도 api 사용 : 여기서 세팅해줘야 바로 ajax 호출과 동시에 지도가 뜸 -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=z0t072q98j"></script>
    
    <!-- chart 사용 : 여기서 세팅해줘야 바로 ajax 호출과 동시에 차트가 뜸-->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    
    <script type="text/javascript">
    	// 병원 입력시키는 새창
    	function selHospitalA(a){ //this.form 객체 받음
    		// 팝업띄우기
    		var url ="ajaxCompareA.pet";
    		open(url, "selHospitalA", "toolbar=no, location=no, status=no, menubar=no, resizable=no, width=1000, height=580");
    	}
    	function selHospitalB(b){ //this.form 객체 받음
    		// 팝업띄우기
    		var url ="ajaxCompareB.pet";
    		open(url, "selHospitalB", "toolbar=no, location=no, status=no, menubar=no, resizable=no, width=1000, height=580");
    	}
    </script>
    <script type="text/javascript">	
    	// 진료명 select
    	$(function(){
		    petSelectMaker("#petType", "#mainArticle", "#diagnosis");
		});
		
		var petSelectMaker = function(a1, a2, a3){
		    if(a1 == null || a2 == null || a3 == null){
		        console.warn("값이 비었음");
		        return;
		    }
		    
		    var area = {
		        "강아지" :{
		            "검진검사" : ["종합검진", "혈액검사", "초음파검사", "X-ray검사", "알러지검사", "심장사상충키트검사", "기본신체검사"],
		            "강아지예방접종" : [ "1차(종합백신+코로나)", "2차(종합백신+코로나)", "3차(종합백신+켄넬코프)", "4차(종합백신+켄넬코프)", "5차(종합백신+인플루엔자)", "6차(광견병+인플루엔자)", "심장사상충예방약", "항체가검사", "추가접종"],
		            "결석" : ["방광결석", "요도결석"],
		            "기타" : ["유선종양", "자궁축농증", "기타종양"],
		            "다리" : ["다리검진", "슬개골탈구", "대퇴골두", "전십자인대"],
		            "단순증상" : ["구토", "설사", "혈변/혈뇨", "기본진료"],
		            "안과" : ["안과진료", "체리아이"],
		            "중성화수술" : ["중성화수술(남아)", "중성화수술(여아)"],
		            "치과" : ["스케일링", "전발치수술", "유치발치", "치과진료", "영구치발치"],
		            "탈장" : ["탈장"],
		            "피부과진료" : ["피부진료"]
		        },
		        "고양이" :{
		            "검진검사" : ["종합검진", "혈액검사", "초음파검사", "X-ray검사", "알러지검사", "심장사상충키트검사", "기본신체검사", "고양이PCR검사"],
		            "결석" : ["방광결석", "요도결석"],
		            "고양이예방접종" : ["1차접종", "2차접종", "3차접종", "심장사상충예방약", "항체가검사", "추가접종", "광견병접종"],
		            "기타" : ["유선종양", "자궁축농증", "기타종양"],
		            "다리" : ["다리검진", "슬개골탈구", "대퇴골두", "전십자인대"],
		            "단순증상" : ["구토", "설사", "혈변/혈뇨", "기본진료"],
		            "안과" : ["안과진료", "체리아이"],
		            "중성화수술" : ["중성화수술(남아)", "중성화수술(여아)"],
		            "치과" : ["스케일링", "전발치수술", "유치발치", "치과진료", "영구치발치"],
		            "탈장" : ["탈장"],
		            "피부과진료" : ["피부진료"]
		        }
		   	};
		    		
		    //초기화
		    init(true, true);
		
		    //권역 기본 생성
		    var areaKeys1 = Object.keys(area);
		    areaKeys1.forEach(function(petType){
		        $(a1).append("<option value="+petType+">"+petType+"</option>");
		    });
		
		    //변경 이벤트
		    $(document).on("change", a1, function(){
		        init(false, true);
		        var petType = $(this).val();
		        
		        var keys = Object.keys(area[petType]);
		        keys.forEach(function(mainArticle){
		            $(a2).append("<option value="+mainArticle+">"+mainArticle+"</option>");    
		        });
		    }).on("change", a2, function(){
		        init();
		        var petType = $(a1).val();
		        var mainArticle = $(this).val();
		        var keys = Object.keys(area[petType][mainArticle]);
		        keys.forEach(function(diagnosis){
		            $(a3).append("<option value="+area[petType][mainArticle][diagnosis]+">"+area[petType][mainArticle][diagnosis]+"</option>");    
		        });
		    });
		    
		    
		    function init(first, second){
		        first ? $(a1).empty().append("<option value=''>검색동물 선택</option>") : "";
		        second ? $(a2).empty().append("<option value=''>대분류</option>") : "";
		        $(a3).empty().append("<option value=''>소분류</option>");
		    }
		    
		}
	</script>
	
	<script type="text/javascript">
		// 진료비 비교 ajax
	    function ajaxAction() {
	   	  let petType = $("#petType").val(); // 값을 변수에 담아서
	   	  let diagnosis = $("#diagnosis").val(); // 값을 변수에 담아서
	   	  let aHospital = $("#aHospital").val(); // 값을 변수에 담아서
	   	  let bHospital = $("#bHospital").val(); // 값을 변수에 담아서
	   	  let hosNoA = $("#aHospitalNo").val(); // 값을 변수에 담아서(우선 string)
	   	  let hosNoB = $("#bHospitalNo").val(); // 값을 변수에 담아서(우선 string)
	         $.ajax({ // 설정하는 부분
	            url: 'http://localhost:8080/petBill/hospital/compareAB.pet', 
	            method:'get', 
	            data: {petType, diagnosis, hosNoA, hosNoB, aHospital, bHospital},// 위 변수에 담긴 데이터를 전송해준다
	        }).done(function(response){ // == success 랑 같은기능. 지금 error처리는 없는상태.
	            $('#compareAB').html(response); 
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
							
							<!-- 로그인 분기처리 -->
                                <c:if test="${sessionScope.userId eq 'admin'}">	
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
		                       		<li class="nav-item"><a class="nav-link" href="/petBill/admin/adMain.pet">관리자 페이지</a></li>
		                        </c:if>
                                <c:if test="${sessionScope.userId == null && sessionScope.kakaoId == null}">	
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/loginForm.pet">로그인</a></li>
		                       		<li class="nav-item"><a class="nav-link" href="/petBill/user/userSignupForm.pet">회원가입</a></li>
		                        </c:if>
		                        <c:if test="${sessionScope.kakaoId != null ||sessionScope.userId != null && sessionScope.userId ne 'admin'}">
		                        	<li class="nav-item active"><a class="nav-link" href="/petBill/user/logoutPro.pet">로그아웃</a></li>
		                       		<li class="nav-item"><a class="nav-link" href="/petBill/user/userMypage.pet">마이페이지</a></li>
		                        </c:if>	
	                        
	                        <li class="nav-item dropdown">
		                        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">검색동물 변경</a>
		                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="/petBill/hospital/hosCompare.pet?petType=${'dog'}&diagnosis=${'dAllTest'}">강아지</a>
                                    <a class="dropdown-item" href="/petBill/hospital/hosCompare.pet?petType=${'cat'}&diagnosis=${'cAllTest'}">고양이</a>
                                </div>
	                        </li>
	                      </ul>
							<c:if test="${param.petType eq 'dog'}">
                            	<img src="/petBill/resources/imgs/10.png" style="width: 50px; height: 50px">
                            </c:if>
                            <c:if test="${param.petType eq 'cat'}">
                            	<img src="/petBill/resources/imgs/11.png" style="width: 50px; height: 50px">
                            </c:if>	                      
                      </div>
                 </div>
            </nav>
                
  <!-- ================================================== 공통 메뉴 구분선 ========================================================== -->              
               
       <!-- 페이지 내용작성 영역 : Page content, overflow:auto; div가 넘치면 스크롤바 생성-->
        <div class="container-fluid" style="white-space:nowrap; overflow:auto;">
           	
       		<br />
       		<div align="center">
	           	<caption>
		          <div class="col-md-10 col-md-offset-1">
		            <div id="title">
		              <h3>병원 진료비 비교</h3>
			              <p class="lead">
			              	선택하신 병원의 리뷰 진료비 평균을 비교하실 수 있습니다.
			              </p>
		            </div>
		          </div>
		         </caption>
       			<table class="table">
       				<tr>
       					<td align="center">
					    	<input type="button" name="a" value="A병원 선택" onclick="selHospitalA(this.name)" class="btn btn-outline-dark"/> 
					    	&nbsp;&nbsp;
					    	<input type="text" class="form-control-plaintext" id="aHospital" readonly/>
					    	<input type="hidden" name="aHospitalNo" id="aHospitalNo"/>
						</td>
						<td align="center">
				       		<input type="button" name="b" value="B병원 선택" onclick="selHospitalB(this.name)" class="btn btn-outline-dark"/>
				       		&nbsp;&nbsp;
				       		<input type="text" class="form-control-plaintext" id="bHospital" readonly/>
				       		<input type="hidden" name="bHospitalNo" id="bHospitalNo"/>		
		       			</td>
		       		</tr>
		       		<tr align="center">
			       		<td colspan="2">
			       		<br />
				       		<select name="petType" id="petType"></select>
						    <select name="mainArticle" id="mainArticle"></select>
						    <select name="diagnosis" id="diagnosis"></select>&nbsp; 의 리뷰 진료비 평균
						<br /><br />
					       	<c:if test="${sessionScope.userId == null && sessionScope.kakaoId == null}">
				                <p class="lead">로그인 후 이용가능 합니다.</p>
				            </c:if>
				            <c:if test="${sessionScope.userId != null || sessionScope.kakaoId != null}">
				            	<div class="d-grid gap-2 col-6 mx-auto">
				               		<button class="btn btn-primary btn-lg" onclick="ajaxAction()"> 비교하기 </button>
				               	</div>
				               <br />
				            </c:if>
				       	</td>
				    </tr>
       			</table>
			</div>

	        <!-- ajax 평균 비교 뜨는 영역 -->
	        <div id="compareAB" class="divtest" align="center"> 
	        	<!-- 이 페이지에선 차트를 안띄워줄건데도 호출 페이지가 얘니까 차트호출주소를 여기서도 불러내줘야 바로 띄워줌 -->
	        	<!-- 지도도 마찬가지임 -->
	        </div>
	        
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