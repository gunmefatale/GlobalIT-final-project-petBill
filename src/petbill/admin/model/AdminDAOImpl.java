package petbill.admin.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import petbill.admin.model.AdminDTO;
import petbill.hospital.model.CatDTO;
import petbill.hospital.model.DogDTO;
import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;
import petbill.user.model.MtmDTO;
import petbill.user.model.UserDTO;
import petbill.user.model.UserReviewDTO;


@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	// 공지사항 저장
	@Override
	public void insertArticle(AdminDTO dto) throws SQLException {			 					
		
		sqlSession.insert("admin.insertArticle", dto);
		
	}

	// 공지사항 리스트 개수
	@Override
	public int getArticleCount() throws SQLException {
		
		int result = sqlSession.selectOne("admin.countAll");
		
		return result;
	}
	
	// 한 페이지 리스트
	@Override
	public List<AdminDTO> getArticles(int startRow, int endRow) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List<AdminDTO> adminList = sqlSession.selectList("admin.getArticles", map);
		
		return adminList;
	}
	
	// 공지사항 검색된 리스트 개수
	@Override
	public int NoticeSearchcount(String sel,String search) throws SQLException {
		
		HashMap<String , Object> map = new HashMap<String, Object>();
		map.put("sel",sel);
		map.put("search",search);
		
		int result = sqlSession.selectOne("admin.NoticeSearchcount",map);
		
		return result;
	}
	
	// 검색된 한 페이지 리스트
	@Override
	public List<AdminDTO> NoticeSearchlist(String sel, String search, int startRow, int endRow) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sel", sel);
		map.put("search", search);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List<AdminDTO> adminList = sqlSession.selectList("admin.NoticeSearchlist", map);
		
		return adminList;
	}
	
	//공지사항 글 가져오기
	@Override
	public AdminDTO getnotice(int noticeNo) throws SQLException {
		
		AdminDTO dto = sqlSession.selectOne("admin.getnotice",noticeNo);
		
		return dto;
	}
	//공지사항 수정
	@Override
	public void noticeModify(AdminDTO dto) throws SQLException {
		
		sqlSession.update("admin.noticeModify",dto);
		
	}
	
	// 공지사항 사진 수정
	public int noticeModifyPhoto(AdminDTO dto) {
		
		int update = sqlSession.update("admin.updateNoticePhoto", dto);
		
		return update;
	}
	
	
	//공지사항 삭제
	@Override
	public void noticeDelete(int noticeNo) throws SQLException {
		
		sqlSession.delete("admin.noticeDelete",noticeNo);
		
	}
	//--------------------------------------유저 검색---------------------------
	
	//유저 count
	@Override
	public int getadUserCount() throws SQLException {
		
		int result = sqlSession.selectOne("admin.getadUserCount");
		
		return result;
	}
	
	//유저 list 
	@Override
	public List<UserDTO> adUserlist(int startRow, int endRow) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List<UserDTO> articleList = sqlSession.selectList("admin.adUserlist", map);
		
		return articleList;
	}
	
	//검색된 유저 count
		@Override
		public int adUserSearchCount(String sel,String search) throws SQLException {
			
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("sel",sel);
			map.put("search",search);
			
			int result = sqlSession.selectOne("admin.adUserSearchCount",map);
			
			return result;
		}
		
		//검색된 유저 list
		@Override
		public List<UserDTO> adUserSearchlist(String sel, String search, int startRow, int endRow) throws SQLException {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("sel", sel);
			map.put("search", search);
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			
			List<UserDTO> articleList = sqlSession.selectList("admin.adUserSearchlist", map);
			
			return articleList;
		}
		
		//유저 상태변경
		@Override
		public void useractivenum(UserDTO dto) throws SQLException {
			
			sqlSession.update("admin.useractivenum",dto);
			
		}
	
	//--------------------------------------1:1 문의 ---------------------------
	
	
	
	//1:1문의 게시글개수
	@Override
	public int QuestionListcount() throws SQLException {
		
		int count = sqlSession.selectOne("admin.QuestionListcount");
		
		return count;
	}

	//1:1문의 리스트
	@Override
	public List<MtmDTO> QuestionList(int start, int end) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<MtmDTO> articleList = sqlSession.selectList("admin.QuestionList",map);
		
		return articleList;
	}
	
	//1:1 답변,수정
	@Override
	public void adQuestionContentPro(MtmDTO dto) throws SQLException {
		
		sqlSession.update("admin.adQuestionContentPro",dto);
	}
	
	//1:1 답변 삭제
	@Override
	public void adQuestiondelete(MtmDTO dto) throws SQLException {
		
		sqlSession.update("admin.adQuestiondelete",dto);
		
	}
	//1:1문의 검색된 글개수 가져오기
	@Override
	public int searchQuestioncount(String sel, String search) throws SQLException {
		
		HashMap map = new HashMap();
		map.put("sel", sel);
		map.put("search", search);
		
		int count = sqlSession.selectOne("admin.searchQuestioncount",map);
		
		return count;
	}
	//1:1문의 검색 리스트
	@Override
	public List searchQuestionList(int start, int end, String sel, String search) throws SQLException {
		
		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("sel", sel);
		map.put("search", search);
		
		List<MtmDTO> articleList =  sqlSession.selectList("admin.searchQuestionList",map);
		
		return articleList;
	}

	//--------------------------------------병원 등록/수정/삭제---------------------------------
	//병원 등록
	@Override
	public int adHosSignup(HospitalDTO dto) throws SQLException {
		
		int result = sqlSession.insert("admin.adHosSignup",dto);
		
		return result;
	}
	//hosNo 최대값 가져오기
	@Override
	public int maxhosNo() throws SQLException {
		
		int max = sqlSession.selectOne("admin.maxhosNo");
		System.out.println("max 123123 : " + max);
		
		return max;
	}

	
	//병원 수정
	@Override
	public void adHosModify(HospitalDTO dto) throws SQLException {
		
		sqlSession.update("admin.adHosModify",dto);
		
	}
	//병원 삭제
	@Override
	public int adhosDeleteForm(HospitalDTO dto) throws SQLException {
		
		int result = sqlSession.delete("admin.adhosDeleteForm",dto);
		
		return result;
	}
	
	
	//-----------------------------------진료비 등록/수정/삭제------------------------------------
	
	@Override
	public DogDTO getDog(int hosNo) throws SQLException {
		DogDTO getDog = sqlSession.selectOne("admin.getDog", hosNo);		
		return getDog;
	}
	@Override
	public CatDTO getCat(int hosNo) throws SQLException {	
		CatDTO getCat = sqlSession.selectOne("admin.getCat", hosNo);		
		return getCat;
	}
	
	//진료비 등록 dog
	@Override
	public void adDogSignup(int max) throws SQLException {
		
		sqlSession.insert("admin.adDogSignup",max);
		
	}
	
	//진료비 등록 cat
	@Override
	public void adCatSignup(int max) throws SQLException {
		
		sqlSession.insert("admin.adCatSignup",max);
		
	}
	//진료비 수정 dog
	@Override
	public void adDogModify(DogDTO dto) throws SQLException {
		
		sqlSession.update("admin.adDogModify",dto);
		
	}
	//진료비 수정 cat
	@Override
	public void adCatModify(CatDTO dto) throws SQLException {
		
		sqlSession.update("admin.adCatModify",dto);
		
	}
	//진료비 초기화 dog
	@Override
	public void adDogDelete(int hosNo) throws SQLException {
		
		sqlSession.update("admin.adDogDelete",hosNo);
	}

	//진료비 초기화 cat
	@Override
	public void adCatDelete(int hosNo) throws SQLException {
		
		sqlSession.update("admin.adCatDelete",hosNo);
	}
	
	//진료비 삭제 dog
	@Override
	public void DogDelete(HospitalDTO dto) throws SQLException {
		
		sqlSession.delete("admin.DogDelete",dto);
		
	}
	//진료비 삭제 cat
	@Override
	public void CatDelete(HospitalDTO dto) throws SQLException {
		
		sqlSession.delete("admin.CatDelete",dto);
		
	}


	//---------------------------------------전국 리뷰 --------------------------------------
	

	// 리뷰 개수
	public int ReviewListCount() {
		
		int count = sqlSession.selectOne("admin.ReviewListCount");
		
		return count;
	}

	// 리뷰 리스트
	@Override
	public List<UserReviewDTO> ReviewList(int start, int end) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<UserReviewDTO> articleList = sqlSession.selectList("admin.ReviewList",map);
		
		return articleList;
	}

	// 검색 글 개수
	public int searchReviewCount(String sel, String search) {
		
		HashMap map = new HashMap();
		map.put("sel", sel);
		map.put("search", search);
		
		int count = sqlSession.selectOne("admin.searchReviewCount",map);
		
		return count;
	}
	
	//검색 리스트
	public List<UserReviewDTO> searchReviewList(int start, int end, String sel, String search) {
		
		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("sel", sel);
		map.put("search", search);
		
		List<UserReviewDTO> articleList =  sqlSession.selectList("admin.searchReviewList",map);
		
		return articleList;
	}
	
	//리뷰 삭제
	@Override
	public void adReviewDelete(HospitalDTO dto) throws SQLException {
		
		sqlSession.delete("admin.adReviewDelete",dto);
		
	}
	


	//----------------------------------관리자 메인 --------------------------
	//1:1문의 미답변 가져오기
	@Override
	public int mtmcount() throws SQLException {
		
		int mtmcount = sqlSession.selectOne("admin.mtmcount");
		
		return mtmcount;
	}
	//최신 리뷰 리스트
	@Override
	public List<UserReviewDTO> NewReviewList() throws SQLException {
		
		List<UserReviewDTO> NewReviewList =  sqlSession.selectList("admin.NewReviewList");
		
		return NewReviewList;
	}
	
	//회원 가입 현황 리스트
	@Override
	public List<UserDTO> NewUserList() throws SQLException {
		
		List<UserDTO> NewUserList =  sqlSession.selectList("admin.NewUserList");
		
		return NewUserList;
	}

	//오늘 날짜
	@Override
	public String today() throws SQLException {
		
		String today = sqlSession.selectOne("admin.today");
		
		return today;
	}
	
	//오늘 날짜 count
	@Override
	public int todaydate(String today) throws SQLException {
		//메서드 돌려쓰기
		int todaydate =  sqlSession.selectOne("admin.yesterdaydate",today);
		
		return todaydate;
	}
	
	//하루 전 날짜
	@Override
	public String yesterday() throws SQLException {

		String yesterday = sqlSession.selectOne("admin.yesterday");
		
		return yesterday;
	}

	//하루 전 날짜 count
	@Override
	public int yesterdaydate(String yesterday) throws SQLException {
		
		int yesterdaydate =  sqlSession.selectOne("admin.yesterdaydate",yesterday);
		
		return yesterdaydate;
	}
	
	//일주일 전 날짜
	@Override
	public String yesterday7() throws SQLException {
		
		String yesterday7 = sqlSession.selectOne("admin.yesterday7");
		
		return yesterday7;
	}
	
	//일주일 전 날짜 count
	@Override
	public int yesterdaydate7(String yesterday7) throws SQLException {
		
		int yesterdaydate7 =  sqlSession.selectOne("admin.yesterdaydate",yesterday7);
		
		return yesterdaydate7;
	}
	
	//한달 전 날짜
	@Override
	public String yesterday30() throws SQLException {
		
		String yesterday30 = sqlSession.selectOne("admin.yesterday30");
		
		return yesterday30;
	}
	
	//한달 전 날짜 count
	@Override
	public int yesterdaydate30(String yesterday30) throws SQLException {
		
		int yesterdaydate30 =  sqlSession.selectOne("admin.yesterdaydate",yesterday30);
		
		return yesterdaydate30;
	}
	//---------------------------리뷰---------------------------------
	//오늘 날짜
	@Override
	public String Rtoday() throws SQLException {
		
		String Rtoday = sqlSession.selectOne("admin.today");
		
		return Rtoday;
	}
	
	//오늘 날짜 count
	@Override
	public int Rtodaydate(String Rtoday) throws SQLException {
		//메서드 돌려쓰기
		int Rtodaydate =  sqlSession.selectOne("admin.Ryesterdaydate",Rtoday);
		
		return Rtodaydate;
	}
	
	//하루 전 날짜
	@Override
	public String Ryesterday() throws SQLException {
		
		String Ryesterday = sqlSession.selectOne("admin.yesterday");
		
		return Ryesterday;
	}
	
	//하루 전 날짜 count
	@Override
	public int Ryesterdaydate(String Ryesterday) throws SQLException {
		
		int Ryesterdaydate =  sqlSession.selectOne("admin.Ryesterdaydate",Ryesterday);
		
		return Ryesterdaydate;
	}
	
	//일주일 전 날짜
	@Override
	public String Ryesterday7() throws SQLException {
		
		String Ryesterday7 = sqlSession.selectOne("admin.yesterday7");
		
		return Ryesterday7;
	}
	
	//일주일 전 날짜 count
	@Override
	public int Ryesterdaydate7(String Ryesterday7) throws SQLException {
		
		int Ryesterdaydate7 =  sqlSession.selectOne("admin.Ryesterdaydate",Ryesterday7);
		
		return Ryesterdaydate7;
	}
	
	//한달 전 날짜
	@Override
	public String Ryesterday30() throws SQLException {
		
		String Ryesterday30 = sqlSession.selectOne("admin.yesterday30");
		
		return Ryesterday30;
	}
	
	//한달 전 날짜 count
	@Override
	public int Ryesterdaydate30(String Ryesterday30) throws SQLException {
		
		int Ryesterdaydate30 =  sqlSession.selectOne("admin.Ryesterdaydate",Ryesterday30);
		
		return Ryesterdaydate30;
	}

	// ----------------------- 유저 공지사항 ------------------------------------
		// 유저 공지사항 개수
		@Override
		public int getNoticeCount() throws SQLException {
			
			int result = sqlSession.selectOne("admin.getNoticeCount");
			
			return result;
		}

		// 유저 공지사항 리스트 띄워주기
		@Override
		public List<AdminDTO> getNoticeList(int startRow, int endRow) throws SQLException {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			
			List<AdminDTO> NoticeList = sqlSession.selectList("admin.getNoticeList", map);
			
			
			return NoticeList;
		}

		// 유저 공지사항 상세 페이지
		@Override
		public AdminDTO getNoticeContent(int noticeNo) throws SQLException {

			AdminDTO dto = sqlSession.selectOne("admin.getNoticeContent", noticeNo);
			
			return dto;
		}	







	
	
	


}
