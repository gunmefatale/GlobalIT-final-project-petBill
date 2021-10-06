package petbill.user.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import petbill.hospital.model.HospitalDTO;
import petbill.review.model.ReviewDAOImpl;
import petbill.review.model.ReviewDTO;
import petbill.user.model.UserDAOImpl;
import petbill.user.model.UserDTO;

@Service
public class UserServiceImpl implements UserService{

	
	@Autowired
	private UserDAOImpl UserDAO = null;
	@Autowired
	private ReviewDAOImpl reviewDAO = null;

	//회원가입
	@Override
	public int userSignup(UserDTO dto) throws SQLException {
		
		//아이디 중복체크
		int id = UserDAO.idcheck(dto);
		int nickname = UserDAO.nicknamecheck(dto);

		int result = 0;
		if(id == 0 && nickname == 0) {
			result = UserDAO.userSignup(dto);
		}
		return result;
	}
	//로그인 id,pw 체크
	@Override
	public int IdPwcheck(UserDTO dto) throws SQLException {
		
		int result = UserDAO.IdPwcheck(dto);
		if(result == 1) {//아이디 비번이 맞다면
			//세션만들기
			RequestContextHolder.getRequestAttributes().setAttribute("userId", dto.getId(), RequestAttributes.SCOPE_SESSION);
		}
		return result;
	}
	// ------------------------------------------카카오 로그인 --------------------------------------
	//카카오 체크
	@Override
	public Map<String, Object> kakaologincheck(Map<String, Object> Map) throws SQLException {
		
		Map<String, Object> user = UserDAO.kakaologincheck(Map);
		return user;
	}
	//카카오 커넥션
	@Override
	public void KakaoupdateConnection(Map<String, Object> Map) throws SQLException {

		UserDAO.KakaoupdateConnection(Map);
		
	}
	//카카오 로그인
	@Override
	public void KakaoLoginPro(Map<String, Object> Map) throws SQLException {
		
		Map<String, Object> userlogin = UserDAO.KakaoLoginPro(Map);
		if(userlogin != null) {
			//세션만들기
			RequestContextHolder.getRequestAttributes().setAttribute("kakaoId", userlogin.get("ID"), RequestAttributes.SCOPE_SESSION);
		}
	}
	
	//DB카카오 유저 정보 가져오기
	@Override
	public UserDTO getkakao(String id) throws SQLException {
		
		//세션꺼내서 담기
		UserDTO dto = UserDAO.getUser(id);
		
		return dto;
	}
	
	//로그아웃
	@Override
	public void logout(String userId) {
		//세션삭제
		RequestContextHolder.getRequestAttributes().removeAttribute("userId", RequestAttributes.SCOPE_SESSION);
	}
	
	//마이페이지 회원 1명 정보 가져오기
	@Override
	public UserDTO getUser() throws SQLException {
		//세션꺼내서 담기
		String Id = (String)RequestContextHolder.getRequestAttributes().getAttribute("userId", RequestAttributes.SCOPE_SESSION);
		UserDTO dto = UserDAO.getUser(Id);
		
		return dto;
	}
	
	//회원정보 수정
	@Override
	public int updateUser(UserDTO dto,String nickname,String mobile) throws SQLException {
		
		int result = UserDAO.updateUser(dto,nickname,mobile);
		if(result == 1) {
			//reviewid 수정
			UserDAO.reviewupdate(dto,nickname);
		}
		
		return result;
	}
	
	//카카오 유저 정보 수정
	@Override
	public int updatekakao(UserDTO dto,String nickname,String mobile) throws SQLException {
		
		
			//정보수정
		int result = UserDAO.updateUser(dto,nickname,mobile);
		if(result == 1) {
			//reviewid 수정
			UserDAO.reviewupdate(dto,nickname);
		}
		
		return result;
	}
	
	//회원탈퇴 (id,pw체크)
	@Override
	public int userDeletepw(UserDTO dto) throws SQLException {
		
		int result = 0;
		
		if(dto.getId() == null) {//일반
			String userId = (String)RequestContextHolder.getRequestAttributes().getAttribute("userId", RequestAttributes.SCOPE_SESSION);
			dto.setId(userId);
			
			result = UserDAO.IdPwcheck(dto);
			
			if(result == 1) {
				//1:1문의 삭제
				UserDAO.userQuestionDelete(dto);
				//정보삭제
				UserDAO.userDeletepw(dto);
				//세션삭제
				RequestContextHolder.getRequestAttributes().removeAttribute("userId", RequestAttributes.SCOPE_SESSION);
				//리뷰가져오기
				List<ReviewDTO> list = UserDAO.userReview(dto);
				
				for(int i = 0; i < list.size(); i++) {
					ReviewDTO revdto = list.get(i);
					int reviewHosNo = revdto.getReviewHosNo();
					UserDAO.userReviewUpdate(reviewHosNo);
				}
				
				UserDAO.userReviewDelete(dto);
			}
		}else {//카카오
			result = UserDAO.IdPwcheck(dto);
			
			if(result == 1) {
				//1:1문의 삭제
				UserDAO.userQuestionDelete(dto);
				//정보삭제
				UserDAO.userDeletepw(dto);
				//세션삭제
				RequestContextHolder.getRequestAttributes().removeAttribute("kakaoId", RequestAttributes.SCOPE_SESSION);
				//리뷰가져오기
				List<ReviewDTO> list = UserDAO.userReview(dto);
				
				for(int i = 0; i < list.size(); i++) {
					ReviewDTO revdto = list.get(i);
					int reviewHosNo = revdto.getReviewHosNo();
					UserDAO.userReviewUpdate(reviewHosNo);
				}
				UserDAO.userReviewDelete(dto);
			}
		}
		return result;
	}
	
	//id찾기
	@Override
	public String findid(UserDTO dto) throws SQLException {
		
		String id = UserDAO.findid(dto);
		System.out.println("id123 : " + id);
		if(id == null) {
			id = "null";
		}
		if(id.contains("@")) {//여기 손봐야함
			id = "null";
		}
		return id;
	}
	
	//pw찾기
	@Override
	public String findpw(UserDTO dto) throws SQLException {
		
		String pw = UserDAO.findpw(dto);
		
		return pw;
	}
	
	//pw변경
	@Override
	public int pwModify(String pw, String pwModify, String pwModifych) throws SQLException {
		
		//세션 꺼내기
		String userId = (String)RequestContextHolder.getRequestAttributes().getAttribute("userId", RequestAttributes.SCOPE_SESSION);
		
		//기존 pw가 맞는지 IdPwcheck 메서드 활용하기 위해 dto에 담
		UserDTO dto = new UserDTO();
		dto.setId(userId);
		dto.setPw(pw);
		
		int result = UserDAO.IdPwcheck(dto);
		
		if(result == 1) { //기존 pw가 맞다면
			if(pwModify.equals(pwModifych)) { //새 pw와 pwch가 맞으면 변경
				UserDAO.pwModify(userId,pwModify);//업데이트
				//세션삭제
				RequestContextHolder.getRequestAttributes().removeAttribute("userId", RequestAttributes.SCOPE_SESSION);
				result = 1;
			}else{// 아니면 2
				result = 2;
			}
		}else {//기존 pw가 다르면 0
			result = 0;
		}
		return result;
	}
	
	//id 중복체크
	@Override
	public int idCheck(UserDTO dto) throws SQLException {
		
		int result = UserDAO.IdPwcheck(dto);
		
		return result;
	}
	//---------------------------------------1:1 문의 ----------------------------------------------
	
	//1:1등록
	@Override
	public void QuestionContent(MtmDTO dto, int num) throws SQLException {
		
		String userId = null;
		String kakaoId = null;
		
		if(num == 1) {
			//세션가져오기
			userId = (String)RequestContextHolder.getRequestAttributes().getAttribute("userId", RequestAttributes.SCOPE_SESSION);
			dto.setMtmuserid(userId);
			UserDAO.QuestionContent(dto);
		}else {
			//세션가져오기
			kakaoId = (String)RequestContextHolder.getRequestAttributes().getAttribute("kakaoId", RequestAttributes.SCOPE_SESSION);
			dto.setMtmuserid(kakaoId);
			UserDAO.QuestionContent(dto);
		}
		
	}
	//1:1문의 글 목록 가져오기
	@Override
	public Map<String, Object> getArticleList(String pageNum, int num) throws SQLException {
		
			String userId = null;
			String kakaoId = null;
			UserDTO dto = new UserDTO();
			
			if(num == 1) {
				//세션꺼내기
				userId = (String)RequestContextHolder.getRequestAttributes().getAttribute("userId", RequestAttributes.SCOPE_SESSION);
				dto.setId(userId);
			}else {
				//세션꺼내기
				kakaoId = (String)RequestContextHolder.getRequestAttributes().getAttribute("kakaoId", RequestAttributes.SCOPE_SESSION);
				dto.setId(kakaoId);
			}	
			
			//한페이지에 보여줄 게시글수
			int pageSize = 3;
			//현재 페이지번호
			if(pageNum == null) {
				pageNum = "1";
			}
			
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage -1) * pageSize+1; //페이지 시작글 번호
			int endRow = currentPage * pageSize;//페이지 마지막 글번호
			
			//게시글 가져오기
			List<MtmDTO> articleList = null;
			int count = 0;
			int number = 0;
			
			//일반 유저 전체 글의 개수 가져오기
			count = UserDAO.getArticleList(dto); //게시글 총 개수
			if(count > 0) {//글이 하나라도 있다면
				articleList = UserDAO.getArticles(startRow,endRow,dto);
			}

			number = count - (currentPage-1) * pageSize; //게시판 목록에 뿌려줄 가상의 글 번호
			System.out.println("number : " + number);
			
			//view에 전달
			Map<String, Object> result = new HashMap<>();
			
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
	
	//1:1 문의글 가져오기
	@Override
	public MtmDTO getmtm(int mtmno) throws SQLException {
		
		MtmDTO mtmdto = UserDAO.getmtm(mtmno);
		
		return mtmdto;
	}
	
	//1:1 문의 수정
	@Override
	public void QuestionSignup(MtmDTO dto) throws SQLException {
		
		UserDAO.QuestionSignup(dto);
		
	}
	
	//1:1 문의 삭제 
	@Override
	public void QuestionDelete(int mtmno) throws SQLException {
		
		UserDAO.QuestionDelete(mtmno);
		
	}
	
	//ajax 닉네임
	@Override
	public int ajaxnicknamecheck(UserDTO dto) throws SQLException {
		
		int result = UserDAO.ajaxnicknamecheck(dto);
		
		return result;
	}
	//카카오 로그인
	@Override
	public int kakaoid(String kakaoemail) throws SQLException {
		
		int kakao = UserDAO.kakaoid(kakaoemail);
		
		return kakao;
	}
	
	//1:1문의 글 목록 가져오기
	@Override
	public Map<String, Object> userReviewList(String pageNum, UserDTO dto) throws SQLException {
		
		//한페이지에 보여줄 게시글수
		int pageSize = 3;
		//현재 페이지번호
		if(pageNum == null) {
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage -1) * pageSize+1; //페이지 시작글 번호
		int endRow = currentPage * pageSize;//페이지 마지막 글번호
		
		//Map 객체생성
		List<UserReviewDTO> articleList = null;
		
		//게시글 가져오기
		int count = 0;
		int number = 0;
		
		//일반 유저 전체 글의 개수 가져오기
		count = UserDAO.userReviewListcount(dto); //게시글 총 개수
		if(count > 0) {//글이 하나라도 있다면
			articleList = UserDAO.userReviewList(startRow,endRow,dto);
		}
		
		number = count - (currentPage-1) * pageSize; //게시판 목록에 뿌려줄 가상의 글 번호
		System.out.println("number : " + number);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
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
	

		

	


	
		
		
		
		
	
	
	
	
	
	
	
	
	
}
