package petbill.admin.model;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import petbill.admin.model.AdminDTO;
import petbill.hospital.model.CatDTO;
import petbill.hospital.model.DogDTO;
import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;
import petbill.search.model.SearchServiceImpl;
import petbill.user.model.MtmDTO;
import petbill.user.model.UserDTO;
import petbill.user.model.UserReviewDTO;
import petbill.user.model.UserServiceImpl;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	@Autowired
	private AdminServiceImpl AdminService = null;
	@Autowired
	private UserServiceImpl UserService = null;
	@Autowired
	private SearchServiceImpl searchService = null;


	//공지사항 작성
	@RequestMapping("adNoticeWrite.pet")
	public String adNoticeWrite() {
		
		return "admin/adNoticeContent";
	}
	
	//공지사항 저장
	@RequestMapping("adNoticeWritePro.pet")
	public String adNoticeWritePro(MultipartHttpServletRequest request,MultipartFile mf) throws SQLException {
		
	      AdminDTO dto = new AdminDTO();
	      dto.setNoticeId(request.getParameter("noticeId"));
	      dto.setNoticeSubject(request.getParameter("noticeSubject"));
	      dto.setNoticeContent(request.getParameter("noticeContent"));
	      
	      mf = request.getFile("noticePhoto");
	      String path = request.getRealPath("Notice");
	      String fileName = mf.getOriginalFilename();
	      if(!mf.isEmpty()) {
	         String contentType = mf.getContentType();
	         String[] type = contentType.split("/");
	         if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
	         mf = request.getFile("noticePhoto");
	         System.out.println("파일삭제 완료");
	         return "redirect:/review/alert.pet";
	         //return "redirect:/review/alert.pet";
	      }else {
	         String imgName = fileName.substring(0, fileName.lastIndexOf('.'));
	         String ext = fileName.substring(fileName.lastIndexOf('.'));
	         
	         UUID uuid = UUID.randomUUID();
	         String newName = uuid.toString().replace("-", "") + ext;
	         
	         String imgpath = path + "/" + newName;
	         File uploadFile = new File(imgpath);      
	      try { 
	         mf.transferTo(uploadFile);   
	      }catch(Exception e) {  
	         e.printStackTrace();
	      }
	         dto.setNoticePhoto(newName);
	      }
	   }
	      AdminService.insertArticle(dto);
		
		return "redirect:/admin/adNoticeList.pet"; 
	}

	// 공지사항 리스트 띄우기
	@RequestMapping("adNoticeList.pet")
	public String adNoticeList(String pageNum, String sel, String search, Model model) throws SQLException{
		
		HashMap<String, Object> result = null;
		
		if(sel == null || search == null) {//검색 안했을떄
			result = AdminService.getArticleList(pageNum);
		}else {
			result = AdminService.NoticeSearch(pageNum,sel,search);
		}
		
		// view에 전달할 데이터 보내주기
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("articleList", result.get("articleList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("number", result.get("number"));
		//검색했을때
		model.addAttribute("sel", sel);
		model.addAttribute("search", search);
	
		return "admin/adNoticeList";
	}
	
	//공지사항 content
	@RequestMapping("adNoticeContent.pet")
	public String adNoticeContent(int noticeNo, String pageNum, Model model) throws SQLException{
		
		//공지사항 글 가져오기
		AdminDTO dto = AdminService.getnotice(noticeNo);
		System.out.println("123");
		
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("dto",dto);
		
		return "admin/adNoticeContent";
	}
	
	//공지사항 수정
	@RequestMapping("adNoticeModifyForm.pet")
	public String adNoticeModifyForm(MultipartHttpServletRequest request,String pageNum, MultipartFile mf) throws SQLException{
		
	      AdminDTO dto = new AdminDTO();
	      dto.setNoticeNo((Integer.parseInt(request.getParameter("noticeNo")))); 
	      dto.setNoticeId(request.getParameter("noticeId"));
	      dto.setNoticeSubject(request.getParameter("noticeSubject"));
	      dto.setNoticeContent(request.getParameter("noticeContent"));
	      
	      AdminService.noticeModify(dto);
	      
	      mf = request.getFile("noticePhoto");
	      String path = request.getRealPath("Notice");
	      String fileName = mf.getOriginalFilename();
	      if(!mf.isEmpty()) {
	         String contentType = mf.getContentType();
	         String[] type = contentType.split("/");
	         if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
	         mf = request.getFile("noticePhoto");
	         System.out.println("파일삭제 완료");
	         return "redirect:/review/alert.pet";
	         //return "redirect:/review/alert.pet";
	      }else {
	         String imgName = fileName.substring(0, fileName.lastIndexOf('.'));
	         String ext = fileName.substring(fileName.lastIndexOf('.'));
	         
	         UUID uuid = UUID.randomUUID();
	         String newName = uuid.toString().replace("-", "") + ext;
	         String imgpath = path + "/" + newName;
	         
	         if(fileName != "") {
	            File uploadFile = new File(imgpath);      
	            try { 
	               mf.transferTo(uploadFile);   
	            }catch(Exception e) {  
	               e.printStackTrace();
	            }
	               dto.setNoticePhoto(newName);
	               AdminService.noticeModifyPhoto(dto);
	            }
	         }
	      }
	    
		return "redirect:/admin/adNoticeList.pet?pageNum="+pageNum;
	}
	
	//공지사항 삭제
	@RequestMapping("adNoticeDelete.pet")
	public String adNoticeDelete(int noticeNo,String pageNum)throws SQLException{
		
		AdminService.noticeDelete(noticeNo);
		
		return "redirect:/admin/adNoticeList.pet?pageNum="+pageNum;
	}
	//------------------------------------------------------------
	//유저 검색
	@RequestMapping("adUserSearch.pet")
	public String adUserSearch(String pageNum,Model model,String sel,String search)throws SQLException {
		
		Map<String, Object> result = null;
		if(sel == null || search == null) {//검색을 안했을때
			result = AdminService.adUserlist(pageNum);
		}else {//검색했을때
			result = AdminService.adUserSerach(pageNum,sel,search);
		}
		
		model.addAttribute("pageSize",result.get("pageSize"));
		model.addAttribute("pageNum",result.get("pageNum"));
		model.addAttribute("currentPage",result.get("currentPage"));
		model.addAttribute("startRow",result.get("startRow"));
		model.addAttribute("endRow",result.get("endRow"));
		model.addAttribute("articleList",result.get("articleList"));
		model.addAttribute("count",result.get("count"));
		model.addAttribute("number",result.get("number"));
		//검색했을때
		model.addAttribute("sel",result.get("sel"));
		model.addAttribute("search",result.get("search"));
		
		return "admin/adUserSearch";
	}
	
	//유저 content
	@RequestMapping("adUserContent.pet")
	public String adUserContent(String id, String pageNum, String sel, String search, Model model) throws SQLException{
		
		//DB카카오 유저 정보 가져오기
		UserDTO dto = UserService.getkakao(id);
		model.addAttribute("dto", dto);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("sel",sel);
		model.addAttribute("search",search);
		
		
		return "admin/adUserContent";
	}
	
	//유저 상태 변경
	@RequestMapping("useractivenum.pet")
	public String useractivenum(UserDTO dto,String pageNum) throws SQLException{
		System.out.println("pageNum : " + pageNum);
		
		AdminService.useractivenum(dto);
	
		return "redirect:/admin/adUserSearch.pet?pageNum="+pageNum;
	}
	
	
	
	//-------------------------1:1 문의------------------------------------
	
	//1:1 문의 리스트
	@RequestMapping("adQuestionList.pet")
	public String adQuestionList(String pageNum,Model model,String sel,String search)throws SQLException {
		
		Map<String, Object> result = null;
		if(sel == null || search == null) {//검색을 안했을때
			result = AdminService.QuestionList(pageNum);
		}else {//검색했을때
			result = AdminService.adQuestionSearch(pageNum,sel,search);
		}
		
		model.addAttribute("pageSize",result.get("pageSize"));
		model.addAttribute("pageNum",result.get("pageNum"));
		model.addAttribute("currentPage",result.get("currentPage"));
		model.addAttribute("startRow",result.get("startRow"));
		model.addAttribute("endRow",result.get("endRow"));
		model.addAttribute("articleList",result.get("articleList"));
		model.addAttribute("count",result.get("count"));
		model.addAttribute("number",result.get("number"));
		//검색했을때
		model.addAttribute("sel",result.get("sel"));
		model.addAttribute("search",result.get("search"));
		
		
		return "admin/adQuestionList";
	}
	
	//1:1 공지사항
	@RequestMapping("adQuestionContent.pet")
	public String adQuestionContent(int mtmno,String pageNum,Model model, String sel, String search) throws SQLException{
		
		//1:1문의글 가져오기
		MtmDTO mtmdto = UserService.getmtm(mtmno);
		
		model.addAttribute("mtmdto",mtmdto);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("sel",sel);
		model.addAttribute("search",search);
		return "admin/adQuestionContent";
	}
	
	//1:1 관리자 답변 등록/수정
	@RequestMapping("adQuestionContentPro.pet")
	public String adQuestionContentPro(MtmDTO dto,String pageNum) throws SQLException{
		
		System.out.println("pageNum :" + pageNum);
		
		//글저장
		AdminService.adQuestionContentPro(dto);
	
		return "redirect:/admin/adQuestionList.pet?pageNum="+ pageNum;
		
	}
	
	//1:1 답변 삭제
	@RequestMapping("adQuestiondelete.pet")
	public String adQuestiondelete(MtmDTO dto,String pageNum)throws SQLException{
		
		//답변 삭제
		AdminService.adQuestiondelete(dto);
		
		return "redirect:/admin/adQuestionList.pet?pageNum="+pageNum;//나중에 페이지 처리 할수있으면 하기
	}
	
	//-------------------------------병원 수정/등록/삭제 --------------------------
	//병원 수정/등록/삭제 페이지
	@RequestMapping("adHosModify.pet")
	public String adHosModify(String pageNum,String search, Model model)throws SQLException{
		
		Map<String , Object> result = new HashMap<String, Object>();
		if(search == null) {
			result = searchService.getHosList(pageNum);
		}else if(search != null){
			result = searchService.getSearchHosList(pageNum, search);
		}
		
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("hosList", result.get("hosList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("number", result.get("number"));
		model.addAttribute("search", result.get("search"));
		
		return "admin/adHosModify";
	}
	//병원 등록
	@RequestMapping("adHosSignup.pet")
	public String adHosSignup(HospitalDTO dto)throws SQLException{
		
		AdminService.adHosSignup(dto);
		
		return "redirect:/admin/adHosModify.pet";
	}
	//병원 수정
	@RequestMapping("adhosModifyForm.pet")
	public String adhosModifyForm(HospitalDTO dto)throws SQLException {
		
		AdminService.adHosModify(dto);
		
		return "redirect:/admin/adHosModify.pet";
	}
	//병원 삭제
	@RequestMapping("adhosDeleteForm.pet")
	public String adhosDeleteForm(HospitalDTO dto)throws SQLException{
		
		System.out.println("dto.hosno :" + dto.getHosNo());
		AdminService.adhosDeleteForm(dto);
		
		
		return "redirect:/admin/adHosModify.pet";
	}
	
	//--------------------------------- 진료비 수정/등록/삭제 : 혜란 09.17 -----------------------------------
	@RequestMapping("adPetModify.pet")
	public String adPetModify()throws SQLException{
		// 진료비 수정 메인페이지
		
		return "admin/adPetModify";
	}
	// 새창띄워서 병원검색 값 받기
	@RequestMapping("ajaxSearch.pet")
	public String ajaxSearch(
			HttpServletRequest request,
			String sidoSel, String siguSel, 
			String pageNum, String search, Model model)throws SQLException{
		
		// 해당 페이지에 맞는 화면에 뿌려줄 병원 list 가져와 view에 전달 
		Map<String, Object> result = null;
		System.out.println("sidoSel : " + sidoSel);
		System.out.println("siguSel :" + siguSel);
		System.out.println("search :" + search);
		
		// 뿌릴 값 가져오기
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
		// petType 추가 : 혜란
		String petType = (String)request.getParameter("petType");
		model.addAttribute("petType", petType);
		
		model.addAttribute("search", result.get("search"));
		model.addAttribute("sidoSel", result.get("sidoSel"));	// 시/도 (부모) 파라미터 값 
		model.addAttribute("siguSel", result.get("siguSel"));	// 시/구 (자식) 파라미터 값 

		
		return "admin/ajaxSearch";
	}
	@RequestMapping("diagnosisTable.pet")
	public String diagnosisTable(
			HttpServletRequest request, String hosNo, String hosName, 
			DogDTO dog, CatDTO cat, Model model
			)throws SQLException{
		
		// 병원고유번호 인트타입 형변환시켜줌
		int IntHosNo = Integer.parseInt(request.getParameter("hosNo"));
		
		// 병원이름 따로뽑아서 보내줌 
		hosName = (String)request.getParameter("hosName");
		dog = AdminService.getDog(IntHosNo);
		cat = AdminService.getCat(IntHosNo);
		model.addAttribute("hosNo", IntHosNo);
		model.addAttribute("hosName", hosName);
		model.addAttribute("dog", dog);
		model.addAttribute("cat", cat);
		
		return "admin/diagnosisTable";
	}
	
	//진료비 수정 dog
	@RequestMapping("adDogModify.pet")
	public String adDogModify(DogDTO dto) throws SQLException{
		
		AdminService.adDogModify(dto);
		
		return "redirect:/admin/adPetModify.pet";
	}
	//진료비 수정 cat
	@RequestMapping("adCatModify.pet")
	public String adCatModify(CatDTO dto) throws SQLException{
		
		AdminService.adCatModify(dto);
		
		return "redirect:/admin/adPetModify.pet";
	}
	//진료비 초기화
	@RequestMapping("adDogDelete.pet")
	public String adDogDelete(int hosNo)throws SQLException{
		
		AdminService.adDogDelete(hosNo);
		
		return "redirect:/admin/adPetModify.pet";
	}
	//진료비 초기화
	@RequestMapping("adCatDelete.pet")
	public String adCatDelete(int hosNo)throws SQLException{
		
		AdminService.adCatDelete(hosNo);
		
		return "redirect:/admin/adPetModify.pet";
	}
	
	
	//---------------------------전국 리뷰 -----------------------------------------
	
	@RequestMapping("adReviewStatus.pet")
	public String adReviewStatus(String pageNum,Model model,String sel,String search)throws SQLException {
		
		Map<String, Object> result = null;
		if(sel == null || search == null) {//검색을 안했을때
			result = AdminService.ReviewList(pageNum);
		}else {//검색했을때
			result = AdminService.adReviewStatus(pageNum,sel,search);
		}
		
		model.addAttribute("pageSize",result.get("pageSize"));
		model.addAttribute("pageNum",result.get("pageNum"));
		model.addAttribute("currentPage",result.get("currentPage"));
		model.addAttribute("startRow",result.get("startRow"));
		model.addAttribute("endRow",result.get("endRow"));
		model.addAttribute("articleList",result.get("articleList"));
		model.addAttribute("count",result.get("count"));
		model.addAttribute("number",result.get("number"));
		//검색했을때
		model.addAttribute("sel",result.get("sel"));
		model.addAttribute("search",result.get("search"));
		
		
		return "admin/adReviewStatus";
	}
	
	//--------------------------관리자 메인---------------------------------------
	@RequestMapping("adMain.pet")
	public String adMain(Model model) throws SQLException{
		
		//1:1문의 미답변 가져오기
		int mtmcount = AdminService.mtmcount();
		//최신 리뷰 가져오기
		int count = AdminService.NewReviewCount();
		List<UserReviewDTO> NewReviewList = AdminService.NewReviewList();
		//회원 가입 현황 리스트
		int usercount = AdminService.NewUserCount();
		List<UserDTO> NewUserList = AdminService.NewUserList();
		//------------------회원--------------------------
		//오늘날짜
		String today = AdminService.today();
		int todaydate = AdminService.todaydate(today);
		//어제 날짜 
		String yesterday = AdminService.yesterday();
		int yesterdaydate = AdminService.yesterdaydate(yesterday);
		//일주일 전
		String yesterday7 = AdminService.yesterday7();
		int yesterdaydate7 = AdminService.yesterdaydate7(yesterday7);
		//한달 전
		String yesterday30 = AdminService.yesterday30();
		int yesterdaydate30 = AdminService.yesterdaydate30(yesterday30);
		//--------------------리뷰----------------------
		//오늘날짜
		String Rtoday = AdminService.Rtoday();
		int Rtodaydate = AdminService.Rtodaydate(Rtoday);
		//어제 날짜 
		String Ryesterday = AdminService.Ryesterday();
		int Ryesterdaydate = AdminService.Ryesterdaydate(Ryesterday);
		//일주일 전
		String Ryesterday7 = AdminService.Ryesterday7();
		int Ryesterdaydate7 = AdminService.Ryesterdaydate7(Ryesterday7);
		//한달 전
		String Ryesterday30 = AdminService.Ryesterday30();
		int Ryesterdaydate30 = AdminService.Ryesterdaydate30(yesterday30);
		
		//view로 보내기
		model.addAttribute("mtmcount",mtmcount);
		model.addAttribute("count",count);
		model.addAttribute("usercount",usercount);
		model.addAttribute("NewReviewList",NewReviewList);
		model.addAttribute("NewUserList",NewUserList);
		//회원날짜
		model.addAttribute("todaydate",todaydate);
		model.addAttribute("yesterdaydate",yesterdaydate);
		model.addAttribute("yesterdaydate7",yesterdaydate7);
		model.addAttribute("yesterdaydate30",yesterdaydate30);
		//리뷰날짜
		model.addAttribute("Rtodaydate",Rtodaydate);
		model.addAttribute("Ryesterdaydate",Ryesterdaydate);
		model.addAttribute("Ryesterdaydate7",Ryesterdaydate7);
		model.addAttribute("Ryesterdaydate30",Ryesterdaydate30);
		
		
		return "admin/adMain";
	}

	// ----------------------- 유저 공지사항 ------------------------------------
		// 유저 공지사항 리스트 띄워주기
		@RequestMapping("noticeList.pet")
		public String NoticeList(String pageNum, Model model) throws SQLException{
			
			Map<String, Object> result = null;
			
			result = AdminService.getNoticeList(pageNum);
			
			// view에 전달할 데이터 보내주기
			model.addAttribute("pageSize", result.get("pageSize"));
			model.addAttribute("pageNum", result.get("pageNum"));
			model.addAttribute("currentPage", result.get("currentPage"));
			model.addAttribute("startRow", result.get("startRow"));
			model.addAttribute("endRow", result.get("endRow"));
			model.addAttribute("noticeList", result.get("noticeList"));
			model.addAttribute("count", result.get("count"));
			model.addAttribute("number", result.get("number"));

		
			return "admin/noticeList";
		}
		
		// 유저 공지사항 상세 페이지
		@RequestMapping("noticeContent.pet")
		public String NoticeContent(int noticeNo, String pageNum, Model model) throws SQLException{
			System.out.println("탐???");
			//공지사항 글 가져오기
			AdminDTO dto = AdminService.getNoticeContent(noticeNo);
			
			model.addAttribute("pageNum",pageNum);
			model.addAttribute("dto",dto);
			
			return "admin/noticeContent";
		}
	
	
	
}