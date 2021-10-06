package petbill.search.model;

import java.sql.SQLException;
import java.util.List;

import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;

public interface SearchDAO {

	// [검색X, 시/도 선택X, 시/구 선택X] - 전체 병원 list count 
	public int getHosCount() throws SQLException;
	
	// [검색X, 시/도 선택X, 시/구 선택X] - 전체 병원 list count
	public List<HospitalDTO> getHospitals(int start, int end) throws SQLException;
	
	// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list count
	public int getSearchHosCount(String search) throws SQLException;
	
	// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list
	public List<HospitalDTO> getSearchHospitals(String search, int start, int end) throws SQLException;
	
	
	// [검색O, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 개수 
	public int getSelHosCount(String sidoSel, String siguSel, String search) throws SQLException;
		
	// [검색O, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 
	public List<RevCountDTO> getSelSearchList(String sidoSel, String siguSel, String search, int start, int end) throws SQLException;
	
	
	// 
	
}
