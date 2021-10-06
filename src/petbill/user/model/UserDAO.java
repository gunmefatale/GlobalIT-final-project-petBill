package petbill.user.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;
import petbill.user.model.UserDTO;

public interface UserDAO {
	
	
	//회원가입 id중복체크
	public int idcheck(UserDTO dto)throws SQLException;
	
	//회원가입 id중복체크
	public int nicknamecheck(UserDTO dto)throws SQLException;
	
	//회원가입
	public int userSignup(UserDTO dto)throws SQLException;
	
	//로그인(id,pw 체크)
	public int IdPwcheck(UserDTO dto)throws SQLException;
	
	//카카오(id,pw 체크)
	public Map<String, Object> kakaologincheck(Map<String, Object> Map)throws SQLException;
	
	//카카오 커넥션
	public void KakaoupdateConnection(Map<String, Object> Map)throws SQLException;
	
	//카카오 로그인
	public Map<String, Object> KakaoLoginPro(Map<String, Object> Map)throws SQLException;
	
	//회원1명 정보 가져오기
	public UserDTO getUser(String id)throws SQLException;
	
	//회원정보수정
	public int updateUser(UserDTO dto,String nickname,String mobile)throws SQLException;
	
	//유저 닉네임 체크
	public int UserNickNameCheck(String nickname)throws SQLException;
	
	//리뷰id 수정
	public void reviewupdate(UserDTO dto, String nickname)throws SQLException;
	
	//회원탈퇴
	public int userDeletepw(UserDTO dto)throws SQLException;
	
	//1:1문의 삭제
	public void userQuestionDelete(UserDTO dto)throws SQLException;
	
	//유저리뷰삭제
	public void userReviewDelete(UserDTO dto)throws SQLException;
	
	//id찾기
	public String findid(UserDTO dto)throws SQLException;
	
	//pw찾기
	public String findpw(UserDTO dto)throws SQLException;
	
	//pw수정
	public void pwModify(String userId, String pwModify)throws SQLException;
	
	//1:1등록
	public void QuestionContent(MtmDTO dto)throws SQLException;
	
	//1:1문의 전체 게시글수 가져오기
	public int getArticleList(UserDTO dto)throws SQLException;
	
	//1:1문의 리스트
	public List<MtmDTO> getArticles(int start, int end, UserDTO dto)throws SQLException;
	
	//1:1문의 글 가져오기
	public MtmDTO getmtm(int mtmno)throws SQLException;
	
	//1:1문의 수정
	public void QuestionSignup(MtmDTO dto)throws SQLException;
	
	//1:1문의 삭제
	public void QuestionDelete(int mtmno)throws SQLException;
	
	//ajax 닉네임 중복
	public int ajaxnicknamecheck(UserDTO dto)throws SQLException;
	
	//카카오 아이디 있는지 확인
	public int kakaoid(String kakaoemail)throws SQLException;
	
	//리뷰 개수
	public int userReviewListcount(UserDTO dto)throws SQLException;
	
	//리뷰 리스트
	public List<UserReviewDTO> userReviewList(int start, int end, UserDTO dto)throws SQLException;
	
	//리뷰 목록 가져오기
	public List<ReviewDTO> userReview(UserDTO dto)throws SQLException;
	
	//병원 revcount
	public void userReviewUpdate(int reviewHosNo)throws SQLException;
	
	
	
	
	
	
	
	
}
