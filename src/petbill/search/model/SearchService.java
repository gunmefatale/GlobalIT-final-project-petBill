package petbill.search.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import petbill.hospital.model.HospitalDTO;

public interface SearchService {

	// ======================================= searchResult 관련 ===================================================
	
	// [검색X, 시/도 선택X, 시/구 선택X] - 전체 병원 list 개수 
	public Map<String, Object> getHosList(String pageNum) throws SQLException;
	
	// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list 
	public Map<String, Object> getSearchHosList(String pageNum, String search) throws SQLException;
	
	// [검색O, 시/도 선택O, 시/구 선택O] - 선택O / 검색O 병원 list
	public Map<String, Object> getSel(String pageNum, String sidoSel, String siguSel, String search) throws SQLException;
	
}
