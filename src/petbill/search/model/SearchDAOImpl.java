package petbill.search.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;

@Repository
public class SearchDAOImpl implements SearchDAO {

	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	// [검색X, 시/도 선택X, 시/구 선택X] - 전체 병원 list 개수 
	@Override
	public int getHosCount() throws SQLException {
		
		System.out.println("getHosCount!");
		// 병원 전체 list 개수 가져오기 (board 테이블 활용해 보기)
		int result = sqlSession.selectOne("search.hosCountAll");
		
		return result;
	}

	// [검색X, 시/도 선택X, 시/구 선택X] - 전체 병원 list 
	@Override
	public List<HospitalDTO> getHospitals(int start, int end) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<HospitalDTO> hosList = sqlSession.selectList("search.getHospitals", map);
		
		return hosList;
	}
	

	// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list 개수 
	@Override
	public int getSearchHosCount(String search) throws SQLException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		
		int result = sqlSession.selectOne("search.getSearchHosCount", map);
		System.out.println("sDAOImpl 검색O 병원 개수 result : " + result);
		
		return result;
	}
	
	// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list
	@Override
	public List<HospitalDTO> getSearchHospitals(String search, int start, int end) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("start", start);
		map.put("end", end);
		
		List<HospitalDTO> hosList = sqlSession.selectList("search.getSearchHosList", map);
		
		return hosList;
	}

	
//	// [검색X, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 개수 
//	@Override
//	public int getSelSearchHosCount(String sidoSel, String siguSel) throws SQLException {
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		map.put("sidoSel", sidoSel);
//		map.put("siguSel", siguSel);
//		
//		System.out.println("cSidSel : " + map.get("sidoSel"));
//		System.out.println("cSiguSel : " + map.get("siguSel"));
//		
//		int result = sqlSession.selectOne("search.getSelSearchHosCount", map);
//		System.out.println("sDAOImpl 시/구(자식)선택 병원 개수 result : " + result);
//		
//		return result;
//	}
//
//	// [검색X, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 
//	@Override
//	public List<HospitalDTO> getSelSearchHospitals(String sidoSel, String siguSel, int start, int end) throws SQLException {
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		map.put("sidoSel", sidoSel);
//		map.put("siguSel", siguSel);
//		map.put("start", start);
//		map.put("end", end);
//		
//		System.out.println("sDAOImpl sidoSel : " + sidoSel);
//		System.out.println("sDAOImpl siguSel : " + siguSel);
//		System.out.println("sDAOImpl start : " + start);
//		System.out.println("sDAOImpl end : " + end);
//		
//		List<HospitalDTO> hosList = sqlSession.selectList("search.getSelSearchHosList", map);
//		
//		return hosList;
//	}

	// [검색O, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 개수
	@Override
	public int getSelHosCount(String sidoSel, String siguSel, String search) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("sidoSel", sidoSel);
		map.put("siguSel", siguSel);
		map.put("search", search);
		
		System.out.println("getSelHosCount - sidoSel : " + map.get("sidoSel"));
		System.out.println("getSelHosCount - siguSel : " + map.get("siguSel"));
		System.out.println("getSelHosCount - search : " + map.get("search"));
		
		int result = sqlSession.selectOne("search.getSelHosCount", map);
		System.out.println("getSelHosCount - hosCount : " + result);
		
		return result;
	}

	// [검색O, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 
	@Override
	public List<RevCountDTO> getSelSearchList(String sidoSel, String siguSel, String search, int start, int end)
			throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("sidoSel : " + sidoSel);
		System.out.println("siguSel : " + siguSel);
		System.out.println("search : " + search);
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		map.put("sidoSel", sidoSel);
		map.put("siguSel", siguSel);
		map.put("search", search);	
		map.put("start", start);	
		map.put("end", end);	
		
		List<RevCountDTO> hosList = sqlSession.selectList("search.getSelSearchList", map);
		
		return hosList;
	}


	
	

	
	

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	
	
}
