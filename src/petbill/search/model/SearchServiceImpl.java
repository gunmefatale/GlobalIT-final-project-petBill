package petbill.search.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jca.cci.object.EisOperation;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;

@Service	// component-scan 을 이용해 자동으로 빈으로 등록시킬것임 (객체생성) 
public class SearchServiceImpl implements SearchService {

	@Autowired
	private SearchDAOImpl searchDAO = null; 
	
	// [검색X, 시/도 선택X, 시/구 선택X] - 전체 병원 list 
	@Override
	public Map<String, Object> getHosList(String pageNum) throws SQLException {
		
		// ** 게시글 페이지 관련 정보 세팅 **
		// 한페이지에 보여줄 병원 list 수 
		int pageSize = 10;
		// 현재 페이지 번호 설정해주기. 파라미터 값 없으면 1로 설정. 
		if (pageNum == null) {	// searchResult.pet 으로만 요청시, 즉 pageNum 파라미터가 안넘어 왔을때 
			pageNum = "1";
		}
		
		// 현재 페이지에 보여줄 병원 list 의 시작과 끝 정보 등 세팅 
		int currentPage = Integer.parseInt(pageNum);		// 계산을 위해 현제 페이지 숫자로 변환하여 저장 
		int startRow = (currentPage - 1) * pageSize + 1;	// 페이지 시작 글 번호 
		int endRow = currentPage * pageSize;				// 페이지 마지막 글 번호 
		
		// 지역함수 외에 사용하기 위해 변수 생성 
		List<HospitalDTO> hosList = null;	// 전체(검색 또는 선택X) 게시글들 담아줄 변수 
		int count = 0;						// 전체(검색 또는 선택X) 글의 개수 
		int number = 0;						// 화면에 뿌려줄 가상 글 번호 
		
		System.out.println("getHosList!!");
		
		// 전체 병원list 개수 가져오기 
		count = searchDAO.getHosCount();
		// 병원 list 하나라도 있으면 병원 list 다시 가져오기 
		if (count > 0) {
			hosList = searchDAO.getHospitals(startRow, endRow);
		}
		System.out.println("검색X 전체병원list count : " + count);
		// 게시판 목록에 뿌려줄 가상의 글 번호 
		number = count - (currentPage - 1) * pageSize;	
		System.out.println("검색X 병원 검색 전체 number : " + number);
		
		
		// Controller에게 전달해야되는 데이터가 많으니 HashMap에 넘겨줄 데이터를 저장해서 한번에 전달 
		// 'list'의 경우 '순서대로 정렬'된 데이터를 보낼때 사용 
		// 'HashMap' or 'Map'의 경우 정확한 '이름' 가지고 데이터를 꺼낼때 사용.
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("hosList", hosList);
		result.put("count", count);
		result.put("number", number);
//		result.put("revCount", revCount);
		
		return result;
	}

	
	// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list
	@Override
	public Map<String, Object> getSearchHosList(String pageNum, String search) throws SQLException {
		// ** 게시글 페이지 관련 정보 세팅 **
		// 한페이지에 보여줄 병원 list 수 
		int pageSize = 10;
		// 현재 페이지 번호 설정해주기. 파라미터 값 없으면 1로 설정. 
		if (pageNum == null) {	// searchResult.pet 으로만 요청시, 즉 pageNum 파라미터가 안넘어 왔을때 
			pageNum = "1";
		}
		
		// 현재 페이지에 보여줄 병원 list 의 시작과 끝 정보 등 세팅 
		int currentPage = Integer.parseInt(pageNum);		// 계산을 위해 현제 페이지 숫자로 변환하여 저장 
		int startRow = (currentPage - 1) * pageSize + 1;	// 페이지 시작 글 번호 
		int endRow = currentPage * pageSize;				// 페이지 마지막 글 번호 
		
		// 지역함수 외에 사용하기 위해 변수 생성 
		List<HospitalDTO> hosList = null;	// 전체(검색 또는 선택X) 게시글들 담아줄 변수 
		int count = 0;						// 전체(검색 또는 선택X) 글의 개수 
		int number = 0;						// 화면에 뿌려줄 가상 글 번호 
		
		// 검색한 병원list 개수 가져오기 
		count = searchDAO.getSearchHosCount(search);
		System.out.println("검색O list count : " + count);
		
		// 검색한 병원이 하나라도 있으면 검색한 병원 list 다시 가져오기 
		if (count > 0) {
			hosList = searchDAO.getSearchHospitals(search, startRow, endRow);
		}
		
		// 검색한 병원 목록에 뿌려줄 가상의 글 번호 
		number = count - (currentPage - 1) * pageSize;	
		System.out.println("검색O number : " + number);
		System.out.println("검색O search : " + search);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("hosList", hosList);
		result.put("count", count);
		result.put("number", number);
		result.put("search", search);
		
		return result;
	}

	
//	// [검색X, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list
//	// [지도] 
//	@Override
//	public Map<String, Object> getSelHosList(String pageNum, String sidoSel, String siguSel) throws SQLException {
//		System.out.println("1");
//		System.out.println("page : " + pageNum);
//		
//		
//		
//		// ** 게시글 페이지 관련 정보 세팅 **
//		// 한페이지에 보여줄 병원 list 수 
//		int pageSize = 10;
//		// 현재 페이지 번호 설정해주기. 파라미터 값 없으면 1로 설정. 
//		if (pageNum == null) {	// searchResult.pet 으로만 요청시, 즉 pageNum 파라미터가 안넘어 왔을때 
//			pageNum = "1";
//		}
//		
//		// 현재 페이지에 보여줄 병원 list 의 시작과 끝 정보 등 세팅 
//		int currentPage = Integer.parseInt(pageNum);		// 계산을 위해 현제 페이지 숫자로 변환하여 저장 
//		int startRow = (currentPage - 1) * pageSize + 1;	// 페이지 시작 글 번호 
//		int endRow = currentPage * pageSize;				// 페이지 마지막 글 번호 
//			
//		System.out.println("2");
//		// 지역함수 외에 사용하기 위해 변수 생성 
//		List<HospitalDTO> hosList = null;	// 전체(검색 또는 선택X) 게시글들 담아줄 변수 
//		int count = 0;						// 전체(검색 또는 선택X) 글의 개수 
//		int number = 0;						// 화면에 뿌려줄 가상 글 번호 
//		
//		// 지역 선택 및 검색한 병원list 개수 가져오기 
//		count = searchDAO.getSelSearchHosCount(sidoSel, siguSel);
//		System.out.println("시/도,구O(부/자) 검색X list count : " + count);
//		// 조건에 해당하는 병원 list가 하나라도 있으면 검색한 병원 list 다시 가져오기 
//		if (count > 0) {
//			hosList = searchDAO.getSelSearchHospitals(sidoSel, siguSel, startRow, endRow);
//		}
//		
//		// 검색한 병원 목록에 뿌려줄 가상의 글 번호 
//		number = count - (currentPage - 1) * pageSize;	
//		System.out.println("시/도,구O(부/자) number : " + number);
//		System.out.println("sServiceImpl sidoSel : " + sidoSel);
//		System.out.println("sServiceImpl siguSel : " + siguSel);
//		System.out.println("sServiceImpl startRow : " + startRow);
//		System.out.println("sServiceImpl endRow : " + endRow);
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		
//		result.put("pageSize", pageSize);
//		result.put("currentPage", currentPage);
//		result.put("startRow", startRow);
//		result.put("endRow", endRow);
//		result.put("hosList", hosList);
//		result.put("count", count);
//		result.put("number", number);
//		
//		result.put("pageNum", pageNum);
//		result.put("sidoSel", sidoSel);
//		result.put("siguSel", siguSel);
//		
//		return result;
//	}


	// [검색O, 시/도 선택O, 시/구 선택O] - 선택O / 검색O 병원 list
	@Override
	public Map<String, Object> getSel(String pageNum, String sidoSel, String siguSel, String search)
			throws SQLException {
		
		// ** 게시글 페이지 관련 정보 세팅 **
		// 한페이지에 보여줄 병원 list 수 
		int pageSize = 10;
		// 현재 페이지 번호 설정해주기. 파라미터 값 없으면 1로 설정. 
		if (pageNum == null) {	// searchResult.pet 으로만 요청시, 즉 pageNum 파라미터가 안넘어 왔을때 
			pageNum = "1";
		}
		
		// 현재 페이지에 보여줄 병원 list 의 시작과 끝 정보 등 세팅 
		int currentPage = Integer.parseInt(pageNum);		// 계산을 위해 현제 페이지 숫자로 변환하여 저장 
		int startRow = (currentPage - 1) * pageSize + 1;	// 페이지 시작 글 번호 
		int endRow = currentPage * pageSize;				// 페이지 마지막 글 번호 
			
		System.out.println("2");
		// 지역함수 외에 사용하기 위해 변수 생성 
		List<RevCountDTO> hosList = null;	// 전체(검색 또는 선택X) 게시글들 담아줄 변수 
		int count = 0;						// 전체(검색 또는 선택X) 글의 개수 
		int number = 0;						// 화면에 뿌려줄 가상 글 번호 
		
		// 지역 선택 및 검색한 병원list 개수 가져오기 
		count = searchDAO.getSelHosCount(sidoSel, siguSel, search);
		System.out.println("시/도,구O(부/자) 검색O list count : " + count);
		
		// 조건에 해당하는 병원 list가 하나라도 있으면 검색한 병원 list 다시 가져오기 
		if (count > 0) {
			hosList = searchDAO.getSelSearchList(sidoSel, siguSel, search, startRow, endRow);
		}
		
		
		// 검색한 병원 목록에 뿌려줄 가상의 글 번호 
		number = count - (currentPage - 1) * pageSize;	
		System.out.println("시/도,구O(부/자) number : " + number);
		System.out.println("getSelHosCount sidoSel : " + sidoSel);
		System.out.println("getSelHosCount siguSel : " + siguSel);
		System.out.println("getSelHosCount startRow : " + startRow);
		System.out.println("getSelHosCount endRow : " + endRow);
		
		
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("pageSize", pageSize);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("hosList", hosList);
		result.put("count", count);
		result.put("number", number);
		
		result.put("pageNum", pageNum);
		result.put("sidoSel", sidoSel);
		result.put("siguSel", siguSel);
		result.put("search", search);
		
		
		return result;
	}


	





	
	
	
	
	
	
}
