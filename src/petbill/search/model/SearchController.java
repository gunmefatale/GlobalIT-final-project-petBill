package petbill.search.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import petbill.hospital.model.HospitalDTO;

@Controller
@RequestMapping("/search/*")
public class SearchController {

	@Autowired
	private SearchServiceImpl searchService = null;
	
	// mapMain page 지도 페이지 
	@RequestMapping("mapMain.pet")
	public String mapMain() {
		
		return "search/mapMain";
	}
	
	
	// 서울특별시 선택시 페이지 이동 
	@RequestMapping("/loc/locSeoul.pet")
	public String locSeoul() throws SQLException {
		System.out.println("서울특별시");
		return "search/loc/locSeoul";
	}
	// 경기도 선택시 페이지 이동 
	@RequestMapping("/loc/locGyeonggi.pet")
	public String locGyeonggi() throws SQLException {
		System.out.println("경기도");
		return "search/loc/locGyeonggi";
	}
	// 인천광역시 선택시 페이지 이동 
	@RequestMapping("/loc/locIncheon.pet")
	public String locIncheon() throws SQLException {
		System.out.println("인천광역시");
		return "search/loc/locIncheon";
	}
	// 강원도 선택시 페이지 이동 
	@RequestMapping("/loc/locGangwon.pet")
	public String locGangwon() throws SQLException {
		System.out.println("강원도");
		return "search/loc/locGangwon";
	}
	// 충청남도 선택시 페이지 이동 
	@RequestMapping("/loc/locSouthChungcheong.pet")
	public String locSouthChungcheong() throws SQLException {
		System.out.println("충청남도");
		return "search/loc/locSouthChungcheong";
	}
	// 대전광역시 선택시 페이지 이동 
	@RequestMapping("/loc/locDaejeon.pet")
	public String locDaejeon() throws SQLException {
		System.out.println("대전광역시");
		return "search/loc/locDaejeon";
	}
	// 충청북도 선택시 페이지 이동 
	@RequestMapping("/loc/locNorthChungchung.pet")
	public String locNorthChungchung() throws SQLException {
		System.out.println("충청북도");
		return "search/loc/locNorthChungchung";
	}
	// 세종특별자치구 선택시 페이지 이동 
	@RequestMapping("/loc/locSejong.pet")
	public String locSejong() throws SQLException {
		System.out.println("세종특별자치구");
		return "search/loc/locSejong";
	}
	// 부산광역시 선택시 페이지 이동 
	@RequestMapping("/loc/locBusan.pet")
	public String locBusan() throws SQLException {
		System.out.println("부산광역시");
		return "search/loc/locBusan";
	}
	// 울산광역시 선택시 페이지 이동 
	@RequestMapping("/loc/locUlsan.pet")
	public String locUlsan() throws SQLException {
		System.out.println("울산광역시");
		return "search/loc/locUlsan";
	}
	// 대구광역시 선택시 페이지 이동 
	@RequestMapping("/loc/locDaegu.pet")
	public String locDaegu() throws SQLException {
		System.out.println("대구광역시");
		return "search/loc/locDaegu";
	}
	// 경상북도 선택시 페이지 이동 
	@RequestMapping("/loc/locNorthGyeongsang.pet")
	public String locNorthGyeongsang() throws SQLException {
		System.out.println("경상북도");
		return "search/loc/locNorthGyeongsang";
	}
	// 경상남도 선택시 페이지 이동 
	@RequestMapping("/loc/locSouthGyeongsang.pet")
	public String locSouthGyeongsang() throws SQLException {
		System.out.println("경상남도");
		return "search/loc/locSouthGyeongsang";
	}
	// 전라남도 선택시 페이지 이동 
	@RequestMapping("/loc/locSouthJeolla.pet")
	public String locSouthJeolla() throws SQLException {
		System.out.println("전라남도");
		return "search/loc/locSouthJeolla";
	}
	// 광주광역시 선택시 페이지 이동 
	@RequestMapping("/loc/locGwangju.pet")
	public String locGwangju() throws SQLException {
		System.out.println("광주광역시");
		return "search/loc/locGwangju";
	}
	// 전라북도 선택시 페이지 이동 
	@RequestMapping("/loc/locNorthJeolla.pet")
	public String locNorthJeolla() throws SQLException {
		System.out.println("전라북도");
		return "search/loc/locNorthJeolla";
	}
	// 제주도 선택시 페이지 이동 
	@RequestMapping("/loc/locJeju.pet")
	public String locJeju() throws SQLException {
		System.out.println("제주도");
		return "search/loc/locJeju";
	}
	
	
	
	
	// [검색X, 시/도 선택X, 시/구 선택X] 전체 병원 리스트 
	@RequestMapping("searchResult.pet")		// searchResult.pet?pageNum=
	public String searchResult(HttpServletRequest request, String pageNum, String sidoSel, String siguSel, String search, Model model) throws SQLException {
		// 해당 페이지에 맞는 화면에 뿌려줄 병원 list 가져와 view에 전달 
		Map<String, Object> result = null;
		System.out.println("sidoSel : " + sidoSel);
		System.out.println("siguSel :" + siguSel);
		System.out.println("search :" + search);
		result = searchService.getSel(pageNum, sidoSel, siguSel, search);
		
//		Map<String, Object> reviewListCount = null;
//		reviewListCount = searchService.getRevListCount(hosNo);
		
//		// [검색X, 시/도 선택X, 시/구 선택X]     
//		if (search == null && siguSel == null || sidoSel == null) {			// 검색X 시/도,구 선택X    
//			System.out.println("1111111111111111111");
//			result = searchService.getHosList(pageNum);
//		}
//		// [검색O, 시/도 선택X, 시/구 선택X] - 검색한 병원 list 
//		if (search != null) {												// 검색O
//			System.out.println("222222222222222222222");
//			result = searchService.getSearchHosList(pageNum, search);
//		}
//		// [검색X, 시/도 선택O, 시/구 선택O] - 선택 / 검색한 병원 list 
//		if (siguSel != null || sidoSel != null) {							// 시/도,구 선택O
//			System.out.println("3333333333333333333333");
//			
//			result = searchService.getSelHosList(pageNum, sidoSel, siguSel);
//		} 
		
	
		
		// view에 전달할 데이터 보내기 
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("hosList", result.get("hosList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("number", result.get("number"));
		// petType 추가 : 혜란
		String petType = (String)request.getParameter("petType");
		model.addAttribute("petType", petType);
		
		model.addAttribute("search", result.get("search"));
		model.addAttribute("sidoSel", result.get("sidoSel"));	// 시/도 (부모) 파라미터 값 
		model.addAttribute("siguSel", result.get("siguSel"));	// 시/구 (자식) 파라미터 값 
		
		
		
		return "search/searchResult";
	}


	
	
	
	
}
