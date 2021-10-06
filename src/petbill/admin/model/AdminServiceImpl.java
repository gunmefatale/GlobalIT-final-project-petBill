package petbill.admin.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import petbill.admin.model.AdminDAOImpl;
import petbill.admin.model.AdminDTO;
import petbill.hospital.model.CatDTO;
import petbill.hospital.model.DogDTO;
import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDAOImpl;
import petbill.review.model.ReviewDTO;
import petbill.user.model.MtmDTO;
import petbill.user.model.UserDAOImpl;
import petbill.user.model.UserDTO;
import petbill.user.model.UserReviewDTO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAOImpl AdminDAO = null;

	
	// 글 저장
	public void insertArticle(AdminDTO dto) throws SQLException {
		
		AdminDAO.insertArticle(dto); 
		
	}

	// 공지사항 리스트 띄우기
	@Override
	public HashMap<String, Object> getArticleList(String pageNum) throws SQLException {
		
		// 한 페이지에 보여줄 리스트 수
		int pageSize = 5;
		// 현재 페이지 번호
		if(pageNum == null) {
			pageNum = "1";
		}
		// 현재 페이지에 보여줄 리스트 시작과 끝
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		// 리스트 글 가져오기
		List<AdminDTO> articleList = null;
		int count = 0;
		int number = 0;
		
		// 전체 글의 개수 가져오기
		count = AdminDAO.getArticleCount();
		System.out.println("count : " + count);
		// 글이 하나라도 있으면 글들 다시 가져오기
		if(count > 0) {
			articleList = AdminDAO.getArticles(startRow, endRow);
		}
		number = count - (currentPage - 1) * pageSize;
		
		// 컨트롤러에게 haspmap에 넣어 전달
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("articleList", articleList);
		result.put("count", count);
		result.put("number", number);
		
		return result;
	}
	
	
	
	
	//공지사항 글 가져오기	
	@Override
	public AdminDTO getnotice(int noticeNo) throws SQLException {
		
		AdminDTO dto = AdminDAO.getnotice(noticeNo);
		
		return dto;
	}
	
	//공지사항 검색
	@Override
	public HashMap<String, Object> NoticeSearch(String pageNum, String sel, String search) throws SQLException {
		// 한 페이지에 보여줄 리스트 수
		int pageSize = 5;
		// 현재 페이지 번호
		if(pageNum == null) {
			pageNum = "1";
		}
		// 현재 페이지에 보여줄 리스트 시작과 끝
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		// 리스트 글 가져오기
		List<AdminDTO> articleList = null;
		int count = 0;
		int number = 0;
		
		// 전체 글의 개수 가져오기
		count = AdminDAO.NoticeSearchcount(sel,search);
		System.out.println("count : " + count);
		// 글이 하나라도 있으면 글들 다시 가져오기
		if(count > 0) {
			articleList = AdminDAO.NoticeSearchlist(sel,search,startRow, endRow);
		}
		number = count - (currentPage - 1) * pageSize;
		
		// 컨트롤러에게 haspmap에 넣어 전달
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("articleList", articleList);
		result.put("count", count);
		result.put("number", number);
		result.put("sel", sel);
		result.put("search", search);
		
		return result;
	}
	
	
	//공지사항 수정
	@Override
	public void noticeModify(AdminDTO dto) throws SQLException {
		
		AdminDAO.noticeModify(dto);
		
	}
	
	// 공지사항 사진 수정
	public int noticeModifyPhoto(AdminDTO dto) {
		int update = AdminDAO.noticeModifyPhoto(dto);
		
		return update;
	}
	
	//공지사항 삭제
	@Override
	public void noticeDelete(int noticeNo) throws SQLException {
		
		AdminDAO.noticeDelete(noticeNo);
		
	}
	//-----------------------------------------유저 검색-----------------------------------------
	
	//유저 리스트
	@Override
	public Map<String, Object> adUserlist(String pageNum) throws SQLException {
		
		// 한 페이지에 보여줄 리스트 수
		int pageSize = 5;
		// 현재 페이지 번호
		if(pageNum == null) {
			pageNum = "1";
		}
		// 현재 페이지에 보여줄 리스트 시작과 끝
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		List<UserDTO> articleList = null;
		int count = 0;
		int number = 0;
		
		// 가입한 유저 수 가져오기
		count = AdminDAO.getadUserCount();
		System.out.println("count : " + count);
		// 가입한 유저가 있으면
		if(count > 0) { 
			articleList = AdminDAO.adUserlist(startRow, endRow);
		}
		number = count - (currentPage - 1) * pageSize;
		
		// 컨트롤러에게 haspmap에 넣어 전달
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("articleList", articleList);
		result.put("count", count);
		result.put("number", number);
		
		return result;
	}
	
	//검색된 유저 list
		@Override
		public HashMap<String, Object> adUserSerach(String pageNum, String sel, String search) throws SQLException {
			// 한 페이지에 보여줄 리스트 수
			int pageSize = 5;
			// 현재 페이지 번호
			if(pageNum == null) {
				pageNum = "1";
			}
			// 현재 페이지에 보여줄 리스트 시작과 끝
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;
			
			List<UserDTO> articleList = null;
			int count = 0;
			int number = 0;
			
			// 가입한 유저 수 가져오기
			count = AdminDAO.adUserSearchCount(sel,search);
			System.out.println("count : " + count);
			
			// 가입한 유저가 있으면
			if(count > 0) {
				articleList = AdminDAO.adUserSearchlist(sel,search,startRow, endRow);
			}
			number = count - (currentPage - 1) * pageSize;
			
			// 컨트롤러에게 haspmap에 넣어 전달
			HashMap<String, Object> result = new HashMap<String, Object>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("articleList", articleList);
			result.put("count", count);
			result.put("number", number);
			result.put("sel", sel);
			result.put("search", search);
			
			return result;
		}
		
		//유저 상태변경
		@Override
		public void useractivenum(UserDTO dto) throws SQLException {
			
			AdminDAO.useractivenum(dto);
			
		}
	
	
	//------------------------------------------1:1 문의 ------------------------------------------
	
	//1:1 문의 리스트
	@Override
	public Map<String, Object> QuestionList(String pageNum) throws SQLException {
		
		// 한 페이지에 보여줄 리스트 수
		int pageSize = 5;
		// 현재 페이지 번호
		if(pageNum == null) {
			pageNum = "1";
		}
		// 현재 페이지에 보여줄 리스트 시작과 끝
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		// 리스트 글 가져오기
		List<MtmDTO> articleList = null;
		int count = 0;
		int number = 0;
		
		// 전체 글의 개수 가져오기
		count = AdminDAO.QuestionListcount();
		System.out.println("전체글count : " + count);
		// 글이 하나라도 있으면 글들 다시 가져오기
		if(count > 0) {
			articleList = AdminDAO.QuestionList(startRow, endRow);
		}
		number = count - (currentPage - 1) * pageSize;
		
		// 컨트롤러에게 haspmap에 넣어 전달
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("articleList", articleList);
		result.put("count", count);
		result.put("number", number);
		
		return result;
	}

	//1:1 답변,수정
	@Override
	public void adQuestionContentPro(MtmDTO dto) throws SQLException {
			
			AdminDAO.adQuestionContentPro(dto);
		
	}

	//1:1 답변 삭제
	@Override
	public void adQuestiondelete(MtmDTO dto) throws SQLException {

		AdminDAO.adQuestiondelete(dto);
		
	}
	
	//1:1문의 검색
	@Override
	public Map<String, Object> adQuestionSearch(String pageNum, String sel, String search) throws SQLException {
		
		// 한 페이지에 보여줄 리스트 수
				int pageSize = 5;
				// 현재 페이지 번호
				if(pageNum == null) {
					pageNum = "1";
				}
				// 현재 페이지에 보여줄 리스트 시작과 끝
				int currentPage = Integer.parseInt(pageNum);
				int startRow = (currentPage - 1) * pageSize + 1;
				int endRow = currentPage * pageSize;
				
				// 리스트 글 가져오기
				List<MtmDTO> articleList = null;
				int count = 0;
				int number = 0;
				
				// 전체 글의 개수 가져오기
				count = AdminDAO.searchQuestioncount(sel,search);//검색된 총 글개수
				System.out.println("검색된count : " + count);
				// 글이 하나라도 있으면 글들 다시 가져오기
				if(count > 0) {
					articleList = AdminDAO.searchQuestionList(startRow, endRow, sel, search);
				}
				number = count - (currentPage - 1) * pageSize;
				
				// 컨트롤러에게 haspmap에 넣어 전달
				HashMap<String, Object> result = new HashMap<String, Object>();
				result.put("pageSize", pageSize);
				result.put("pageNum", pageNum);
				result.put("currentPage", currentPage);
				result.put("startRow", startRow);
				result.put("endRow", endRow);
				result.put("articleList", articleList);
				result.put("count", count);
				result.put("number", number);
				result.put("sel", sel);
				result.put("search", search);
				
				return result;
	}

	//-------------------------------병원 등록/수정/삭제 ---------------------------------
	
	//병원등록
	@Override
	public void adHosSignup(HospitalDTO dto) throws SQLException {
		
		int result = AdminDAO.adHosSignup(dto);
		if(result == 1) {//병원 등록이 됐으면
			//hosNo 최대값 가져오기
			int max = AdminDAO.maxhosNo();
			
			//강아지, 고양이 생성
			AdminDAO.adDogSignup(max);
			AdminDAO.adCatSignup(max);
		}
		
	}
	//병원수정
	@Override
	public void adHosModify(HospitalDTO dto) throws SQLException {
		
		AdminDAO.adHosModify(dto);
		
	}
	//병원삭제
	@Override
	public void adhosDeleteForm(HospitalDTO dto) throws SQLException {
		
		int result = AdminDAO.adhosDeleteForm(dto);
	
		if(result == 1) {//삭제가 잘 됐다면
			//리뷰삭제
			AdminDAO.adReviewDelete(dto);
			//dog삭제
			AdminDAO.DogDelete(dto);
			//cat삭제
			AdminDAO.CatDelete(dto);
		}
		
	}
	
	//-----------------------------진료비 등록/수정/삭제--------------------------------
	// 강아지, 고양이 해당병원 진료비 테이블 가져오기 
	@Override
	public DogDTO getDog(int hosNo) throws SQLException {
		DogDTO getDog = AdminDAO.getDog(hosNo);
		return getDog;
	}
	@Override
	public CatDTO getCat(int hosNo) throws SQLException {	
		CatDTO getCat = AdminDAO.getCat(hosNo);	
		return getCat;
	}
	//진료비 수정 dog
	@Override
	public void adDogModify(DogDTO dto) throws SQLException {
		
		AdminDAO.adDogModify(dto);
		
	}
	//진료비 수정 cat
	@Override
	public void adCatModify(CatDTO dto) throws SQLException {
		
		AdminDAO.adCatModify(dto);
		
	}
	//진료비 초기화 dog
	@Override
	public void adDogDelete(int hosNo) throws SQLException {
		
		AdminDAO.adDogDelete(hosNo);
		
	}
	//진료비 초기화 cat
	@Override
	public void adCatDelete(int hosNo) throws SQLException {
		
		AdminDAO.adCatDelete(hosNo);
		
	}


	//---------------------------------전국 리뷰 ------------------------------------
		// 리뷰 리스트
		public Map<String, Object> ReviewList(String pageNum) throws SQLException {
				
		// 한 페이지에 보여줄 리스트 수
		int pageSize = 5;
		// 현재 페이지 번호
		if(pageNum == null) {
			pageNum = "1";
		}
		// 현재 페이지에 보여줄 리스트 시작과 끝
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		// 리스트 글 가져오기
		List<UserReviewDTO> articleList = null;
		int count = 0;
		int number = 0;
		
		// 전체 글의 개수 가져오기
		count = AdminDAO.ReviewListCount();
		System.out.println("전체글count : " + count);
		// 글이 하나라도 있으면 글들 다시 가져오기
		if(count > 0) {
			articleList = AdminDAO.ReviewList(startRow, endRow);
		}
		number = count - (currentPage - 1) * pageSize;
		
		// 컨트롤러에게 haspmap에 넣어 전달
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("articleList", articleList);
		result.put("count", count);
		result.put("number", number);
			
			return result;
		}

		// 리뷰 검색
		public Map<String, Object> adReviewStatus(String pageNum, String sel, String search) {
			
			// 한 페이지에 보여줄 리스트 수
			int pageSize = 5;
			// 현재 페이지 번호
			if(pageNum == null) {
				pageNum = "1";
			}
			// 현재 페이지에 보여줄 리스트 시작과 끝
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;
			
			// 리스트 글 가져오기
			List<UserReviewDTO> articleList = null;
			int count = 0;
			int number = 0;
			
			// 전체 글의 개수 가져오기
			count = AdminDAO.searchReviewCount(sel,search);//검색된 총 글개수
			System.out.println("검색된count : " + count);
			// 글이 하나라도 있으면 글들 다시 가져오기
			if(count > 0) {
				articleList = AdminDAO.searchReviewList(startRow, endRow, sel, search);
			}
			number = count - (currentPage - 1) * pageSize;
			
			// 컨트롤러에게 haspmap에 넣어 전달
			HashMap<String, Object> result = new HashMap<String, Object>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("articleList", articleList);
			result.put("count", count);
			result.put("number", number);
			result.put("sel", sel);
			result.put("search", search);
			
			return result;
	}
		
		
	//----------------------------------관리자 메인 --------------------------
	
		//1:1문의 미답변 가져오기
		@Override
		public int mtmcount() throws SQLException {
			
			int mtmcount = AdminDAO.mtmcount();
			
			return mtmcount;
		}
		
		//최신 리뷰 count
		@Override
		public int NewReviewCount() throws SQLException {
			
			int count = AdminDAO.ReviewListCount();
			
			return count;
		}
		
		//최신 리뷰 리스트
		@Override
		public List<UserReviewDTO> NewReviewList() throws SQLException {
			
			List<UserReviewDTO> NewReviewList = AdminDAO.NewReviewList();
			
			return NewReviewList;
		}
		//회원 가입 현황 count
		@Override
		public int NewUserCount() throws SQLException {
			
			int count = AdminDAO.getadUserCount();
			
			return count;
		}
		
		//회원 가입 현황 리스트
		@Override
		public List<UserDTO> NewUserList() throws SQLException {
			
			List<UserDTO> NewUserList = AdminDAO.NewUserList();
			
			return NewUserList;
		}

		//오늘 날짜
		@Override
		public String today() throws SQLException {
			
			String today = AdminDAO.today();
			
			return today;
		}
		
		//오늘 날짜 count
		@Override
		public int todaydate(String today) throws SQLException {
			
			int todaydate = AdminDAO.todaydate(today);
			
			return todaydate;
		}
		
		//하루 전 날짜
		@Override
		public String yesterday() throws SQLException {
			
			String yesterday = AdminDAO.yesterday();
			
			return yesterday;
		}
		//하루전 날짜 count
		@Override
		public int yesterdaydate(String yesterday) throws SQLException {
			
			int yesterdaydate = AdminDAO.yesterdaydate(yesterday);
			
			return yesterdaydate;
		}
		
		//일주일 전 날짜
		@Override
		public String yesterday7() throws SQLException {
			
			String yesterday7 = AdminDAO.yesterday7();
			
			return yesterday7;
		}
		//일주일 전 날짜 count
		@Override
		public int yesterdaydate7(String yesterday7) throws SQLException {
			
			int yesterdaydate7 = AdminDAO.yesterdaydate7(yesterday7);
			
			return yesterdaydate7;
		}
		
		//일주일 전 날짜
		@Override
		public String yesterday30() throws SQLException {
			
			String yesterday30 = AdminDAO.yesterday30();
			
			return yesterday30;
		}
		//일주일 전 날짜 count
		@Override
		public int yesterdaydate30(String yesterday30) throws SQLException {
			
			int yesterdaydate30 = AdminDAO.yesterdaydate30(yesterday30);
			
			return yesterdaydate30;
		}
		//-----------------------리뷰 ----------------------------
		//오늘 날짜
		@Override
		public String Rtoday() throws SQLException {
			
			String Rtoday = AdminDAO.Rtoday();
			
			return Rtoday;
		}
		
		//오늘 날짜 count
		@Override
		public int Rtodaydate(String Rtoday) throws SQLException {
			
			int Rtodaydate = AdminDAO.Rtodaydate(Rtoday);
			
			return Rtodaydate;
		}
		
		//하루 전 날짜
		@Override
		public String Ryesterday() throws SQLException {
			
			String Ryesterday = AdminDAO.Ryesterday();
			
			return Ryesterday;
		}
		//하루전 날짜 count
		@Override
		public int Ryesterdaydate(String Ryesterday) throws SQLException {
			
			int Ryesterdaydate = AdminDAO.Ryesterdaydate(Ryesterday);
			
			return Ryesterdaydate;
		}
		
		//일주일 전 날짜
		@Override
		public String Ryesterday7() throws SQLException {
			
			String Ryesterday7 = AdminDAO.Ryesterday7();
			
			return Ryesterday7;
		}
		//일주일 전 날짜 count
		@Override
		public int Ryesterdaydate7(String Ryesterday7) throws SQLException {
			
			int Ryesterdaydate7 = AdminDAO.Ryesterdaydate7(Ryesterday7);
			
			return Ryesterdaydate7;
		}
		
		//일주일 전 날짜
		@Override
		public String Ryesterday30() throws SQLException {
			
			String Ryesterday30 = AdminDAO.Ryesterday30();
			
			return Ryesterday30;
		}
		//일주일 전 날짜 count
		@Override
		public int Ryesterdaydate30(String Ryesterday30) throws SQLException {
			
			int Ryesterdaydate30 = AdminDAO.Ryesterdaydate30(Ryesterday30);
			
			return Ryesterdaydate30;
		}

		// ----------------------- 유저 공지사항 ------------------------------------
		// 유저 공지사항 리스트 띄워주기
		@Override
		public Map<String, Object> getNoticeList(String pageNum) throws SQLException {
			
			// 한 페이지에 보여줄 리스트 수
			int pageSize = 5;
			// 현재 페이지 번호
			if(pageNum == null) {
				pageNum = "1";
			}
			// 현재 페이지에 보여줄 리스트 시작과 끝
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;
			
			// 리스트 글 가져오기
			List<AdminDTO> noticeList = null;
			int count = 0;
			int number = 0;
			
			// 전체 글의 개수 가져오기
			count = AdminDAO.getNoticeCount();
			System.out.println("count : " + count);
			// 글이 하나라도 있으면 글들 다시 가져오기
			if(count > 0) {
				noticeList = AdminDAO.getNoticeList(startRow, endRow);
			}
			System.out.println("count?" + count);
			number = count - (currentPage - 1) * pageSize;
			
			// 컨트롤러에게 haspmap에 넣어 전달
			HashMap<String, Object> result = new HashMap<String, Object>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("noticeList", noticeList);
			result.put("count", count);
			result.put("number", number);
			
			return result;
		}

		// 유저 공지사항 상세 페이지
		@Override
		public AdminDTO getNoticeContent(int noticeNo) throws SQLException {
			
			AdminDTO dto = AdminDAO.getNoticeContent(noticeNo);
			
			return dto;
		}






	
	
}


