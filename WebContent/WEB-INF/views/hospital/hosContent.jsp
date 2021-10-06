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
    <title>hosContent</title>
    
    <!-- jquery/ajax 사용시 라이브러리를 밑의 링크거는방식: cdm방식으로 추가 (인터넷 될 경우. 안되면 다운받아야함)-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- 네이버 클라우드 플랫폼 : 네이버지도 api 사용 -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=z0t072q98j"></script>
    
    <!-- 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
    
    <!-- footer css -->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">
    
    <!-- chart 사용 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    	
	<!-- 이미지 css -->
    <style>
    .bigPictureWrapper { 
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 100%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(200, 200, 200, 0.5);
    }

    .bigPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img {
        width: 70%;
       
    }

    .img:hover {
       border-style: solid;
       border-top-left-radius: 2em; 
       border-top-right-radius: 2em; 
       border-bottom-right-radius: 2em; 
       border-bottom-left-radius: 2em;
       border-color: gray;
    }
    
    </style>
    
    <script>
      // 진료명 select 
       $(function(){
          petSelectMaker("#petType", "#mainArticle", "#subArticle");
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
              keys.forEach(function(subArticle){
                  $(a3).append("<option value="+area[petType][mainArticle][subArticle]+">"+area[petType][mainArticle][subArticle]+"</option>");    
              });
          });
          
          
          function init(first, second){
              first ? $(a1).empty().append("<option value=''>검색동물 선택</option>") : "";
              second ? $(a2).empty().append("<option value=''>대분류</option>") : "";
              $(a3).empty().append("<option value=''>소분류</option>");
          }
          
      }
   </script>
   <!-- ajax... 제발 좀 돼라 쫌 -->
    <script type="text/javascript">
         function ajaxAction() {
             let petType = $("#petType").val(); // 값을 변수에 담아서
             let diagnosis = $("#subArticle").val(); // 값을 변수에 담아서
             let hosSi = $("#hosSi").val(); // 값을 변수에 담아서
             let hosGu = $("#hosGu").val(); // 값을 변수에 담아서
             let hosNo = $("#hosNo").val(); // 값을 변수에 담아서(우선 string)
              $.ajax({ // 설정하는 부분
                 url: 'http://localhost:8080/petBill/hospital/ajaxAvg.pet', 
                 method:'get', 
                 data: {petType, diagnosis, hosNo, hosSi, hosGu},// 위 변수에 담긴 데이터를 전송해준다
             }).done(function(response){ // == success 랑 같은기능. 지금 error처리는 없는상태.
                 $('#avgDiv').html(response); 
             });
         }
    </script>
    <script>
    //차트
    $(document).ready(function(){
          
      var ctx = $("#myChart"); // jQuery instance
      var a = $("#a").val();
      var b = $("#b").val();
      var c = $("#c").val();
      var d = $("#d").val();
      var myChart = new Chart(ctx, {
      
         type: 'bar',
         data: {
            labels: ['전국 평균', '${article.hosSi} 평균', '${article.hosGu} 평균', '리뷰 평균'],
            datasets: [{
               label: '평균',
               data: [a, b, c, d],
               backgroundColor: [
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)'],
                  borderColor: [
                     'rgba(255, 99, 132, 1)',
                     'rgba(54, 162, 235, 1)',
                     'rgba(255, 206, 86, 1)',
                     'rgba(75, 192, 192, 1)'
                     ],
                     borderWidth: 1
                  }] 
               },
               options: {
                  plugins:{
                        // label 안보이기
                           legend:{
                              display:false
                           },
                           
                           // 툴팁끄고, 수치데이터 항상 보이게
                           tooltips: {
                              enabled: false
                           },
                           hover: {
                              animationDuration: 0
                        },
                        animation: {
                           duration: 1
                        }
               
                    }
               }
         });
      var num = Number($("#a").val());
       $("#a").val(num.toLocaleString())
      var num2 = Number($("#b").val());
       $("#b").val(num2.toLocaleString())
      var num3 = Number($("#c").val());
       $("#c").val(num3.toLocaleString())
      var num4 = Number($("#d").val());
       $("#d").val(num4.toLocaleString())
      });
   </script>
   
   <!-- 이미지 크게 띄우기 -->
   <script type="text/javascript">
    $(document).ready(function (e) {//로딩되면 준비

        $(document).on("click", "img", function () {//img를 클릭하면 실행해라~
            var path = $(this).attr('src')//value속성 src를 path넣는다
            showImage(path);//메서드 실행해라~
        });//end click event

        function showImage(fileCallPath) {
            $(".bigPictureWrapper").css("display", "flex").show();//div요소에 css속성 주기
            $(".bigPicture")
                .html("<img src='" + fileCallPath + "' >")//사진을 화면에 띄운다
        }//end fileCallPath

        $(".bigPictureWrapper").on("click", function (e) {
            setTimeout(function () {
                $('.bigPictureWrapper').hide();
            }, 1);
        });//end bigWrapperClick event
    });
</script>
   
</head>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Side bar-->
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
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                               
                            <%-- 위치 변경필요..? search(검색)form. 조장님 수정부분 --%>
	                        <li class="searchBar">
	                           <form action="/petBill/search/searchResult.pet">
	                              <input type="search" name="search" placeholder="병원명 검색" />
	                              <input type="hidden" name="petType" value="${petType}"/>
	                              <input type="submit" value="검색" class="btn btn-secondary btn-sm"/>                  
	                           </form>
	                        </li>
                        
                        	<!-- 로그인 분기처리 -->
                              <c:if test="${sessionScope.userId eq 'admin'}">   
                                 <li class="nav-item active"><a class="nav-link" href="/petBill/user/loginForm.pet">로그아웃</a></li>
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
                                        <a class="dropdown-item" href="/petBill/hospital/hosContent.pet?petType=${'dog'}&hosNo=${article.hosNo}&pageNum=${pageNum}&hosSi=${article.hosSi}&hosGu=${article.hosGu}&diagnosis=${'dAllTest'}">강아지</a>
                                        <a class="dropdown-item" href="/petBill/hospital/hosContent.pet?petType=${'cat'}&hosNo=${article.hosNo}&pageNum=${pageNum}&hosSi=${article.hosSi}&hosGu=${article.hosGu}&diagnosis=${'cAllTest'}">고양이</a>
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
  
               <!-- Page content , overflow:auto; div가 넘치면 스크롤바 생성 -->
               <div class="container-fluid" style="white-space:nowrap;">
               <br /> <br />
  
  <%---------------------------------------------------------- 해당 병원 정보 지도 ----------------------------------------------------------%>          
               
               <div align="center">
                  <input type="hidden" id="x" value="${article.x}">
                  <input type="hidden" id="y" value="${article.y}">
                  
                  <!-- 병원지도 띄우기 -->
                  <div id="map" style="width:90%;height:400px;"></div>
                  <br />
                  
                  <!-- map 설정 -->
                  <script>
                     // 병원 위치값 지정해주기 
                     var x = document.getElementById("x").value;
                     var y = document.getElementById("y").value;
                     
                     // 마커에 병원 정보창 표시할 내용
                     var contentString = [
                          '<div class="iw_inner">',
                          '   <h3>${article.hosName}</h3>',
                          '   <p>주소 : ${article.hosNewAddress}<br />',
                          '      전화번호 : ${article.hosNum}<br />',
                          '   </p>',
                          '</div>'
                      ].join('');
                     // infowindow 객체생성
                     var infowindow = new naver.maps.InfoWindow({
                         content: contentString
                     });
                     
                     // 지도 옵션 
                     var mapOptions = {
                            center: new naver.maps.LatLng(x, y),
                            zoom: 18,
                            mapTypeControl : true // 일반, 위성 전환버튼 
                        }
                     // 지도 생성
                       var map = new naver.maps.Map('map', mapOptions);
                     
                     // 마커
                     var marker = new naver.maps.Marker({
                         position: new naver.maps.LatLng(x, y),
                         map: map, 
                         // 내 아이콘 사용
                         icon: {
                               url: '/petBill/resources/imgs/pin_default.png', // 아이콘 경로
                               size: new naver.maps.Size(22, 36), // 아이콘 크기
                               origin: new naver.maps.Point(0, 0),
                               anchor: new naver.maps.Point(11, 35)
                           } 
                     });
                     // 마커 클릭이벤트 등록 : 인포 나타났다 사라졌다 하게
                     naver.maps.Event.addListener(marker, "click", function(e) {
                         if (infowindow.getMap()) {
                             infowindow.close();
                         } else {
                             infowindow.open(map, marker);
                         }
                     });

                     // 병원정보창 띄우기
                     infowindow.open(map, marker);
                  </script>
               </div> 
            <br />
<%---------------------------------------------------------- 진료비 평균 비교  ----------------------------------------------------------%>          

            <div align="center">
				<h3>검색조건 변경</h3>	
				<br />
               <table class="table">
                  <tr align="center">
                     <td>
                        <input type="hidden" id="pageNum" value="${param.pageNum}"/>
                        <input type="hidden" id="pageNumRe" value="${pageNumRe}"/>
                        <input type="hidden" id="hosNo" value="${article.hosNo}"/>
                        <input type="hidden" id="hosSi" value="${article.hosSi}"/>
                        <input type="hidden" id="hosGu" value="${article.hosGu}"/>
                        
                        <!-- 진료명 선택 -->
                        <select class="custom-select" name="petType" id="petType"></select>
                        <select class="custom-select" name="mainArticle" id="mainArticle"></select>
                        <select class="custom-select" name="subArticle" id="subArticle"></select>
                        <br />
                     </td>
                  </tr>
                  <tr align="center">
                     <td>
	                     <div class="d-grid gap-2 col-6 mx-auto">
	                        <button class="btn btn-primary btn-lg" onclick="ajaxAction()" >변경하기</button>
	                     </div>
                  	</td>
                  </tr>
               </table>
               <br />
               
               	<!-- ajax 영역 -->
                <div id="avgDiv" class="divtest" align="center">
                     <table class="table" >
                  	 <caption>
                     <c:if test="${param.petType eq 'dog' or petType eq '강아지'}">강아지</c:if>
                     <c:if test="${param.petType eq 'cat' or petType eq '고양이'}">고양이</c:if>
                     종합검진 평균비용</caption> 
                        <tr class="table-dark" style="text-align: center">
                           <th>전국 평균</th>
                           <th>${article.hosSi} 평균</th>
                           <th>${article.hosGu} 평균</th>
                           <th>리뷰 평균</th>
                           <th>리뷰 개수</th>
                        </tr>
                        <tr>
                           <!-- getAvg(HashMap)의 value(진료비) 출력 -->
                           <td>
                              <c:if test="${getAvg == null}">
                                 <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                              </c:if>
                              <c:if test="${getAvg != null}">
                                    <c:forEach var="i" items="${getAvg}">
                                       <input type="text" id="a" value="${i.value}" style="text-align: right" class="form-control-plaintext" readonly>&nbsp;원         
                                 </c:forEach>
                              </c:if>               
                           </td>
                              <td>
                                 <c:if test="${getAvgSi == null}">
                                 <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                              </c:if>
                              <c:if test="${getAvgSi != null}">
                                    <c:forEach var="i" items="${getAvgSi}">
                                       <c:if test="${i.value eq '0'}">
                                          <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                                       </c:if>
                                       <c:if test="${i.value ne '0'}">
                                          <input type="text" id="b" value="${i.value}" style="text-align: right" class="form-control-plaintext" readonly>&nbsp;원
                                       </c:if>
                                 </c:forEach>
                              </c:if>
                              </td>
                              <td>
                                 <c:if test="${getAvgGu == null}">
                                 <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                              </c:if>
                              <c:if test="${getAvgGu != null}">
                                    <c:forEach var="i" items="${getAvgGu}">
                                    <c:if test="${i.value eq '0'}">
                                          <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                                       </c:if>
                                       <c:if test="${i.value ne '0'}">
                                          <input type="text" id="c" value="${i.value}" style="text-align: right" class="form-control-plaintext" readonly>&nbsp;원
                                       </c:if>      
                                 </c:forEach>
                              </c:if>                           
                              </td>
                              <td>
                              <c:if test="${getAvgRe == null}">
                                  <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                              </c:if>
                              <c:if test="${getAvgRe != null}">
                                    <c:forEach var="i" items="${getAvgRe}">
                                       <c:if test="${i.value eq '0'}">
                                          <input type="text" name="none" value="평균값이 없습니다" style="text-align: right" class="form-control-plaintext" readonly>
                                       </c:if>
                                       <c:if test="${i.value ne '0'}">
                                          <input type="text" id="d" value="${i.value}" style="text-align: right" class="form-control-plaintext" readonly>&nbsp;원
                                       </c:if>   
                                 </c:forEach>
                              </c:if>   
                              </td>
                              <td align="center">
	                              <c:if test="${getAvgReCount == 0}">
	                              	-
	                              </c:if>
	                              <c:if test="${getAvgReCount != 0}">
					              	${getAvgReCount}
	                              </c:if>
				              </td>
                         </tr>
                     </table>
                     <br />
                     <!-- 차트 -->
                         <div style="width:800px;height:500px;">
                        <canvas id="myChart"></canvas>
                     </div>
                  </div>
            </div>   
<%---------------------------------------------------------- 리뷰  ----------------------------------------------------------%>          
            <div align="center" style="margin-bottom: 50px;">
               <div>
                    <c:if test="${revArticleList == null}">
                       <table class="table">
			              <caption>방문자 리뷰</caption>
                          <tr>
                             <td align="center">등록된 리뷰가 없습니다.</td>
                          </tr>
                       </table>
                    </c:if>
                    
                    <c:if test="${revArticleList != null}">
                 	 <table class="table">
                 		<caption>방문자 리뷰</caption>
                     	<tr class="table-secondary" align="center">
                           <th>No.</th> 
                           <th>동물분류</th> 
                           <th>진료명</th>
                           <th>가격</th>
                           <th>내용</th>
                           <th>닉네임</th>
                           <th>사진</th>
                           <th>등록날짜</th>
                        </tr>
                        <c:forEach var="revArticle" items="${revArticleList}">
                          <tr>
                            <td align="center">${number}
                           		<c:set var="number" value="${number - 1}" /> 
                        	</td>
                             <td align="center">
                                <c:if test="${revArticle.reviewPetType eq 'dog'}">
                                   강아지
                                </c:if>
                                <c:if test="${revArticle.reviewPetType eq 'cat'}">
                                   고양이
                                </c:if>
                             </td>
                             <td align="center">
                                <!-- 고양이 진료항목 39개 -->
                                <c:if test="${revArticle.reviewArticle eq 'cAllTest'}">종합검진</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBloodTest'}">혈액검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cUltrasonography'}">초음파검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cXray'}">X-ray검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cAllergy'}">알러지검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cHeartbugKit'}">심장사상충키트</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBasicPhysicalTest'}">기본신체검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cPCR'}">PCR검사 </c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBladderStone'}">방광결석</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cYodoStone'}">요도결석</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'c1'}">1차접종</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'c2'}">2차접종</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'c3'}">3차접종</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cCIPM'}">심장사상충예방약</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cAntibodyTest'}">항체가검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBoosterVcc'}">추가접종</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cRabies'}">광견병접종</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBreastTumor'}">유선종양</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cPyometra'}">자궁축농증</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cEtcTumors'}">기타종양</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cLegTest'}">다리검진</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cPatellaDislocation'}">슬개골탈구</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cFemoralHead'}">대퇴골두</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cACL'}">전십자인대</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cThrowUp'}">구토</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cDiarrhea'}">설사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBloodPoop'}">혈변혈뇨</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cBasicCare'}">기본진료</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cEyeCare'}">안과진료</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cCherryEye'}">체리아이</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cTNRM'}">중성화수술(남아)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cTNRW'}">중성화수술(여아)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cScaling'}">스케일링</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cAllTooth'}">전발치수술</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cMilkTooth'}">유치발치</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cDentalCare'}">치과진료</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cForeverTooth'}">영구치발치</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cHernia'}">탈장</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'cSkinCare'}">피부진료</c:if>
                                
                                <!-- 강아지 진료항목 40개 -->
                                <c:if test="${revArticle.reviewArticle eq 'dAllTest'}">종합검진</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBloodTest'}">혈액검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dUltrasonicWave'}">초음파검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dXray'}">X-ray검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dAllergy'}">알러지검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dHeartbugKit'}">심장사상충키트검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBasicPhysicalTest'}">기본신체검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'd1'}">1차(종합백신+코로나)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'd2'}">2차(종합백신+코로나)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'd3'}">3차(종합백신+켄넬코프)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'd4'}">4차(종합백신+켄넬코프)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'd5'}">5차(종합백신+인플루엔자)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'd6'}">6차(광견병+인플루엔자)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dCIPM'}">심장사상충예방약</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dAntibodyTest'}">항체가검사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBoosterVcc'}">추가접종</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBladderStone'}">방광결석</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dYodoStone'}">요도결석</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBreastTumor'}">유선종양</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dPyometra'}">자궁축농증</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dEtcTumors'}">기타종양</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dLegTest'}">다리검진</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dPatellaDislocation'}">슬개골탈구</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dFemoralHead'}">대퇴골두</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dACL'}">전십자인대</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dThrowUp'}">구토</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dDiarrhea'}">설사</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBloodPoop'}">혈변혈뇨</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dBasicCare'}">기본진료</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dEyeCare'}">안과진료</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dCherryEye'}">체리아이</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dTNRM'}">중성화수술(남아)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dTNRW'}">중성화수술(여아)</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dScaling'}">스케일링</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dAllTooth'}">전발치수술</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dMilkTooth'}">유치발치</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dDentalCare'}">치과진료</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dForeverTooth'}">영구치발치</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dHernia'}">탈장</c:if>
                                <c:if test="${revArticle.reviewArticle eq 'dSkinCare'}">피부진료</c:if>
                             </td>
                             <td>
                                <fmt:formatNumber value="${revArticle.reviewPrice}" pattern="#,###"/> 원                 
                             </td>
                             <td>${revArticle.reviewContent}</td> 
                             <td align="center">${revArticle.reviewId}</td>
                             <td align="center">
                                <c:if test="${revArticle.reviewPhoto == null}">
                                <p style="cursor:pointer"><img class="img" src="/petBill/resources/imgs/리뷰 이미지1.png" width="50px" height="60px"/></p>
                                </c:if>
                                <c:if test="${revArticle.reviewPhoto != null}">
                                <p style="cursor:pointer"><img class="img" src="/petBill/photo/${revArticle.reviewPhoto}" width="50px" height="60px"/></p>
                                </c:if>
                             </td>
                             <td align="center">
                                <fmt:formatDate value="${revArticle.reviewDate}" pattern="yyyy-MM-dd"/>
                             </td>
                          </tr>
                           </c:forEach>
                    </table>
                        <div class='bigPictureWrapper'><!-- 화면 확대했을때 -->
                          <div class='bigPicture'></div><!-- 확대했을때 사진 위치 -->
                      </div>
                    </c:if><!-- != null -->
               </div>   
            
            <%-- 페이지번호 --%>
            <div class="page" >
            <c:if test="${count > 0}">
                 <%-- 변수세팅 --%>
               <c:set var="pageBlock" value="5" />
               <fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" />
               <c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
               <fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
               <fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
               <fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
               <c:if test="${endPage > pageCount}">
                  <c:set var="endPage" value="${pageCount}" /> 
               </c:if>
      
               <%-- 왼쪽 꺽쇠 '<' &lt; --%>
               <c:if test="${startPage > pageBlock}">
                  <a href="/petBill/hospital/hosContent.pet?pageNum=${pageNum}&pageNumRe=${startPage-pageBlock}&hosNo=${article.hosNo}&petType=${param.petType}&hosSi=${param.hosSi}&hosGu=${param.hosGu}&diagnosis=${param.diagnosis}" class="pageNums"> &lt; &nbsp;</a>
               </c:if>
               <%-- 검색 안했을때 페이지번호들 --%> 
               <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
                  <a href="/petBill/hospital/hosContent.pet?pageNum=${pageNum}&pageNumRe=${i}&hosNo=${article.hosNo}&petType=${param.petType}&hosSi=${param.hosSi}&hosGu=${param.hosGu}&diagnosis=${param.diagnosis}" class="page-link"> ${i}</a>
               </c:forEach>
               <%-- 오른쪽 꺽쇠 '>' &gt; --%>
               <c:if test="${endPage < pageCount}">
                  &nbsp; <a href="/petBill/hospital/hosContent.pet?pageNum=${pageNum}&pageNumRe=${startPage+pageBlock}&hosNo=${article.hosNo}&petType=${param.petType}&hosSi=${param.hosSi}&hosGu=${param.hosGu}&diagnosis=${param.diagnosis}" class="pageNums"> &gt; </a>
               </c:if>
            </c:if> <%-- end:count > 0 --%>
            </div><%-- page --%>
            <br />

            <c:if test="${dto.useractivenum eq '활성화' && sessionScope.userId ne 'admin'}">
	            <div>
	                   <c:if test="${param.petType eq 'cat'}">
	                     <a href="/petBill/review/reviewWriteForm.pet?pageNum=${pageNum}&petType=${param.petType}&hosNo=${hosNo}&hosSi=${hosSi}&hosGu=${hosGu}&diagnosis=${'cAllTest'}" class="btn btn-primary" style="width:100pt;">리뷰등록</a>
	                  </c:if>
	                  <c:if test="${param.petType ne 'cat'}">
	                     <a href="/petBill/review/reviewWriteForm.pet?pageNum=${pageNum}&petType=${param.petType}&hosNo=${hosNo}&hosSi=${hosSi}&hosGu=${hosGu}&diagnosis=${'dAllTest'}" class="btn btn-primary" style="width:100pt;">리뷰등록</a>
	                  </c:if>
	                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	               <a href="/petBill/search/searchResult.pet?pageNum=${pageNum}&petType=${param.petType}&sidoSel=${hosSi}&siguSel=${hosGu}" class="btn btn-dark" style="width:100pt;">뒤로가기</a>
	            </div>  
            </c:if>
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
	
  
  
     
  <!-- Bootstrap core JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Core theme JS -->
  <script src="/petBill/resources/js/scripts.js"></script>

<%---------------------------------------------------------- 내용 끝  ----------------------------------------------------------%>          

</body>

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
</html>