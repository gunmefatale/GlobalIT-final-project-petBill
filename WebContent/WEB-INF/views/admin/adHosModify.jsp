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
   
   <script type="text/javascript">
   //등록 버튼 클릭시 처리
   	function insert(){
			
		 alert("등록하시겠습니까?");
		 		
   	}	
   //업데이트 버튼 클릭시 처리
   	function update(){
			
		 alert("수정하시겠습니까?");
		 		
   	}
   //삭제 버튼 클릭시 처리
   	function del(hosNo){
		var result = confirm("정말 삭제하시겠습니까?");
		
		if(result){
			// 확인 선택시 처리 태준님해결!!!!!!!!
			window.location="/petBill/admin/adhosDeleteForm.pet?hosNo=" + hosNo;
		    alert("삭제되었습니다.");
		}else{
			// 취소 선택시 처리
		    alert("취소되었습니다.");
		}
   		   		
   	}
   </script>
   <style>
      .map_wrap {position:relative;width:100%;height:500px;}
      .title {font-weight:bold;display:block;}
      .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
      #centerAddr {display:block;margin-top:2px;font-weight: normal;}
      .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
   </style>

   <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

   <!--1. 부트스트랩 css 사용 -->
   <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">
	<!-- footer css 태준(09/29)-->
	<link href="/petBill/resources/css/footer.css" rel="stylesheet" type="text/css">   

</head>
  <body>
       
   <div class="d-flex">
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
               
           <!-- 페이지 내용작성 영역 : Page content, overflow:auto; div가 넘치면 스크롤바 생성-->
           <div class="container-fluid" style="white-space:nowrap;">
			
			<br />
            <div align="center">
              <div class="col-md-10 col-md-offset-1">
	            <div id="title">
		            <h3>병원 등록</h3>
		              <p class="lead">
		              	주소를 입력하시면 지도에 표시될 주소의 위치값이 자동입력됩니다.
		              </p>
	            </div>
	          </div>
            <table class="table">
               <tbody>
               <tr>
                  <td><input type="text" name="search_area" id="search_area" placeholder="등록할 주소를 입력하세요" value=""/>
                  	  <button type="button" id="search_address" class="btn btn-primary btn-sm">주소 입력</button> 
                  </td>
               </tr>
               <tr>
                  <td colspan="4" >
                     <div class="map_wrap">
                         <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
                         <div class="hAddr">
                             <span class="title">지도중심기준 행정동 주소정보</span>
                             <span id="centerAddr"></span>
                         </div>
                     </div>
                     
                     <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5acd7d0abad958ae8f6e5399abee0118&libraries=services"></script>
                     <script>
                     var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                         mapOption = {
                             center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                             level: 5 // 지도의 확대 레벨
                         };  
                     
                     // 지도를 생성합니다    
                     var map = new daum.maps.Map(mapContainer, mapOption); 
         
                     // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
                     var mapTypeControl = new daum.maps.MapTypeControl();
                     
                     // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
                     // daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
                     map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
                     
                     // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
                     var zoomControl = new daum.maps.ZoomControl();
                     map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
         
                     // 주소-좌표 변환 객체를 생성합니다
                     var geocoder = new daum.maps.services.Geocoder();
                     
                     var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
                         infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
                     
                     // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
                     searchAddrFromCoords(map.getCenter(), displayCenterInfo);
                     
                     // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
                     daum.maps.event.addListener(map, 'click', function(mouseEvent) {
                         searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                             if (status === daum.maps.services.Status.OK) {
                                 var detailAddr = !!result[0].road_address ? '<div style="padding: 10px; ">도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                                 detailAddr += '<div style="padding: 10px; ">지번 주소 : ' + result[0].address.address_name + '</div><br/>';
                                 
                                 detailAddr += '<div></div>';
                                 
                                 var content = '<div class="bAddr">' +
                                                 detailAddr + 
                                             '</div>';
         
                                 // 마커를 클릭한 위치에 표시합니다 
                                 marker.setPosition(mouseEvent.latLng);
                                 marker.setMap(map);
                     
                                 // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
                                 infowindow.setContent(content);
                                 infowindow.open(map, marker);
         
         
                               // 클릭한 위도, 경도 정보를 가져옵니다 
                               var latlng = mouseEvent.latLng; 
                               
                               // 마커 위치를 클릭한 위치로 옮깁니다
                               marker.setPosition(latlng);
                               
                               $("#lat").val(latlng.getLat());
                               $("#lng").val(latlng.getLng());
                               
                               setCenter(latlng.getLat(), latlng.getLng())
                             }   
                         });
                     });
                     
                     // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
                     daum.maps.event.addListener(map, 'idle', function() {
                         searchAddrFromCoords(map.getCenter(), displayCenterInfo);
                     });
         
         
                     // 주소-좌표 변환 객체를 생성합니다
                     var geocoder = new daum.maps.services.Geocoder();
                     
                     $(document).on('click', "#search_address", function(){
                        var search_area = $("#search_area").val();
         
         
                        // 주소로 좌표를 검색합니다
                        geocoder.addressSearch(search_area, function(result, status) {
                        
                            // 정상적으로 검색이 완료됐으면 
                             if (status === daum.maps.services.Status.OK) {
                        
                                var coords = new daum.maps.LatLng(result[0].y, result[0].x);
         
                               $("#lat").val(result[0].y);
                               $("#lng").val(result[0].x);
         
                                 // 마커를 클릭한 위치에 표시합니다 
                                 marker.setPosition(coords);
                                 marker.setMap(map);
         
                              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                                map.setCenter(coords);
                            }
                        });
                     })
         
         
                     function searchAddrFromCoords(coords, callback) {
                         // 좌표로 행정동 주소 정보를 요청합니다
                         geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
                     }
                     
                     function searchDetailAddrFromCoords(coords, callback) {
                         // 좌표로 법정동 상세 주소 정보를 요청합니다
                         geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
                     }
                     
                     // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
                     function displayCenterInfo(result, status) {
                         if (status === daum.maps.services.Status.OK) {
                             var infoDiv = document.getElementById('centerAddr');
                     
                             for(var i = 0; i < result.length; i++) {
                                 // 행정동의 region_type 값은 'H' 이므로
                                 if (result[i].region_type === 'H') {
                                     infoDiv.innerHTML = result[i].address_name;
                                     break;
                                 }
                             }
                         }    
                     }
                     function setCenter(lat, lng) {            
                         // 이동할 위도 경도 위치를 생성합니다 
                         var moveLatLon = new daum.maps.LatLng(lat, lng);
                         // 지도 중심을 이동 시킵니다
                         map.panTo(moveLatLon);
                     }
                     </script>
                  </td>
               </tr>
               </tbody>
            </table>
        
         
           <form action="/petBill/admin/adHosSignup.pet">
           <table class="table">
           <caption>병원 등록</caption>
               <tr class="table-dark" align="center">
                  <td>병원명</td>
                  <td>주소</td>
                  <td>시/도</td>
                  <td>시/군/구</td>
                  <td>전화번호</td>
                  <td>X좌표</td>
                  <td>Y좌표</td>
                  <td></td>
               </tr>
               <tr>
                  <td><input type="text" name="hosName" required class="form-control wd30" placeholder="병원명 입력"/></td>
                  <td><input type="text" name="hosNewAddress" required class="form-control wd30" placeholder="도로명 주소입력"/></td>
                  <td><input type="text" name="hosSi" required class="form-control wd30" placeholder="ex)서울특별시"/></td>
                  <td><input type="text" name="hosGu" required class="form-control wd30" placeholder="ex)관악구"/></td>
                  <td><input type="text" name="hosNum" required class="form-control wd30" placeholder="'-'포함"/></td>
                  <td><input type="text" name="x" required id="lat" class="form-control wd30" placeholder="위도 좌표" maxlength="12" value="" readonly/></td>
                  <td><input type="text" name="y" required id="lng" class="form-control wd30" placeholder="경도 좌표" maxlength="12" value="" readonly/></td>
                  <td><input type="submit" value="등록하기" onclick="insert()" class="btn btn-primary btn-sm"></td>
               </tr>
            </table>
            </form><!-- 병원등록 -->
            <div style="margin-bottom: 50px;">
         	<br />
            <c:if test="${count == 0}">
            <br />
            <table class="table">
               <tr>
                  <td align="center">병원이 없습니다.</td>
               </tr>
            </table>
            </c:if>
            
            <!-- count 있으면 -->
            <c:if test="${count != 0}">
	        
            <table class="table">
             <caption>병원 수정/삭제
             	<span>
		            <form action="/petBill/admin/adHosModify.pet">
		               <input type="search" name="search" placeholder="병원명 검색" />
		               <input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
		            </form>
	            </span>
             </caption>
               <tr class="table-dark" align="center">
                  <td>번호</td>
                  <td>병원명</td>
                  <td>주소</td>
                  <td>시.도</td>
                  <td>시.군.구</td>
                  <td>전화번호</td>
                  <td>X좌표</td>
                  <td>Y좌표</td>
                  <td></td>
                  <td></td>
               </tr>
	           <c:forEach var="hos" items="${hosList}">
		       <form action="/petBill/admin/adhosModifyForm.pet" method="post">
	           		<tr>
		               <td align="center">${number}
		               		<c:set var="number" value="${number - 1}" />
		               		<input type="hidden" name="hosNo" value="${hos.hosNo}"/>
		               </td>
		               <td><input type="text" name="hosName" value="${hos.hosName}" class="form-control wd30"/></td>
		               <td><input type="text" name="hosNewAddress" value="${hos.hosNewAddress}" class="form-control wd30"/></td>
		               <td><input type="text" name="hosSi" value="${hos.hosSi}" class="form-control wd30"/></td>
		               <td><input type="text" name="hosGu" value="${hos.hosGu}" class="form-control wd30"/></td>
		               <td><input type="text" name="hosNum" value="${hos.hosNum}" class="form-control wd30"/></td>
		               <td><input type="text" name="x" value="${hos.x}" class="form-control wd30"/></td>
		               <td><input type="text" name="y" value="${hos.y}" class="form-control wd30"/></td>
		               <td><input type="submit" onclick="update()" value="수정하기" class="btn btn-primary btn-sm"></td>
		               <td><input type="button" onclick="del(${hos.hosNo})" value="삭제하기" class="btn btn-dark btn-sm"></td>
	            	</tr>
	         	</form><!-- 병원 수정 삭제 -->
	           	</c:forEach>
            </table>
            </c:if>
	        <input type="button" onclick="window.location='/petBill/admin/adHosModify.pet'" value="리스트보기" class="btn btn-light btn-sm">               
            
            <br /><br />
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
                  
                 <%-- 검색 안했을때 페이지번호들   --%> 
               <c:if test="${search == null}">
                   <c:if test="${startPage > pageBlock}">
                      <a href="/petBill/admin/adHosModify.pet?pageNum=${startPage-pageBlock}" class="page-link"> &lt; </a>
                   </c:if>
                   <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
                      <a href="/petBill/admin/adHosModify.pet?pageNum=${i}" class="page-link"> ${i} </a>
                   </c:forEach>
                   <c:if test="${endPage < pageCount}">
                      <a href="/petBill/admin/adHosModify.pet?pageNum=${startPage+pageBlock}" class="page-link"> &gt; </a>
                   </c:if>
                   </c:if>
                

                <!-- 검색을 했을때 -->
                <c:if test="${search != null}">
                   <c:if test="${startPage > pageBlock}">
                      <a href="/petBill/admin/adHosModify.pet?pageNum=${startPage-pageBlock}&search=${search}" class="page-link"> &lt;</a>
                   </c:if>
                   <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
                      <a href="/petBill/admin/adHosModify.pet?pageNum=${i}&search=${search}" class="page-link"> ${i}</a>
                   </c:forEach>
                   <c:if test="${endPage < pageCount}">
                     <a href="/petBill/admin/adHosModify.pet?pageNum=${startPage+pageBlock}&search=${search}" class="page-link"> &gt; </a>
                   </c:if>
                </c:if>
              </c:if><!-- 페이지번호 -->
              </div>
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