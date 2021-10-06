package petbill.admin.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import petbill.admin.model.AdminDTO;
import petbill.hospital.model.CatDTO;
import petbill.hospital.model.DogDTO;
import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;
import petbill.user.model.MtmDTO;
import petbill.user.model.UserDTO;
import petbill.user.model.UserReviewDTO;

public interface AdminService {
	
	// 공지사항 저장
	public void insertArticle(AdminDTO dto) throws SQLException;
	
	// 공지사항 리스트 띄우기
	public HashMap<String, Object> getArticleList(String pageNum) throws SQLException;
	
	//공자사항 검색
	public HashMap<String, Object> NoticeSearch(String pageNum,String sel, String search) throws SQLException;
	
	//공지사항 글 가져오기
	public AdminDTO getnotice(int noticeNo)throws SQLException;
	
	//공지사항 수정
	public void noticeModify(AdminDTO dto)throws SQLException;
	
	// 공지사항 사진 수정
	public int noticeModifyPhoto(AdminDTO dto)throws SQLException;
	
	//공지사항 삭제
	public void noticeDelete(int noticeNo)throws SQLException;
	
	//----------------------유저검색-------------------------
	//유저 list
	public Map<String, Object> adUserlist(String pageNum)throws SQLException;
	//검색된 유저 list
	public HashMap<String, Object> adUserSerach(String pageNum,String sel, String search) throws SQLException;
	//유저 상태변경
	public void useractivenum(UserDTO dto)throws SQLException;
	
	//----------------------1:1문의---------------------------
	//1:1문의 리스트
	public Map<String, Object> QuestionList(String pageNum)throws SQLException;
	//1:1 답변,수정
	public void adQuestionContentPro(MtmDTO dto)throws SQLException;
	//1:1 답변 삭제
	public void adQuestiondelete(MtmDTO dto)throws SQLException;
	//1:1문의 검색
	public Map<String, Object> adQuestionSearch(String pageNum, String sel, String search)throws SQLException;
	
	//---------------------병원 수정/등록/삭제-----------------------
	//병원 등록
	public void adHosSignup(HospitalDTO dto)throws SQLException;
	//병원 수정
	public void adHosModify(HospitalDTO dto)throws SQLException;
	//병원 삭제
	public void adhosDeleteForm(HospitalDTO dto)throws SQLException;
	
	
	//---------------------진료비 등록/수정/삭제---------------------
	//선택된 병원 고유번호로 진료비 가져오기
	public DogDTO getDog(int hosNo)throws SQLException;
	public CatDTO getCat(int hosNo)throws SQLException;
	//진료비 수정 dog
	public void adDogModify(DogDTO dto)throws SQLException;
	//진료비 수정 cat
	public void adCatModify(CatDTO dto)throws SQLException;
	//진료비 초기화 dog
	public void adDogDelete(int hosNo)throws SQLException;
	//진료비 초기화 cat
	public void adCatDelete(int hosNo)throws SQLException;
	
	
	
	//--------------------전국 리뷰 -------------------------------
	
	// 리뷰 리스트
	public Map<String, Object> ReviewList(String pageNum) throws SQLException;
	// 리뷰 검색
	public Map<String, Object> adReviewStatus(String pageNum, String sel, String search)throws SQLException;
	
	//------------------------관리자 메인----------------------------
	//1:1문의 미답변 가져오기
	public int mtmcount()throws SQLException;
	//최신 리뷰 count
	public int NewReviewCount()throws SQLException;
	//최신 리뷰 리스트
	public List<UserReviewDTO> NewReviewList()throws SQLException;
	//회원 가입 현황 count
	public int NewUserCount()throws SQLException;
	//회원 가입 현황 리스트
	public List<UserDTO> NewUserList()throws SQLException;
	
	//-----------------날짜-----------------------------
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
	//---------------------------리뷰 ------------------------------
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

	
	//----------------------- 유저 공지사항 ------------------------------------
	// 유저 공지사항 리스트 띄워주기
	public Map<String, Object> getNoticeList(String pageNum) throws SQLException;
	
	// 유저 공지사항 상세 페이지
	public AdminDTO getNoticeContent(int noticeNo) throws SQLException;
	
	
	
	
}


