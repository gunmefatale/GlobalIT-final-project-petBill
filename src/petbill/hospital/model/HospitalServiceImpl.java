package petbill.hospital.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import petbill.review.model.ReviewDTO;
import petbill.search.model.RevCountDTO;

@Service
public class HospitalServiceImpl implements HospitalService{
	
	@Autowired
	// 같은 패키지 내에 있어서 임포트 시킬 필요없음!! 
	private HospitalDAOImpl HospitalDAO = null;
	
	// 해당 병원정보 가져오기 -> hosContent
	@Override
	public HospitalDTO getHosArticle(int hosNo) throws SQLException {
	
		HospitalDTO article = HospitalDAO.getHosArticle(hosNo);
		return article;
	}
	
	// 리뷰목록 가져오기 -> hosContent
	@Override
	public Map<String, Object> getRevArticles(int hosNo, String pageNumRe) throws SQLException {
		
		// ** 게시글 페이지 관련 정보 세팅 ** 
		// 한페이지에 보여줄 게시글의 수 
		int pageSize = 10; 
		// 현재 페이지 번호  
		if(pageNumRe == null){ // list.jsp 라고만 요청했을때, 즉 pageNum 파라미터 안넘어왔을때.
			pageNumRe = "1";
		}
		
		// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅 
		int currentPage = Integer.parseInt(pageNumRe); 	 // 계산을 위해 현재페이지 숫자로 변환하여 저장 
		int startRow = (currentPage - 1) * pageSize + 1; // 페이지 시작글 번호 
		int endRow = currentPage * pageSize; 			 // 페이지 마지막 글번호
		
		// 리뷰 리스트 가져오기 
		// 밖에서 사용가능하게 if문 시작 전에 미리 선언
		List<ReviewDTO> revArticleList = null;  	// 전체 게시글들 담아줄 변수
		int count = 0; 							// 전체 글의 개수 
		int number = 1; 						// 브라우저 화면에 뿌려줄 가상 글 번호
		
		// 해당병원 리뷰 전체 개수 가져오기 
		count = HospitalDAO.getRevArticleCount(hosNo);   // DB에 저장되어있는 전체 리뷰글의 개수를 가져와 담기
		System.out.println("count : " + count);
		// 글이 하나라도 있으면 글들 가져오기 
		if(count > 0){
			// 해당병원 리뷰 가져오기
			revArticleList = HospitalDAO.getRevArticles(startRow, endRow, hosNo);
			
		}
		
		// 목록에 뿌려줄 가상의 글 번호
		number = count - (currentPage-1) * pageSize;
		System.out.println("number : " + number);
		System.out.println("pageNumRe : " + pageNumRe);
		
		// *** 순서대로 정렬로 꺼내고싶으면 List, 이름으로 꺼내려면 Map 타입!
		// Controller에 전달할 데이터가 많으니 HashMap에 넘겨줄 데이터를 저장해서 한번에 전달.
		// HashMap에 넣어서 리턴
		Map<String, Object> result = new HashMap(); //여기에 다시 담아서 보내주기 <제네릭타입> <key("문자"), value(다양한타입을 넣는거라 Object)>
		
		result.put("pageSize", pageSize);
		result.put("pageNumRe", pageNumRe);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("revArticleList", revArticleList);
		result.put("count", count);
		result.put("number", number);
		
		return result;
	}
	
	// 강아지 진료비평균 가져오기 (전국/ 시도/ 시군구/ 리뷰) -> hosContent
	@Override
	public Map<String, String> getAvg(String petType, String diagnosis) throws SQLException {	
		//전국 진료비 평균 담기
		Map<String, String> getAvg = HospitalDAO.getAvg(petType, diagnosis);	
		return getAvg;
	}
	@Override
	public Map<String, String> getAvgSi(String petType, String hosSi, String diagnosis) throws SQLException {		
		//시도
		Map<String, String> getAvgSi = HospitalDAO.getAvgSi(petType, hosSi, diagnosis);		
		return getAvgSi;
	}
	@Override
	public Map<String, String> getAvgGu(String petType, String hosGu, String diagnosis) throws SQLException {		
		//시군구 
		Map<String, String> getAvgGu = HospitalDAO.getAvgGu(petType, hosGu, diagnosis);		
		return getAvgGu;
	}
	@Override
	public Map<String, String> getAvgRe(String petType, int hosNo, String diagnosis) throws SQLException {	
		//리뷰
		Map<String, String> getAvgRe = HospitalDAO.getAvgRe(petType, hosNo, diagnosis);	
		return getAvgRe;
	}
	
	
	// 병원 리뷰평균 진료비 가져오기
	@Override
	public Map<String, String> getAArticle(int hosNoA, String petType, String diagnosis) throws SQLException {
		
		Map<String, String> getAArticle = HospitalDAO.getAArticle(hosNoA, petType, diagnosis);
		
		return getAArticle;
	}
	
	@Override
	public Map<String, String> getBArticle(int hosNoB, String petType, String diagnosis) throws SQLException {
		
		Map<String, String> getBArticle = HospitalDAO.getBArticle(hosNoB, petType, diagnosis);
		
		return getBArticle;
	}

	
	// 리뷰 개수
	@Override
	public Map getAvgReCount(String petType, int hosNo, String diagnosis) throws SQLException {
		
		
		
		int getAvgReCount = 0;
		getAvgReCount = HospitalDAO.getAvgReCount(petType, hosNo, diagnosis);
		 
		Map Count = new HashMap();
		Count.put("getAvgReCount", getAvgReCount);
		
		return Count;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
