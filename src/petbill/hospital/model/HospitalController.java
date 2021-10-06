package petbill.hospital.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import petbill.review.model.ReviewDTO;
import petbill.search.model.SearchController;
import petbill.search.model.SearchServiceImpl;
import petbill.user.model.UserDTO;
import petbill.user.model.UserServiceImpl;

@Controller
@RequestMapping("/hospital/*")
public class HospitalController {
	
	// 메서드 써먹기위해 자동주입 다른패키지것도 이렇게 선언해주면 사용가능!
	@Autowired 
	private HospitalServiceImpl HospitalService = null;
	@Autowired
	private SearchServiceImpl searchService = null;
	@Autowired
	private UserServiceImpl UserService = null;
	
	// 병원상세 hosContent : hosNo, hosSi, hosGu, pageNum, hosDto, model
	@RequestMapping("hosContent.pet")
	public String hosContent(
			@ModelAttribute("hosNo") int hosNo,
			@ModelAttribute("hosSi") String hosSi, @ModelAttribute("hosGu") String hosGu,
			String pageNum, String pageNumRe, 
			String petType, String diagnosis, 
			Map<String, String> getAvg, Map<String, String> getAvgSi, Map<String, String> getAvgGu, Map<String, String> getAvgRe,
			HospitalDTO article, ReviewDTO revDto, Model model, HttpSession session) throws SQLException{
		
		// ** 태준 추가 21.09.23 **
		UserDTO dto = null;
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
		}
		
		// # 화면에 뿌려줄 데이터가져오기
		// 1. 병원 1개 정보 dto
		article = HospitalService.getHosArticle(hosNo);
		model.addAttribute("article", article);
		

		
		// 2. 평균값 가져오기
		// 전국 / 시 / 구 / 리뷰
		getAvg = HospitalService.getAvg(petType, diagnosis);		
		getAvgSi = HospitalService.getAvgSi(petType, hosSi, diagnosis);
		getAvgGu = HospitalService.getAvgGu(petType, hosGu, diagnosis);
		getAvgRe = HospitalService.getAvgRe(petType, hosNo, diagnosis);
		
		Map<String, Object> getAvgReCount = null;
		getAvgReCount = HospitalService.getAvgReCount(petType, hosNo, diagnosis);
		
		
		
		model.addAttribute("getAvg", getAvg);
		model.addAttribute("getAvgSi", getAvgSi);
		model.addAttribute("getAvgGu", getAvgGu);
		model.addAttribute("getAvgRe", getAvgRe);
		
		
		
		model.addAttribute("getAvgReCount", getAvgReCount.get("getAvgReCount"));
		
		
		
		// 3. 해당병원 리뷰들 가져오기
		// 리뷰List 페이지번호 뿌리기위한 데이터 Map타입으로 담아줌
		Map<String, Object> result = null;
		result = HospitalService.getRevArticles(hosNo, pageNumRe);
		model.addAttribute("pageSize", result.get("pageSize"));
		// 리뷰의 페이지번호
		model.addAttribute("pageNumRe", result.get("pageNumRe"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("number", result.get("number"));
		// 리뷰 List 
		model.addAttribute("revArticleList", result.get("revArticleList"));
		
		// 강아지-고양이 변환을 위한 pageNum 보내기
		model.addAttribute("pageNum", pageNum);
		
		// 태준님 추가 9.13
		model.addAttribute("petType", petType);
	    model.addAttribute("diagnosis", diagnosis);
	    model.addAttribute("dto", dto);
	    
	    
	    
		
		return "hospital/hosContent";
	}
	
	// 평균비교 ajax - hosContent
	@RequestMapping("ajaxAvg.pet")
	public String selectTest(HttpServletRequest request, int hosNo, 
			Map<String, String> getAvg, Map<String, String> getAvgSi, Map<String, String> getAvgGu, Map<String, String> getAvgRe, 
			HospitalDTO article, 
			Model model) throws SQLException{
		
		// hosNo파라미터 int로 형변환
		int ajaxHosNo = Integer.parseInt(request.getParameter("hosNo"));
		// 1. 병원 1개 정보 dto
		article = HospitalService.getHosArticle(ajaxHosNo);
		model.addAttribute("article", article);		
		String petType = (String)request.getParameter("petType");
		String diagnosis = (String)request.getParameter("diagnosis");
		String hosSi = (String)request.getParameter("hosSi");
		String hosGu = (String)request.getParameter("hosGu");
		
		// 2. 평균값 가져오기
		// 전국 / 시 / 구 / 리뷰
		getAvg = HospitalService.getAvg(petType, diagnosis);		
		getAvgSi = HospitalService.getAvgSi(petType, hosSi, diagnosis);
		getAvgGu = HospitalService.getAvgGu(petType, hosGu, diagnosis);
		getAvgRe = HospitalService.getAvgRe(petType, ajaxHosNo, diagnosis);
		
		// 리뷰 개수 카운트
		Map<String, Object> getAvgReCount = null;
		getAvgReCount = HospitalService.getAvgReCount(petType, hosNo, diagnosis);
		
		model.addAttribute("getAvg", getAvg);
		model.addAttribute("getAvgSi", getAvgSi);
		model.addAttribute("getAvgGu", getAvgGu);
		model.addAttribute("getAvgRe", getAvgRe);
		model.addAttribute("petType", petType);
		model.addAttribute("diagnosis", diagnosis);
		// 리뷰 개수 카운트
		model.addAttribute("getAvgReCount", getAvgReCount.get("getAvgReCount"));
		
		System.out.println("getAvgReCount : " + getAvgReCount );
		
		System.out.println("ajax petType : "+ petType);
		
		return "hospital/ajaxAvg";
	}
	
	// 병원 진료비 비교페이지 -> hosCompare
	@RequestMapping("hosCompare.pet")
	public String hosCompare(HttpServletRequest request, 
			String sidoSel, String siguSel, String search, Model model)throws SQLException{
		
		System.out.println("hosCompare!!");
		
		return "hospital/hosCompare";
	}
	// 병원 진료비 비교 A병원 새창 -> hosCompare
	@RequestMapping("ajaxCompareA.pet")
	public String ajaxCompareA(HttpServletRequest request, 
			String sidoSel, String siguSel, String search, Model model)throws SQLException{
		
		String petType = (String)request.getParameter("petType");
		String pageNum = (String)request.getParameter("pageNum");
		sidoSel = (String)request.getParameter("sidoSel");
		siguSel = (String)request.getParameter("siguSel");
		model.addAttribute("petType", petType);
		
		// 해당 페이지에 맞는 화면에 뿌려줄 병원 list 가져와 view에 전달 
		Map<String, Object> result = null;
		// 태준님 수정 09.17
		result = searchService.getSel(pageNum, sidoSel, siguSel, search);
		
		// view에 전달할 데이터 보내기 
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("hosList", result.get("hosList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("number", result.get("number"));
		
		model.addAttribute("search", result.get("search"));
		model.addAttribute("sidoSel", result.get("sidoSel"));	// 시/도 (부모) 파라미터 값 
		model.addAttribute("siguSel", result.get("siguSel"));	// 시/구 (자식) 파라미터 값 
		
		
		return "hospital/ajaxCompareA";
	}
	// 병원 진료비 비교 B병원 새창 -> hosCompare
	@RequestMapping("ajaxCompareB.pet")
	public String ajaxCompareB(HttpServletRequest request, 
			String sidoSel, String siguSel, String search, Model model)throws SQLException{
		
		String petType = (String)request.getParameter("petType");
		String pageNum = (String)request.getParameter("pageNum");
		sidoSel = (String)request.getParameter("sidoSel");
		siguSel = (String)request.getParameter("siguSel");
		model.addAttribute("petType", petType);
		
		// 해당 페이지에 맞는 화면에 뿌려줄 병원 list 가져와 view에 전달 
		Map<String, Object> result = null;
		// 태준님수정 09.17
		result = searchService.getSel(pageNum, sidoSel, siguSel, search);
		
		// view에 전달할 데이터 보내기 
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("hosList", result.get("hosList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("number", result.get("number"));
		
		model.addAttribute("search", result.get("search"));
		model.addAttribute("sidoSel", result.get("sidoSel"));	// 시/도 (부모) 파라미터 값 
		model.addAttribute("siguSel", result.get("siguSel"));	// 시/구 (자식) 파라미터 값 
		
		
		return "hospital/ajaxCompareB";
	}
	
	//병원진료비 비교 ajax -> hosCompare
	@RequestMapping("compareAB.pet")
	public String compareAB(
			HttpServletRequest request, 
			String petType, String diagnosis, 
			int hosNoA, int hosNoB, 
			HospitalDTO article1, HospitalDTO article2, 
			Map<String, String> articleA, Map<String, String> articleB, 
			Model model)throws SQLException{

		// A,B병원정보 dto가져오기위해 hosNo들 int로 형변환 
		hosNoA = Integer.parseInt(request.getParameter("hosNoA"));
		hosNoB = Integer.parseInt(request.getParameter("hosNoB"));
		System.out.println("petType : " + petType);
		System.out.println("diagnosis : " + diagnosis);
		System.out.println("hosNoA : " + hosNoA);
		System.out.println("hosNoB : " + hosNoB);
		
		// # 화면에 뿌려줄 데이터가져오기
		// 1. A,B 병원 2개 정보 dto
		article1 = HospitalService.getHosArticle(hosNoA);
		article2 = HospitalService.getHosArticle(hosNoB);
		model.addAttribute("article1", article1);
		model.addAttribute("article2", article2);
		
		// 2. 리뷰 평균 진료비 정보 dto
		petType = (String)request.getParameter("petType");
		diagnosis = (String)request.getParameter("diagnosis");
		articleA = HospitalService.getAArticle(hosNoA, petType, diagnosis);
		articleB= HospitalService.getBArticle(hosNoB, petType, diagnosis);
		model.addAttribute("articleA", articleA);
		model.addAttribute("articleB", articleB);
		
		return "hospital/compareAB";
	}
	
	//위도 경도 값 검색
	@RequestMapping("naverGeocoding.pet")
	public String naverGeocoding() throws SQLException{
		
		
		return "hospital/naverGeocoding";
	}
	

	

}
