<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 문자열 치환하기위함 : replace --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>진료비 수정/삭제/등록</title>
   <script type="text/javascript">
   	
   //업데이트 버튼 클릭시 처리
   	function update(){
			
		 alert("진료비가 수정되었습니다.");
		 		
   	}	
   //초기화 버튼 클릭시 처리
   	function cat(){
		var result = confirm("고양이 진료비를 모두 초기화 시키시겠습니까?");
		
		if(result){
			// 확인 선택시 처리
			window.location="/petBill/admin/adCatDelete.pet?hosNo=${hosNo}";
		    alert("초기화 되었습니다.");
		}else{
			// 취소 선택시 처리
		    alert("취소 되었습니다.");
		}
   		   		
   	}
   	function dog(){
		var result = confirm("강아지 진료비를 모두 초기화 시키시겠습니까?");
		
		if(result){
			// 확인 선택시 처리
			window.location="/petBill/admin/adDogDelete.pet?hosNo=${hosNo}";
		    alert("초기화 되었습니다.");
		}else{
			// 취소 선택시 처리
		    alert("취소 되었습니다.");
		}
   		   		
   	}
   </script>

</head>
<body>
	
   <br />
   <div align="center">
   <table class="table">
      <tr>
         <td>
            <form action="/petBill/admin/adDogModify.pet" method="post">
            <table class="table table-bordered">
   			  <caption>강아지 진료비</caption>
               <!-- fn:replace 문자중 '.0'없애기위한 jstl 함수.. -->
               <tr><th class="table-light">종합검진</th><td><input name="dAllTest" type="number" required value="${fn:replace(dog.dAllTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">혈액검사</th><td><input name="dBloodTest" type="number" required value="${fn:replace(dog.dBloodTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">초음파검사</th><td><input name="dUltrasonicWave" type="number" required value="${fn:replace(dog.dUltrasonicWave, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">X-ray검사</th><td><input name="dXray" type="number" required value="${fn:replace(dog.dXray, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">알러지검사</th><td><input name="dAllergy" type="number" required value="${fn:replace(dog.dAllergy, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">심장사상충검사</th><td><input name="dHeartbugKit" type="number" required value="${fn:replace(dog.dHeartbugKit, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">기본신체검사</th><td><input name="dBasicPhysicalTest" type="number" required value="${fn:replace(dog.dBasicPhysicalTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">1차접종(종합백신+코로나)</th><td><input name="d1" type="number" required value="${fn:replace(dog.d1, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">2차접종(종합백신+코로나)</th><td><input name="d2" type="number" required value="${fn:replace(dog.d2, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">3차접종(종합백신+켄넬코프)</th><td><input name="d3" type="number" required value="${fn:replace(dog.d3, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">4차접종(종합백신+켄넬코프)</th><td><input name="d4" type="number" required value="${fn:replace(dog.d4, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">5차접종(종합백신+인플루엔자)</th><td><input name="d5" type="number" required value="${fn:replace(dog.d5, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">6차접종(광견병+인플루엔자)</th><td><input name="d6" type="number" required value="${fn:replace(dog.d6, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">심장사상충예방약</th><td><input name="dCIPM" type="number" required value="${fn:replace(dog.dCIPM, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">항체가검사</th><td><input name="dAntibodyTest" type="number" required value="${fn:replace(dog.dAntibodyTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">추가접종</th><td><input name="dBoosterVcc" type="number" required value="${fn:replace(dog.dBoosterVcc, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">방광결석</th><td><input name="dBladderStone" type="number" required value="${fn:replace(dog.dBladderStone, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">요도결석</th><td><input name="dYodoStone" type="number" required value="${fn:replace(dog.dYodoStone, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">유선종양</th><td><input name="dBreastTumor" type="number" required value="${fn:replace(dog.dBreastTumor, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">자궁축농증</th><td><input name="dPyometra" type="number" required value="${fn:replace(dog.dPyometra, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">기타종양</th><td><input name="dEtcTumors" type="number" required value="${fn:replace(dog.dEtcTumors, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">다리검진</th><td><input name="dLegTest" type="number" required value="${fn:replace(dog.dLegTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">슬개골탈구</th><td><input name="dPatellaDislocation" type="number" required value="${fn:replace(dog.dPatellaDislocation, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">대퇴골두</th><td><input name="dFemoralHead" type="number" required value="${fn:replace(dog.dFemoralHead, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">전십자인대</th><td><input name="dACL" type="number" required value="${fn:replace(dog.dACL, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">구토</th><td><input name="dThrowUp" type="number" required value="${fn:replace(dog.dThrowUp, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">설사</th><td><input name="dDiarrhea" type="number" required value="${fn:replace(dog.dDiarrhea, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">혈변/혈뇨</th><td><input name="dBloodPoop" type="number" required value="${fn:replace(dog.dBloodPoop, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">기본진료</th><td><input name="dBasicCare" type="number" required value="${fn:replace(dog.dBasicCare, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">안과진료</th><td><input name="dEyeCare" type="number" required value="${fn:replace(dog.dEyeCare, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">체리아이</th><td><input name="dCherryEye" type="number" required value="${fn:replace(dog.dCherryEye, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">중성화수술(남아)</th><td><input name="dTNRM" type="number" required value="${fn:replace(dog.dTNRM, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">중성화수술(여아)</th><td><input name="dTNRW" type="number" required value="${fn:replace(dog.dTNRW, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">스케일링</th><td><input name="dScaling" type="number" required value="${fn:replace(dog.dScaling, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">전발치수술</th><td><input name="dAllTooth" type="number" required value="${fn:replace(dog.dAllTooth, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">유치발치</th><td><input name="dMilkTooth" type="number" required value="${fn:replace(dog.dMilkTooth, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">치과진료</th><td><input name="dDentalCare" type="number" required value="${fn:replace(dog.dDentalCare, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">영구치발치</th><td><input name="dForeverTooth" type="number" required value="${fn:replace(dog.dForeverTooth, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">탈장</th><td><input name="dHernia" type="number" required value="${fn:replace(dog.dHernia, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">피부진료</th><td><input name="dSkinCare" type="number" required value="${fn:replace(dog.dSkinCare, '.0', '')}"/>&nbsp;원</td></tr>
            </table>
             <div>
          	   <input type="hidden" name="hosNo" value="${hosNo}"/>
          	   <input type="submit" onclick="update()" value="강아지 진료비 업데이트" class="btn btn-primary"/>&nbsp;&nbsp;&nbsp;&nbsp;
          	   <input type="button" onclick="dog()" value="초기화" class="btn btn-dark"/>
          	 </div>
            </form>
         </td>
         <td><div class="diagnosisTable">
            <form action="/petBill/admin/adCatModify.pet">
            <table class="table table-bordered">
            <caption>고양이 진료비</caption>
               <tr><th class="table-light">종합검진</th><td><input name="cAllTest" type="number" required value="${fn:replace(cat.cAllTest, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">혈액검사</th><td><input name="cBloodTest" type="number" required value="${fn:replace(cat.cBloodTest, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">초음파검사</th><td><input name="cUltrasonography" type="number" required value="${fn:replace(cat.cUltrasonography, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">X-ray검사</th><td><input name="cXray" type="number" required value="${fn:replace(cat.cXray, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">알러지검사</th><td><input name="cAllergy" type="number" required value="${fn:replace(cat.cAllergy, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">심장사상충검사</th><td><input name="cHeartbugKit" type="number" required value="${fn:replace(cat.cHeartbugKit, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">기본신체검사</th><td><input name="cBasicPhysicalTest" type="number" required value="${fn:replace(cat.cBasicPhysicalTest, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">고양이PCR검사</th><td><input name="cPCR" type="number" required value="${fn:replace(cat.cPCR, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">방광결석</th><td><input name="cBladderStone" type="number" required value="${fn:replace(cat.cBladderStone, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">요도결석</th><td><input name="cYodoStone" type="number" required value="${fn:replace(cat.cYodoStone, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">1차접종</th><td><input name="c1" type="number" required value="${fn:replace(cat.c1, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">2차접종</th><td><input name="c2" type="number" required value="${fn:replace(cat.c2, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">3차접종</th><td><input name="c3" type="number" required value="${fn:replace(cat.c3, '.0', '')}">&nbsp;원</td></tr>
               <tr><th class="table-light">심장사상충예방약</th><td><input name="cCIPM" type="number" required value="${fn:replace(cat.cCIPM, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">항체가검사</th><td><input name="cAntibodyTest" type="number" required value="${fn:replace(cat.cAntibodyTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">추가접종</th><td><input name="cBoosterVcc" type="number" required value="${fn:replace(cat.cBoosterVcc, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">광견병접종</th><td><input name="cRabies" type="number" required value="${fn:replace(cat.cRabies, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">유선종양</th><td><input name="cBreastTumor" type="number" required value="${fn:replace(cat.cBreastTumor, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">자궁축농증</th><td><input name="cPyometra" type="number" required value="${fn:replace(cat.cPyometra, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">기타종양</th><td><input name="cEtcTumors" type="number" required value="${fn:replace(cat.cEtcTumors, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">다리검진</th><td><input name="cLegTest" type="number" required value="${fn:replace(cat.cLegTest, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">슬개골탈구</th><td><input name="cPatellaDislocation" type="number" required value="${fn:replace(cat.cPatellaDislocation, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">대퇴골두</th><td><input name="cFemoralHead" type="number" required value="${fn:replace(cat.cFemoralHead, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">전십자인대</th><td><input name="cACL" type="number" required value="${fn:replace(cat.cACL, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">구토</th><td><input name="cThrowUp" type="number" required value="${fn:replace(cat.cThrowUp, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">설사</th><td><input name="cDiarrhea" type="number" required value="${fn:replace(cat.cDiarrhea, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">혈변/혈뇨</th><td><input name="cBloodPoop" type="number" required value="${fn:replace(cat.cBloodPoop, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">기본진료</th><td><input name="cBasicCare" type="number" required value="${fn:replace(cat.cBasicCare, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">안과진료</th><td><input name="cEyeCare" type="number" required value="${fn:replace(cat.cEyeCare, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">체리아이</th><td><input name="cCherryEye" type="number" required value="${fn:replace(cat.cCherryEye, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">중성화수술(남아)</th><td><input name="cTNRM" type="number" required value="${fn:replace(cat.cTNRM, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">중성화수술(여아)</th><td><input name="cTNRW" type="number" required value="${fn:replace(cat.cTNRW, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">스케일링</th><td><input name="cScaling" type="number" required value="${fn:replace(cat.cScaling, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">전발치수술</th><td><input name="cAllTooth" type="number" required value="${fn:replace(cat.cAllTooth, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">유치발치</th><td><input name="cMilkTooth" type="number" required value="${fn:replace(cat.cMilkTooth, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">치과진료</th><td><input name="cDentalCare" type="number" required value="${fn:replace(cat.cDentalCare, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">영구치발치</th><td><input name="cForeverTooth" type="number" required value="${fn:replace(cat.cForeverTooth, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">탈장</th><td><input name="cHernia" type="number" required value="${fn:replace(cat.cHernia, '.0', '')}"/>&nbsp;원</td></tr>
               <tr><th class="table-light">피부진료</th><td><input name="cSkinCare" type="number" required value="${fn:replace(cat.cSkinCare, '.0', '')}"/>&nbsp;원</td></tr>
            </table>
            <div>
               <input type="hidden" name="hosNo" value="${hosNo}" />
               <input type="submit" onclick="update()" value="고양이 진료비 업데이트" class="btn btn-primary"/> &nbsp;&nbsp;&nbsp;&nbsp;
               <input type="button" onclick="cat()" value="초기화" class="btn btn-dark"/>
            </div>
            </form>
            </div>
         </td>
      </tr>
   </table>
   </div>
 
   
</body>
</html>