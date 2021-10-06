package petbill.hospital.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import petbill.review.model.ReviewDTO;

@Repository // component-scan이 찾아서 bean 으로 등록될수있게!
public class HospitalDAOImpl implements HospitalDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession = null;

/////////////////////////////////////// hosContent ////////////////////////////////////////
	

	// 해당 병원정보 1개 가져오기 -> hosContent
	@Override
	public HospitalDTO getHosArticle(int hosNo) throws SQLException {
		// 고유번호 주고 정보 가져오기
		HospitalDTO article = sqlSession.selectOne("hos.getHosArticle", hosNo);
		// 담아서 dto로 리턴
		return article;
	}
	// 해당 병원 리뷰 전체개수 가져오기 -> hosContent
	@Override
	public int getRevArticleCount(int hosNo) throws SQLException {
		int result = sqlSession.selectOne("hos.revCountAll", hosNo);
		return result;
	}
	
	// 해당 병원 리뷰들 가져오기 -> hosContent
	@Override
	public List<ReviewDTO> getRevArticles(int start, int end, int hosNo) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		map.put("startKey", start);
		map.put("endKey", end);
		map.put("hosNo", hosNo);
		
		// 리턴된 값(dto) 레코드가 여러개니까 List에 담기
		List<ReviewDTO> revDtoList = sqlSession.selectList("hos.getRevArticles", map);
		
		return revDtoList;
	}
	
	// 전국평균값 가져오기 -> hosContent
	@Override
	public Map<String, String> getAvg(String petType, String diagnosis) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		
		System.out.println("DAO petType : "+ petType);
		System.out.println("DAO diagnosis : " + diagnosis);
		
		map.put("petType", petType);
		map.put("diagnosis", diagnosis);

		Map<String, String> getAvg = sqlSession.selectOne("hos.getAvg", map);			
	
		return getAvg;
	}
	// 시 평균값 가져오기 -> hosContent
	@Override
	public Map<String, String> getAvgSi(String petType, String hosSi, String diagnosis) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		
		map.put("petType", petType);
		map.put("hosSi", hosSi);
		map.put("diagnosis", diagnosis);
		Map<String, String> getAvgSi = sqlSession.selectOne("hos.getAvgSi", map);
		
		return getAvgSi;
	}
	// 구 평균값 가져오기 -> hosContent
	@Override
	public Map<String, String> getAvgGu(String petType, String hosGu, String diagnosis) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		
		map.put("petType", petType);
		map.put("hosGu", hosGu);
		map.put("diagnosis", diagnosis);
		Map<String, String> getAvgGu = sqlSession.selectOne("hos.getAvgGu", map);
		
		return getAvgGu;
	}
	
	// 리뷰 평균값 가져오기 -> hosContent
	@Override
	public Map<String, String> getAvgRe(String petType, int hosNo, String diagnosis) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		
		map.put("hosNo", hosNo);
		map.put("petType", petType);
		map.put("diagnosis", diagnosis);
		Map<String, String> getAvgRe = sqlSession.selectOne("hos.reviewAvg", map);
		
		return getAvgRe;
	}
	
	
	// A병원 강아지 리뷰진료비 평균 가져오기 -> hosCompare
	@Override
	public Map<String, String> getAArticle(int hosNoA, String petType, String diagnosis) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		map.put("hosNo", hosNoA);
		map.put("petType", petType);
		map.put("diagnosis", diagnosis);
		
		Map<String, String> getAArticle = sqlSession.selectOne("hos.getABArticle", map);
		
		return getAArticle;
	}
	
	@Override
	public Map<String, String> getBArticle(int hosNoB, String petType, String diagnosis) throws SQLException {
		
		// HashMap에 데이터 담아서 보내기
		HashMap map = new HashMap();
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		
		map.put("hosNo", hosNoB);
		map.put("petType", petType);
		map.put("diagnosis", diagnosis);
		
		Map<String, String> getBArticle = sqlSession.selectOne("hos.getABArticle", map);
		
		return getBArticle;
	}
	// 리뷰 개수
	@Override
	public int getAvgReCount(String petType, int hosNo, String diagnosis) throws SQLException {
		
		HashMap map = new HashMap();
		
		if(petType.equals("고양이")) {petType = "cat";}
		else if(petType.equals("강아지")) {petType = "dog";}
		// 고양이
		if(petType.equals("cat") && diagnosis.equals("종합검진")) {diagnosis = "cAllTest";}
		else if(petType.equals("cat") && diagnosis.equals("혈액검사")) {diagnosis = "cBloodTest";}
		else if(petType.equals("cat") && diagnosis.equals("초음파검사")) {diagnosis = "cUltrasonography";}
		else if(petType.equals("cat") && diagnosis.equals("X-ray검사")) {diagnosis = "cXray";}
		else if(petType.equals("cat") && diagnosis.equals("알러지검사")) {diagnosis = "cAllergy";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "cHeartbugKit";}
		else if(petType.equals("cat") && diagnosis.equals("기본신체검사")) {diagnosis = "cBasicPhysicalTest";}
		else if(petType.equals("cat") && diagnosis.equals("고양이PCR검사")) {diagnosis = "cPCR";}
		else if(petType.equals("cat") && diagnosis.equals("방광결석")) {diagnosis = "cBladderStone";}
		else if(petType.equals("cat") && diagnosis.equals("요도결석")) {diagnosis = "cYodoStone";}
		else if(diagnosis.equals("1차접종")) {diagnosis = "c1";}
		else if(diagnosis.equals("2차접종")) {diagnosis = "c2";}
		else if(diagnosis.equals("3차접종")) {diagnosis = "c3";}
		else if(petType.equals("cat") && diagnosis.equals("심장사상충예방약")) {diagnosis = "cCIPM";}
		else if(petType.equals("cat") && diagnosis.equals("항체가검사")) {diagnosis = "cAntibodyTest";}
		else if(petType.equals("cat") && diagnosis.equals("추가접종")) {diagnosis = "cBoosterVcc";}
		else if(petType.equals("cat") && diagnosis.equals("광견병접종")) {diagnosis = "cRabies";}
		else if(petType.equals("cat") && diagnosis.equals("유선종양")) {diagnosis = "cBreastTumor";}
		else if(petType.equals("cat") && diagnosis.equals("자궁축농증")) {diagnosis = "cPyometra";}
		else if(petType.equals("cat") && diagnosis.equals("기타종양")) {diagnosis = "cEtcTumors";}
		else if(petType.equals("cat") && diagnosis.equals("다리검진")) {diagnosis = "cLegTest";}
		else if(petType.equals("cat") && diagnosis.equals("슬개골탈구")) {diagnosis = "cPatellaDislocation";}
		else if(petType.equals("cat") && diagnosis.equals("대퇴골두")) {diagnosis = "cFemoralHead";}
		else if(petType.equals("cat") && diagnosis.equals("전십자인대")) {diagnosis = "cACL";}
		else if(petType.equals("cat") && diagnosis.equals("구토")) {diagnosis = "cThrowUp";}
		else if(petType.equals("cat") && diagnosis.equals("설사")) {diagnosis = "cDiarrhea";}
		else if(petType.equals("cat") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "cBloodPoop";}
		else if(petType.equals("cat") && diagnosis.equals("기본진료")) {diagnosis = "cBasicCare";}
		else if(petType.equals("cat") && diagnosis.equals("안과진료")) {diagnosis = "cEyeCare";}
		else if(petType.equals("cat") && diagnosis.equals("체리아이")) {diagnosis = "cCherryEye";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "cTNRM";}
		else if(petType.equals("cat") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "cTNRW";}
		else if(petType.equals("cat") && diagnosis.equals("스케일링")) {diagnosis = "cScaling";}
		else if(petType.equals("cat") && diagnosis.equals("전발치수술")) {diagnosis = "cAllTooth";}
		else if(petType.equals("cat") && diagnosis.equals("유치발치")) {diagnosis = "cMilkTooth";}
		else if(petType.equals("cat") && diagnosis.equals("치과진료")) {diagnosis = "cDentalCare";}
		else if(petType.equals("cat") && diagnosis.equals("영구치발치")) {diagnosis = "cForeverTooth";}
		else if(petType.equals("cat") && diagnosis.equals("탈장")) {diagnosis = "cHernia";}
		else if(petType.equals("cat") && diagnosis.equals("피부진료")) {diagnosis = "cSkinCare";}
		//강아지
		else if(petType.equals("dog") && diagnosis.equals("종합검진")) {diagnosis = "dAllTest";}
		else if(petType.equals("dog") && diagnosis.equals("혈액검사")) {diagnosis = "dBloodTest";}
		else if(petType.equals("dog") && diagnosis.equals("초음파검사")) {diagnosis = "dUltrasonicWave";}
		else if(petType.equals("dog") && diagnosis.equals("X-ray검사")) {diagnosis = "dXray";}
		else if(petType.equals("dog") && diagnosis.equals("알러지검사")) {diagnosis = "dAllergy";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충키트검사")) {diagnosis = "dHeartbugKit";}
		else if(petType.equals("dog") && diagnosis.equals("기본신체검사")) {diagnosis = "dBasicPhysicalTest";}
		else if(diagnosis.equals("1차(종합백신+코로나)")) {diagnosis = "d1";}
		else if(diagnosis.equals("2차(종합백신+코로나)")) {diagnosis = "d2";}
		else if(diagnosis.equals("3차(종합백신+켄넬코프)")) {diagnosis = "d3";}
		else if(diagnosis.equals("4차(종합백신+켄넬코프)")) {diagnosis = "d4";}
		else if(diagnosis.equals("5차(종합백신+인플루엔자)")) {diagnosis = "d5";}
		else if(diagnosis.equals("6차(광견병+인플루엔자)")) {diagnosis = "d6";}
		else if(petType.equals("dog") && diagnosis.equals("심장사상충예방약")) {diagnosis = "dCIPM";}
		else if(petType.equals("dog") && diagnosis.equals("항체가검사")) {diagnosis = "dAntibodyTest";}
		else if(petType.equals("dog") && diagnosis.equals("추가접종")) {diagnosis = "dBoosterVcc";}
		else if(petType.equals("dog") && diagnosis.equals("방광결석")) {diagnosis = "dBladderStone";}
		else if(petType.equals("dog") && diagnosis.equals("요도결석")) {diagnosis = "dYodoStone";}
		else if(petType.equals("dog") && diagnosis.equals("유선종양")) {diagnosis = "dBreastTumor";}
		else if(petType.equals("dog") && diagnosis.equals("자궁축농증")) {diagnosis = "dPyometra";}
		else if(petType.equals("dog") && diagnosis.equals("기타종양")) {diagnosis = "dEtcTumors";}
		else if(petType.equals("dog") && diagnosis.equals("다리검진")) {diagnosis = "dLegTest";}
		else if(petType.equals("dog") && diagnosis.equals("슬개골탈구")) {diagnosis = "dPatellaDislocation";}
		else if(petType.equals("dog") && diagnosis.equals("대퇴골두")) {diagnosis = "dFemoralHead";}
		else if(petType.equals("dog") && diagnosis.equals("전십자인대")) {diagnosis = "dACL";}
		else if(petType.equals("dog") && diagnosis.equals("구토")) {diagnosis = "dThrowUp";}
		else if(petType.equals("dog") && diagnosis.equals("설사")) {diagnosis = "dDiarrhea";}
		else if(petType.equals("dog") && diagnosis.equals("혈변/혈뇨")) {diagnosis = "dBloodPoop";}
		else if(petType.equals("dog") && diagnosis.equals("기본진료")) {diagnosis = "dBasicCare";}
		else if(petType.equals("dog") && diagnosis.equals("안과진료")) {diagnosis = "dEyeCare";}
		else if(petType.equals("dog") && diagnosis.equals("체리아이")) {diagnosis = "dCherryEye";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(남아)")) {diagnosis = "dTNRM";}
		else if(petType.equals("dog") && diagnosis.equals("중성화수술(여아)")) {diagnosis = "dTNRW";}
		else if(petType.equals("dog") && diagnosis.equals("스케일링")) {diagnosis = "dScaling";}
		else if(petType.equals("dog") && diagnosis.equals("전발치수술")) {diagnosis = "dAllTooth";}
		else if(petType.equals("dog") && diagnosis.equals("유치발치")) {diagnosis = "dMilkTooth";}
		else if(petType.equals("dog") && diagnosis.equals("치과진료")) {diagnosis = "dDentalCare";}
		else if(petType.equals("dog") && diagnosis.equals("영구치발치")) {diagnosis = "dForeverTooth";}
		else if(petType.equals("dog") && diagnosis.equals("탈장")) {diagnosis = "dHernia";}
		else if(petType.equals("dog") && diagnosis.equals("피부진료")) {diagnosis = "dSkinCare";}
		
		map.put("hosNo", hosNo);
		map.put("petType", petType);
		map.put("diagnosis", diagnosis);
		
		
		int getAvgReCount = sqlSession.selectOne("hos.getAvgReCount", map);
		
		return getAvgReCount;
	}
	
	// 해당 병원정보 1개 가져오기 -> hosCompare
//	@Override
//	public HospitalDTO getHosArticle(int hosNo) throws SQLException {
//		// 고유번호 주고 정보 가져오기
//		HospitalDTO article = sqlSession.selectOne("hos.getHosArticle", hosNo);
//		// 담아서 dto로 리턴
//		return article;
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
