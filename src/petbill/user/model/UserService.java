package petbill.user.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import petbill.hospital.model.HospitalDTO;
import petbill.user.model.UserDTO;

public interface UserService {

	//회원가입
	public int userSignup(UserDTO dto)throws SQLException;
	
	//로그인
	public int IdPwcheck(UserDTO dto)throws SQLException;
	
	//카카오 로그인  세션
	public Map<String, Object> kakaologincheck(Map<String, Object> Map)throws SQLException;
	
	//카카오 커넥션
	public void KakaoupdateConnection(Map<String, Object> Map)throws SQLException;
	
	//카카오 로그인 시키기
	public void KakaoLoginPro(Map<String, Object> Map)throws SQLException;
	
	//DB카카오 유저 정보 가져오기
	public UserDTO getkakao(String id)throws SQLException;
	
	//로그아웃
	public void logout(String userId);
	
	//회원 1명정보 가져오기
	public UserDTO getUser()throws SQLException;
	
	//유저 정보 수정
	public int updateUser(UserDTO dto,String nickname,String mobile)throws SQLException;
	
	//카카오 유저 정보 수정
	public int updatekakao(UserDTO dto,String nickname,String mobile)throws SQLException;
	
	//회원탈퇴(id,pw 체크)
	public int userDeletepw(UserDTO dto)throws SQLException;
	
	//id찾기
	public String findid(UserDTO dto)throws SQLException;
	
	//pw찾기
	public String findpw(UserDTO dto)throws SQLException;
	
	//pw 변경
	public int pwModify(String pw, String pwModify, String pwModifych)throws SQLException;
	
	//id 중복
	public int idCheck(UserDTO dto)throws SQLException;
	
	//-----------------------------1:1 문의 ------------------------------------
	
	//1:1등록
	public void QuestionContent(MtmDTO dto,int num)throws SQLException;
	
	//게시판 list 목록 가져오기(list)
	public Map<String, Object>getArticleList(String pageNum,int num)throws SQLException;
	
	//1:1문의글 가져오기
	public MtmDTO getmtm(int mtmno)throws SQLException;
	
	//1:1문의 수정
	public void QuestionSignup(MtmDTO dto)throws SQLException;
	
	//1:1문의 삭제
	public void QuestionDelete(int mtmno)throws SQLException;

	//ajax 닉네임
	public int ajaxnicknamecheck(UserDTO dto)throws SQLException;
	
	//카카오 아이디 있는지 확인
	public int kakaoid(String kakaoemail)throws SQLException;
	
	//리뷰 리스트
	public Map<String, Object>userReviewList(String pageNum,UserDTO dto)throws SQLException;
	
	//----------------------------------------------------

	
	
	
	
	
	
	
	
	
	
}
