<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>ajaxAvg</title>
	
	<!-- jquery/ajax 사용시 라이브러리를 밑의 링크거는방식: cdm방식으로 추가 (인터넷 될 경우. 안되면 다운받아야함)-->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<!-- chart 사용 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    
    <script type="text/javascript">
		$(function(){
		    petSelectMaker("#petType", "#mainArticle", "#subArticle");
		});
		
		var petSelectMaker = function(a1, a2, a3){
		    if(a1 == null || a2 == null || a3 == null){
		        console.warn("Unkwon Area Tag");
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
					               legend:{
					                  display:false
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
	
</head>
<body>
	<!-- ajax 영역 -->
	<div id="avgDiv" class="divtest" align="center">
		<table class="table" >
		<caption>
		<c:if test="${petType eq 'dog' or petType eq '강아지'}">강아지</c:if>
		<c:if test="${petType eq 'cat' or petType eq '고양이'}">고양이</c:if>
			 ${diagnosis} 평균비용</caption>
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
	
	<div style="width:800px;height:500px;">
		<canvas id="myChart"></canvas>
	</div>
	</div>

</body>
</html>