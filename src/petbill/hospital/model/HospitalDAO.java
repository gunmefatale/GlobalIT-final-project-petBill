package petbill.hospital.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import petbill.review.model.ReviewDTO;

public interface HospitalDAO {
		
	// 해당 병원정보 1개 가져오기 -> hosContent
	public HospitalDTO getHosArticle(int hosNo) throws SQLException;
	// 리뷰목록 개수 가져오기 -> hosContent
	public int getRevArticleCount(int hosNo) throws SQLException;
	// 하나의 페이지에 채울(10개) 리뷰목록 가져오기 startRow, endRow(범위필요 1(start) ~ 10(end)) -> hosContent
	public List<ReviewDTO> getRevArticles(int start, int end, int hosNo) throws SQLException;
	// 전국평균값 가져오기
	public Map<String, String> getAvg(String petType, String diagnosis) throws SQLException;
	// 시 평균값 가져오기
	public Map<String, String> getAvgSi(String petType, String hosSi, String diagnosis) throws SQLException;
	// 구 평균값 가져오기
	public Map<String, String> getAvgGu(String petType, String hosGu, String diagnosis) throws SQLException;
	// 리뷰 평균값 가져오기
	public Map<String, String> getAvgRe(String petType, int hosNo, String diagnosis) throws SQLException;
	
	// 리뷰 개수
	public int getAvgReCount(String petType, int hosNo, String diagnosis) throws SQLException;
	
	// A병원 강아지 진료비평균 가져오기 
	public Map<String, String> getAArticle(int hosNoA, String petType, String diagnosis) throws SQLException;
	// B병원 강아지 리뷰평균 진료비가져오기 -> hosCompare
	public Map<String, String> getBArticle(int hosNoB, String petType, String diagnosis) throws SQLException;
	
	
	
}
