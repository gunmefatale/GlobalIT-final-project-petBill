
package petbill.user.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDTO;
import petbill.user.model.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession = null;

	//회원가입 체크
	@Override
	public int idcheck(UserDTO dto) throws SQLException {
		
		int id = sqlSession.selectOne("user.idcheck",dto);
		
		return id;
	}
	//닉네임 체크 
	@Override
	public int nicknamecheck(UserDTO dto) throws SQLException {
		
		int nickname = sqlSession.selectOne("user.nicknamecheck",dto);
		
		return nickname;
	}
	
	//회원가입
	@Override
	public int userSignup(UserDTO dto) throws SQLException {
		
		int result = sqlSession.insert("user.userSignup",dto); 
		
		return result;
	}

	//로그인 id,pw 체크
	@Override
	public int IdPwcheck(UserDTO dto) throws SQLException {
		
		int result = sqlSession.selectOne("user.IdPwcheck",dto);
		
		return result;
	}
	//--------------------------카카오 로그인-----------------------------------------
	//카카오 id,pw 체크
	@Override
	public Map<String, Object> kakaologincheck(Map<String, Object> Map) throws SQLException {
		
		Map<String, Object> user = sqlSession.selectOne("user.kakaologincheck", Map);
		
		return user;
	}
	
	//카카오 커넥션
	@Override
	public void KakaoupdateConnection(Map<String, Object> Map) throws SQLException {
		
		sqlSession.update("user.KakaoupdateConnection", Map);
		
	}
	
	//카카오 로그인
	@Override
	public Map<String, Object> KakaoLoginPro(Map<String, Object> Map) throws SQLException {
		
		Map<String, Object> userlogin = sqlSession.selectOne("user.KakaoLoginPro", Map);
		
		return userlogin;
	}
	
	//회원 1명 정보 가져오기
	@Override
	public UserDTO getUser(String id) throws SQLException {
		
		UserDTO dto = sqlSession.selectOne("user.getUser", id);
		
		return dto;
	}
	
	//닉네임 체크
	@Override
	public int UserNickNameCheck(String nickname) throws SQLException {
		
		int nicknamecheck = sqlSession.selectOne("user.UserNickNameCheck",nickname);
		
		return nicknamecheck;
	}

	//회원 정보 수정
	@Override
	public int updateUser(UserDTO dto,String nickname,String mobile) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dto", dto.getId());
		map.put("nickname", nickname);
		map.put("mobile", mobile);
		
		int result = sqlSession.update("user.updateUser",map);
		
		return result;
	}
	
	//리뷰id수정
	@Override
	public void reviewupdate(UserDTO dto, String nickname) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dto", dto.getNickname());
		map.put("nickname", nickname);
		
		sqlSession.update("user.reviewupdate",map);
		
	}

	//회원탈퇴
	@Override
	public int userDeletepw(UserDTO dto) throws SQLException {
		
		int result = sqlSession.delete("user.userDeletepw",dto);
		
		return result;
	}
	
	//1:1 문의 삭제
	@Override
	public void userQuestionDelete(UserDTO dto) throws SQLException {
		
		sqlSession.delete("user.userQuestionDelete",dto);
		
	}
	
	//유저 리뷰 삭제
	@Override
	public void userReviewDelete(UserDTO dto) throws SQLException {
		
		sqlSession.delete("user.userReviewDelete",dto);
		
	}

	//id찾기
	@Override
	public String findid(UserDTO dto) throws SQLException {
		
		String id = sqlSession.selectOne("user.findid",dto);
		
		return id;
	}

	//pw찾기
	@Override
	public String findpw(UserDTO dto) throws SQLException {
		
		String pw = sqlSession.selectOne("user.findpw",dto);
		
		return pw;
	}
	//pw변경
	@Override
	public void pwModify(String userId, String pwModify) throws SQLException {
		System.out.println("userId123 : " + userId);
		
		
		HashMap map = new HashMap();
		
		map.put("userId",userId);
		map.put("pwModify",pwModify);
		
		sqlSession.update("user.pwModify",map);
		
	}

	//1:1등록
	@Override
	public void QuestionContent(MtmDTO dto) throws SQLException {
		
		sqlSession.insert("user.QuestionContent",dto);
		
	}

	//1:1문의 전체 게시글수 가져오기
	@Override
	public int getArticleList(UserDTO dto) throws SQLException {
		 
		int count = sqlSession.selectOne("user.getArticleList",dto);
		
		return count;
	}

	//1:1문의 한페이지 글 목록 가져오기
	@Override
	public List<MtmDTO> getArticles(int start, int end, UserDTO dto) throws SQLException {
		
		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("Id", dto.getId());
		
		List articleList = sqlSession.selectList("user.getArticles",map);
		
		return articleList;
	}

	//1:1문의 글 가져오기
	@Override
	public MtmDTO getmtm(int mtmno) throws SQLException {
		
		MtmDTO mtmdto = sqlSession.selectOne("user.getmtm",mtmno);
		
		return mtmdto;
	}

	//1:1문의 수정
	@Override
	public void QuestionSignup(MtmDTO dto) throws SQLException {
		
		sqlSession.update("user.QuestionSignup",dto);
		
	}

	//1:1문의 삭제
	@Override
	public void QuestionDelete(int mtmno) throws SQLException {
		
		sqlSession.delete("user.QuestionDelete",mtmno);
		
	}

	//ajax 닉네임 중복
	@Override
	public int ajaxnicknamecheck(UserDTO dto) throws SQLException {
		
		int result = sqlSession.selectOne("user.ajaxnicknamecheck", dto);
		System.out.println("result: " + result);
		
		return result;
	}
	
	//카카오 아이디 있는지 확인
	@Override
	public int kakaoid(String kakaoemail) throws SQLException {
		
		int kakao = sqlSession.selectOne("user.kakaoid",kakaoemail);
		
		return kakao;
	}
	
	//리뷰 글 개수 count
	@Override
	public int userReviewListcount(UserDTO dto) throws SQLException {
		
		int count = sqlSession.selectOne("user.userReviewListcount",dto);
		
		return count;
	}
	
	//리뷰 리스트
	@Override
	public List<UserReviewDTO> userReviewList(int start, int end, UserDTO dto) throws SQLException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("nickname", dto.getNickname());
		
		List<UserReviewDTO> articleList = sqlSession.selectList("user.userReviewList", map);
		
		return articleList;
	}
	
	//리뷰 목록 가져오기
	@Override
	public List<ReviewDTO> userReview(UserDTO dto) throws SQLException {
		
		List<ReviewDTO> list = sqlSession.selectList("user.userReview",dto);
		
		return list;
	}
	
	//병원 revcount
	@Override
	public void userReviewUpdate(int reviewHosNo) throws SQLException {
		
		sqlSession.update("user.userReviewUpdate",reviewHosNo);
		
		
	}
	




	




	
	



	
	



	

}
