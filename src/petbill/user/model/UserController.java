package petbill.user.model;

//import java.lang.ProcessBuilder.Redirect;
import java.sql.SQLException;
//import java.text.DateFormat;
//import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

//import com.google.gson.Gson;
//import com.sun.net.httpserver.HttpHandler;

//import petbill.hospital.model.HospitalDTO;
//import petbill.review.model.ReviewServiceImpl;
//import petbill.user.model.UserDTO;
//import petbill.user.model.UserServiceImpl;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private UserServiceImpl UserService = null;
	
	
	//회원가입 form
	@RequestMapping("userSignupForm.pet")
	public String userSignupForm(Model model,@RequestParam Map<String, Object> Map) {
		System.out.println("카카오 정보 : " + Map);
		
		model.addAttribute("id",Map.get("id"));
		model.addAttribute("pw",Map.get("pw"));//카카오 에서 넘어온 id를 password와 id에 넣을예정
		
		return "user/userSignupForm";
	}
	
	
	//회원가입 pro
	@PostMapping("userSignupPro.pet")
	public String userSignupPro(UserDTO dto,Model model) throws SQLException{
		
		int result = UserService.userSignup(dto);
		model.addAttribute("result",result);
		return "user/userSignupPro";
	}
	
	//메인
	@RequestMapping("main.pet")		//쿠키
	public String main(HttpSession session,HttpServletRequest request) {
		//----------------쿠키------------
		if(session.getAttribute("userId") == null) {//세션이 없을때
			//쿠키 있는지 확인
			UserDTO dto = new UserDTO();
			String auto = null;
			Cookie[] cookie = request.getCookies();//쿠키 꺼내기
			if(cookie != null) { //쿠키값이 있다면 실행
				System.out.println("메인쿠키");
				System.out.println("cookie : " + cookie);
				for(Cookie c : cookie) {
					if(c.getName().equals("autoid")) {dto.setId(c.getValue());}
					if(c.getName().equals("autopw")) {dto.setPw(c.getValue());}
					if(c.getName().equals("autoch")) {auto = c.getValue();}
				}
			}
			System.out.println("dtoid : "+dto.getId());
			System.out.println("dtopw : "+dto.getPw());
			System.out.println("auto : "+ auto);
			//세션은 없지만, 쿠키가 있어서 위 코드로 값을 꺼내 담아보고,
			//만약에 세 변수에 값이 들어있으면 session만들어 주기 위해서 loginPro로 이동시키기
			if(dto.getId() != null && dto.getPw() != null && auto != null) {
				System.out.println("여기는?");
				return "redirect:/user/loginPro.pet"; //loginPro로 이동
			}
		}
		return "user/main";
	}
	
	//로그인 form
	@RequestMapping("loginForm.pet")
	public String loginForm() {
		
		return "user/loginForm";
	}
	
	//로그인 pro
	@RequestMapping("loginPro.pet")											//쿠키
	public String loginPro(UserDTO dto, String auto, Model model, HttpServletResponse response, HttpServletRequest request) throws SQLException{
		
		//--------------쿠키------------------------
		//main에서 왔으면 dto값이 없을것이다.
		Cookie[] cookie = request.getCookies();
		System.out.println("여기왔나?");
		if(cookie != null) {
			System.out.println("쿠키값이 null이 아닐때");
			for(Cookie c : cookie) {
				if(c.getName().equals("autoid")) {dto.setId(c.getValue());}
				if(c.getName().equals("autopw")) {dto.setPw(c.getValue());}
				if(c.getName().equals("autoch")) {auto = c.getValue();}
			}
		}
		
		//일반회원 id,pw 체크
		int result = UserService.IdPwcheck(dto);
		
		if(result == 1) {//로그인 체크가 됐을때
			if(auto != null) {//자동 로그인을 눌렀을때
				System.out.println("쿠키생성");
				//쿠키 생성
				Cookie c1 = new Cookie("autoid", dto.getId());
				Cookie c2 = new Cookie("autopw", dto.getPw());
				Cookie c3 = new Cookie("autoch", auto);
				c1.setMaxAge(60*60*24);//24시간
				c2.setMaxAge(60*60*24);//24시간
				c3.setMaxAge(60*60*24);//24시간
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
			}
		}
		
		//--------------쿠키------------------------
		//view로 보내기
		model.addAttribute("result",result);
		
		return "user/loginPro";
	}
	
	//로그아웃
	@RequestMapping("logoutPro.pet")							//쿠키
	public String logoutPro(HttpSession session, Model model,HttpServletRequest request,HttpServletResponse response) {
		
			session.invalidate();
			UserService.logout("userId");//일반유저 세션삭제
			// 쿠키 삭제
			Cookie[] cookie = request.getCookies();
			if(cookie != null) {//쿠키 값이 있으면
				System.out.println("쿠키 삭제돼라");
				for(Cookie c : cookie) {
					if(c.getName().equals("autoid") || c.getName().equals("autopw")||c.getName().equals("autoch")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}
		
		return "redirect:/user/main.pet";
	}
	
	//마이페이지
	@RequestMapping("userMypage.pet")
	public String userMypage(Model model,HttpSession session) throws SQLException{
		
		UserDTO dto = null;
		
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
		}
		model.addAttribute("dto", dto);
		
		return "user/userMypage";
	}
	
	//유저 정보 수정 Form
	@RequestMapping("userModifyForm.pet")
	public String userModifyForm (Model model,HttpSession session) throws SQLException{
		
		UserDTO dto = null;
		
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
		}
		model.addAttribute("dto", dto);
		
		return "user/userModifyForm";
	}
	
	//유저 정보 수정 Pro
	@RequestMapping("userModifyPro.pet")
	public String userModifyPro(String nickname, String mobile, Model model,HttpSession session) throws SQLException{
		
		UserDTO dto = null;
		int result = 0;
		System.out.println("pro");
		System.out.println("nickname : " + nickname);
		System.out.println("mobile : " + mobile);
		if(session.getAttribute("userId") != null) {
			System.out.println("탔다");
			//유저 1명정보 가져오기
			dto = UserService.getUser();
			//정보수정
			result= UserService.updateUser(dto,nickname,mobile);
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
			result = UserService.updatekakao(dto,nickname,mobile);
		}
		
		model.addAttribute("result",result);
		
		return "user/userModifyPro";
	}
	
	//회원탈퇴 delete Form
	@RequestMapping("userDeleteForm.pet")
	public String userDeleteForm(Model model,HttpSession session) throws SQLException{
		
		UserDTO dto = null;
		
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
		}
		model.addAttribute("dto", dto);
		
		return "user/userDeleteForm";
	}
		
	//회원탈퇴 delete Pro
	@RequestMapping("userDeletePro")							//쿠키
	public String userDeletePro(UserDTO dto, Model model,HttpServletRequest request, HttpServletResponse response) throws SQLException{
		
		System.out.println("dto nickname : " + dto.getNickname());
		System.out.println("dto333333 : " + dto.getPw());
		
		int result = UserService.userDeletepw(dto);
		
		//-----------쿠키---------
		if(result == 1) {
			// 쿠키 삭제
			Cookie[] cookie = request.getCookies();
			if(cookie != null) {//쿠키 값이 있으면
				System.out.println("쿠키 탈퇴 돼라");
				for(Cookie c : cookie) {
					if(c.getName().equals("autoid") || c.getName().equals("autopw")||c.getName().equals("autoch")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}
		}
		
		model.addAttribute("result",result);
		
		return "user/userDeletePro";
	}
	
	//id찾기 form
	@RequestMapping("findIdForm.pet")
	public String findIdForm() {
		
		return "user/findIdForm";
	}
	
	//id찾기 pro
	@RequestMapping("findIdPro.pet")
	public String findIdPro(UserDTO dto,Model model) throws SQLException{
		
		String id = UserService.findid(dto);
		System.out.println("id : " + id);
		model.addAttribute("id",id);
		
		return "user/findIdPro";
	}
	
	
	//pw찾기 form
	@RequestMapping("findPwForm.pet")
	public String findPwForm() {
		
		return "user/findPwForm";
	}
	
	//pw찾기 pro
	@RequestMapping("findPwPro.pet")
	public String findPwPro(UserDTO dto,Model model) throws SQLException{
		
		String pw = null;
		if(!dto.getId().contains("@")) {
			pw = UserService.findpw(dto);
		}else {
			pw = null;
		}
		
		model.addAttribute("pw",pw);
		
		return "user/findPwPro";
	}
	
	//비밀번호 수정Form
	@RequestMapping("pwModifyForm.pet")
	public String pwModifyForm() {
		
		return "user/pwModifyForm";
	}
	//비밀번호 수정Pro
	@RequestMapping("pwModiFyPro.pet")
	public String pwModiFyPro(HttpServletRequest request, HttpServletResponse response, 
			String pw,String pwModify,String pwModifych,Model model) throws SQLException{
		
		int result = UserService.pwModify(pw,pwModify,pwModifych);
		if(result == 1) {
			// 쿠키 삭제
			Cookie[] cookie = request.getCookies();
			if(cookie != null) {//쿠키 값이 있으면
				System.out.println("쿠키 삭제돼라");
				for(Cookie c : cookie) {
					if(c.getName().equals("autoid") || c.getName().equals("autopw")||c.getName().equals("autoch")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}
		}
		
		model.addAttribute("result",result);
		
		return "user/pwModiFyPro";
	}
	
	//--------------------------ajax---------------------------------------------
	
	//ajax 아이디 중복
	@RequestMapping("ajaxidcheck.pet")
	public ResponseEntity<String>ajaxidcheck(UserDTO dto)throws SQLException{
		int result = UserService.idCheck(dto);
		
		String data="";
		if(result ==1) {
			data = "이미 사용중인 아이디";
		}else {
			data = "사용 가능한 아이디";
		}
		
		HttpHeaders respHeaders = new HttpHeaders();
		respHeaders.add("Content-Type", "text/html;charset=UTF-8");//한글깨짐
		
		return new ResponseEntity<String>(data,respHeaders,HttpStatus.OK);
	}
	
	//ajax 닉네임 중복
	@ResponseBody
	@RequestMapping("ajaxnicknamecheck.pet")
	public int ajaxnicknamecheck(UserDTO dto)throws SQLException{
		System.out.println("탔나?");
		int result = UserService.ajaxnicknamecheck(dto);
		System.out.println("result : "+ result);
		int data= 0;
		if(result == 0) {
			data = 0;
		}else {
			data = 1;
		}
		
		return data;
	}
	
	//------------------------1:1문의----------------------------------------------------
	
	//1:1문의
	@RequestMapping("userQuestion.pet")
	public String userQuestion(String pageNum, Model model, HttpSession session) throws SQLException{
		
		int num = 0;
		Map<String, Object> result = null;
		
		if(session.getAttribute("userId") != null) {
			num = 1;
			result = UserService.getArticleList(pageNum,num);
		}else {
			result = UserService.getArticleList(pageNum,num);
		}
		
		model.addAttribute("pageSize",result.get("pageSize"));
		model.addAttribute("pageNum",result.get("pageNum"));
		model.addAttribute("currentPage",result.get("currentPage"));
		model.addAttribute("startRow",result.get("startRow"));
		model.addAttribute("endRow",result.get("endRow"));
		model.addAttribute("articleList",result.get("articleList"));
		model.addAttribute("count",result.get("count"));
		model.addAttribute("number",result.get("number"));
		
		return "user/userQuestion";
	}
	
	//1:1문의 작성
	@RequestMapping("QuestionSignup")
	public String QuestionSignup(String pageNum,Model model,HttpSession session) throws SQLException{
		
		UserDTO dto = null;
		
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
		}
		model.addAttribute("dto", dto);
		model.addAttribute("pageNum",pageNum);
		
		return "user/QuestionContent";
	}
	
	//1:1문의 content
	@RequestMapping("QuestionContent.pet")
	public String QuestionContent(int mtmno, String pageNum, Model model) throws SQLException{
			
			//1:1문의글 가져오기
			MtmDTO mtmdto = UserService.getmtm(mtmno);
			
			model.addAttribute("mtmdto",mtmdto);
			model.addAttribute("pageNum",pageNum);
		
		//view보내기
		return "user/QuestionContent";
	}
	
	//1:1문의 작성 pro
	@RequestMapping("QuestionContentPro.pet")
	public String QuestionContentPro(MtmDTO dto,HttpSession session) throws SQLException{
		
		int num = 0;
		if(session.getAttribute("userId") != null) {
			num = 1; 
			//일반유저 1:1 작성
			UserService.QuestionContent(dto,num);
		}else {
			//카카오 유저 1:1 작성
			UserService.QuestionContent(dto,num);
		}
		
		return "redirect:/user/userQuestion.pet";
	}
	
	//1:1문의 수정
	@RequestMapping("QuestionModify.pet")
	public String QuestionSignup(MtmDTO dto)throws SQLException{
		
		//수정
		UserService.QuestionSignup(dto);
		
		return "redirect:/user/userQuestion.pet";
	}
	//1:1문의 삭제
	@RequestMapping("QuestionDelete.pet")
	public String QuestionDelete(int mtmno)throws SQLException{
		
		UserService.QuestionDelete(mtmno);
		
		return "redirect:/user/userQuestion.pet";
	}

	//카카오 로그인
	@ResponseBody
	@RequestMapping(value="/kakaologin.pet", method=RequestMethod.POST)
	public Map<String, Object> kakaologin(@RequestParam Map<String,Object> Map, HttpSession session) throws SQLException, Exception {
		System.out.println("Map:" + Map);
		//view에 보낼 map 객체 생성
		Map <String, Object> view = new HashMap<String, Object>();
		
		//DB에 이메일 정보가 있는지 체크메서드
		Map<String, Object> user = UserService.kakaologincheck(Map);
		System.out.println("유저 : " + user);
		
		if(user == null) { //일치하는 이메일 없으면 회원가입
			System.out.println("카카오 회원가입");
			view.put("kakaosignup", "kakaosignup");
		}else if(user.get("KAKAOLOGIN").equals("none") && user.get("ID") != null) { //가입 되어있고 카카오 연동 안되어 있을시
			System.out.println("카카오 로그인");
			UserService.KakaoupdateConnection(Map);//kakaologin컬럼 update
			UserService.KakaoLoginPro(Map);//로그인시키기
			view.put("login", "YES");
		}else{//바로 로그인 시키기
			UserService.KakaoLoginPro(Map);
			view.put("login", "YES");
		}
		
		return view;
	}
	//카카오 로그아웃
	@ResponseBody
	@RequestMapping(value="/kakaologout.pet", method=RequestMethod.POST)
	public void kakaologout (HttpSession session){
		
		session.invalidate();

	}
	
	//------------------------------------------------------------------
	//리뷰 리스트
	@RequestMapping("userReviewList.pet")
	public String userReviewList(String pageNum, Model model, HttpSession session) throws SQLException{
		
		UserDTO dto = null;
		Map<String, Object> result = null;
		
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String id = (String)session.getAttribute("kakaoId");
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(id);
		}
		
		result = UserService.userReviewList(pageNum,dto);
		System.out.println("result : " + result);
		
		model.addAttribute("pageSize",result.get("pageSize"));
		model.addAttribute("pageNum",result.get("pageNum"));
		model.addAttribute("currentPage",result.get("currentPage"));
		model.addAttribute("startRow",result.get("startRow"));
		model.addAttribute("endRow",result.get("endRow"));
		model.addAttribute("articleList",result.get("articleList"));
		model.addAttribute("count",result.get("count"));
		model.addAttribute("number",result.get("number"));
		
		
		return "user/userReviewList";
	}
	

	

}
