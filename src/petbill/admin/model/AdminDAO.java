package petbill.admin.model;

import java.sql.SQLException;
import java.util.List;

import petbill.admin.model.AdminDTO;
import petbill.hospital.model.CatDTO;
import petbill.hospital.model.DogDTO;
import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;
import petbill.user.model.MtmDTO;
import petbill.user.model.UserDTO;
import petbill.user.model.UserReviewDTO;


public interface AdminDAO {

	// 공지사항 저장
	public void insertArticle(AdminDTO dto) throws SQLException; 
	// 공지사항 리스트 개수
	public int getArticleCount() throws SQLException;
	// 한 페이지 리스트
	public List<AdminDTO> getArticles(int startRow, int endRow) throws SQLException;
	// 공지사항 검색된 리스트 개수
	public int NoticeSearchcount(String sel,String search) throws SQLException;
	// 검색된 한 페이지 리스트
	public List<AdminDTO> NoticeSearchlist(String sel,String search,int startRow, int endRow) throws SQLException;
	//공지사항 글 가져오기
	public AdminDTO getnotice(int noticeNo)throws SQLException;
	//공지사항 수정
	public void noticeModify(AdminDTO dto)throws SQLException;
	// 공지사항 사진 수정
	public int noticeModifyPhoto(AdminDTO dto)throws SQLException;
	//공지사항 삭제
	public void noticeDelete(int noticeNo)throws SQLException;
	//---------------------------유저 검색 ----------------------
	//유저 count
	public int getadUserCount()throws SQLException;
	//유저 list
	public List<UserDTO> adUserlist(int startRow, int endRow) throws SQLException;
	//검색된 유저 count
	public int adUserSearchCount(String sel,String search) throws SQLException;
	//검색된 유저 list
	public List<UserDTO> adUserSearchlist(String sel,String search,int startRow, int endRow) throws SQLException;
	//유저 상태변경
	public void useractivenum(UserDTO dto)throws SQLException;
	
	// ---------------------------1:1 문의 ----------------------
	//1:1문의 게시글 개수
	public int QuestionListcount()throws SQLException;
	//1:1문의 리스트
	public List<MtmDTO> QuestionList(int start, int end)throws SQLException;
	//1:1답변,수정
	public void adQuestionContentPro(MtmDTO dto)throws SQLException;
	//1:1답변 삭제
	public void adQuestiondelete(MtmDTO dto)throws SQLException;
	//1:1문의 검색된 글 개수
	public int searchQuestioncount(String sel, String search)throws SQLException;
	//1:1문의 검색 리스트
	public List searchQuestionList(int start, int end, String sel, String search)throws SQLException;
	
	//----------------------------병원 등록/수정/삭제 -----------------------
	//병원 등록
	public int adHosSignup(HospitalDTO dto)throws SQLException;
	//hosNo 최대값 가져오기
	public int maxhosNo()throws SQLException;
	//병원 수정
	public void adHosModify(HospitalDTO dto)throws SQLException;
	//병원 삭제
	public int adhosDeleteForm(HospitalDTO dto)throws SQLException;
	
	//----------------------------진료비 등록/수정/삭제 -----------------------
	// 강아지, 고양이 해당병원 진료비 테이블 가져오기
	public DogDTO getDog(int hosNo)throws SQLException;
	public CatDTO getCat(int hosNo)throws SQLException;
	//진료비 등록 dog
	public void adDogSignup(int max)throws SQLException;
	//진료비 등록 cat
	public void adCatSignup(int max)throws SQLException;
	//진료비 수정 dog
	public void adDogModify(DogDTO dto)throws SQLException;
	//진료비 수정 cat
	public void adCatModify(CatDTO dto)throws SQLException;
	//진료비 초기화 dog
	public void adDogDelete(int hosNo)throws SQLException;
	//진료비 초기화 cat
	public void adCatDelete(int hosNo)throws SQLException;
	//진료비 삭제 dog
	public void DogDelete(HospitalDTO dto)throws SQLException;
	//진료비 삭제 cat
	public void CatDelete(HospitalDTO dto)throws SQLException;
	
	//-----------------------------전국 리뷰 -------------------------------
	// 리뷰 글 수
	public int ReviewListCount() throws SQLException;
	// 리뷰 리스트
	public List<UserReviewDTO> ReviewList(int start, int end)throws SQLException;
	// 검색 리뷰 개수
	public int searchReviewCount(String sel, String search)throws SQLException;
	// 검색 리뷰 리스트
	public List<UserReviewDTO> searchReviewList(int start, int end, String sel, String search)throws SQLException;
	// 리뷰 삭제
	public void adReviewDelete(HospitalDTO dto)throws SQLException;
	//----------------------------------관리자 메인 --------------------------
	//1:1문의 미답변 가져오기
	public int mtmcount()throws SQLException;
	//최신 리뷰 리스트
	public List<UserReviewDTO> NewReviewList() throws SQLException;
	//회원 가입 현황 리스트
	public List<UserDTO> NewUserList() throws SQLException;
	//오늘 날짜
	public String today()throws SQLException;
	//오늘 날짜 count
	public int todaydate(String today)throws SQLException;
	//하루 전 날짜
	public String yesterday()throws SQLException;
	//하루 전 날짜 count
	public int yesterdaydate(String yesterday)throws SQLException;
	//일주일 전 날짜
	public String yesterday7()throws SQLException;
	//일주일 전 날짜 count
	public int yesterdaydate7(String yesterday7)throws SQLException;
	//한달 전 날짜
	public String yesterday30()throws SQLException;
	//한달 전 날짜 count
	public int yesterdaydate30(String yesterday30)throws SQLException;
	//------------------------리뷰-------------------------------
	//오늘 날짜
	public String Rtoday()throws SQLException;
	//오늘 날짜 count
	public int Rtodaydate(String Rtoday)throws SQLException;
	//하루 전 날짜
	public String Ryesterday()throws SQLException;
	//하루 전 날짜 count
	public int Ryesterdaydate(String Ryesterday)throws SQLException;
	//일주일 전 날짜
	public String Ryesterday7()throws SQLException;
	//일주일 전 날짜 count
	public int Ryesterdaydate7(String Ryesterday7)throws SQLException;
	//한달 전 날짜
	public String Ryesterday30()throws SQLException;
	//한달 전 날짜 count
	public int Ryesterdaydate30(String Ryesterday30)throws SQLException;
	
	// ----------------------- 유저 공지사항 ------------------------------------
	// 유저 공지사항 글 개수
	public int getNoticeCount() throws SQLException;
	// 유저 공지사항 띄워주기
	public List<AdminDTO> getNoticeList(int startRow, int endRow) throws SQLException;
	// 유저 공지사항 상세 페이지
	public AdminDTO getNoticeContent(int noticeNo) throws SQLException;
	
		
}

