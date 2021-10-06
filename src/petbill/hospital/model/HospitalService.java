package petbill.hospital.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public interface HospitalService {
	
	// 해당병원 1개 정보 가져오기 -> hosContent
	public HospitalDTO getHosArticle(int hosNo) throws SQLException;
	// 해당병원 리뷰 가져오기 -> hosContent
	public Map<String, Object> getRevArticles(int hosNo, String pageNumRe) throws SQLException;
	// 전국평균값 가져오기 -> hosContent
	public Map<String, String> getAvg(String petType, String diagnosis) throws SQLException;
	// 시 평균값 가져오기 -> hosContent
	public Map<String, String> getAvgSi(String petType, String hosSi, String diagnosis) throws SQLException;
	// 구 평균값 가져오기 -> hosContent 
	public Map<String, String> getAvgGu(String petType, String hosGu, String diagnosis) throws SQLException;
	// 리뷰 평균값 가져오기 -> hosContent
	public Map<String, String> getAvgRe(String petType, int hosNo, String diagnosis) throws SQLException;
	
	// 리뷰 개수
	public Map getAvgReCount(String petType, int hosNo, String diagnosis) throws SQLException;
	
	
	// A병원 리뷰평균 진료비가져오기 -> hosCompare
	public Map<String, String> getAArticle(int hosNoA, String petType, String diagnosis) throws SQLException;
	// B병원 리뷰평균 진료비가져오기 -> hosCompare
	public Map<String, String> getBArticle(int hosNoB, String petType, String diagnosis) throws SQLException;
	
	
	
}
