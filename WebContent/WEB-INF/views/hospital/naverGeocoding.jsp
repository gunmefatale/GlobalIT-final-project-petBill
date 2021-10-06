<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  
  	<!-- Geocoder 서브 모듈 JavaScript 파일을 로드하기 -->
    <script
      type="text/javascript"
      src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=j4a3tjdjiy&submodules=geocoder"
    ></script>
    
    <!-- 성공실패여부 & 주소->좌표검색(geocode)api호출 이건 완전 네이버꺼.-->
    <script type="text/javascript">
      // 네이버 함수 호출 부분 - 결과가 배열로 오는 함수 만듬.
      const getNaverMapGeoCode = (address, callBack) => {
        naver.maps.Service.geocode(
          {
            address,
          },
          function (status, response) {
            if (status !== naver.maps.Service.Status.OK) {
              return alert("Something wrong!");
            }

            var result = response.result, // 검색 결과의 컨테이너
              	items = result.items; // 검색 결과의 배열
			
            // 배열로 저장시키기 
            let rtnAddr = [];
            items.forEach((item) => {
              if (item.isRoadAddress) { // 도로명주소만 나오게 처리 
                rtnAddr.push(item);
              }
            });

            // 콜백 함수 실행. 자바스크립트는 생성 순서가 상관없대;; 
            callBack(rtnAddr);
          }
        );
      };

  

	  // 네이버 코딩 실행함수 
      function btnAddressToGeocode() {
        // 주소입력창에 텍스트 입력받기
        // let : 블록 유효범위를 갖는 지역변수, 선언과 동시에 임의의 값으로 초기화도 가능.
        let targetAddress = document.getElementById("address").value;
        if (!targetAddress) {
          alert("도로명 주소를 입력하세요.");
        
        }else{
        
          // 작업시 btnAddressToGeocode의 내장함수 느낌
          const callBackFunc = (resultItem) => { // resultItem == targetAddress
            if (resultItem.length === 0) { // 1개도 없으면  
              alert("검색결과가 없습니다. 주소를 다시 확인하세요.");
              
            } else { // 들어있으면 신주소결과만 걸러서 출력 - jsp_<body/>에 쓸 내용을 targetDiv에 담아서 메서드처럼 사용.
              let targetDiv = document.getElementById("result");
              let html = "<ul>";
              
              //결과값 반복문으로 출력
              resultItem.forEach((item) => {
                html += "<li>" + item.address + "--> x : " + item.point.x + " , y : " + item.point.y + "</li>";
              });
              html += "</ul>";

              targetDiv.innerHTML = html;
              
            }
          };
          getNaverMapGeoCode(targetAddress, callBackFunc); // 다시 네이버함수 호출 - 네이버api에 타겟주소==검색주소, 콜백함수
        }
      };
      
    </script>
  </head>
  <body>
    <h2>네이버 Geocoding (주소 -> 위도/경도 좌표값 생성)</h2>
    <h3>주소:</h3>
    <input type="text" id="address" />
    <button onclick="btnAddressToGeocode()">위도/경도검색</button>
    <br />
    <h3>결과 : </h3>
    <div id="result"></div>
  </body>
  
</html>
