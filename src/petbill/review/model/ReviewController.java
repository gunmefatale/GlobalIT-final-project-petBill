package petbill.review.model;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import petbill.user.model.UserDTO;
import petbill.user.model.UserServiceImpl;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Autowired
	private ReviewServiceImpl reviewService = null;
	@Autowired
	private UserServiceImpl UserService = null;
	
	//리뷰 작성 Form
	@RequestMapping("reviewWriteForm.pet")
	public String writeForm(HttpSession session, Model model, String pageNum, int hosNo,String petType,String hosSi,String hosGu,String diagnosis) throws SQLException{
		
		
		UserDTO dto = null;
		System.out.println("카카오 :" + session.getAttribute("kakaoId"));

		
		if(session.getAttribute("userId") != null) {
			//유저 1명정보 가져오기
			dto = UserService.getUser();
		}else {
			String Id = (String)session.getAttribute("kakaoId");
			System.out.println("아이디 : " + Id);
			//DB카카오 유저 정보 가져오기
			dto = UserService.getkakao(Id);
		}
		
		System.out.println("hosSi Form : " + hosSi);
		System.out.println("hosGu Form: " + hosGu);
		
		model.addAttribute("dto", dto);
		model.addAttribute("hosNo", hosNo);
		model.addAttribute("petType", petType);
		model.addAttribute("hosSi", hosSi);
		model.addAttribute("hosGu", hosGu);
		model.addAttribute("hosSi", hosSi);
		model.addAttribute("diagnosis", diagnosis);
		model.addAttribute("pageNum", pageNum);
	
		return "review/reviewWriteForm";
	}
	
	//리뷰 작성 pro
	   @RequestMapping("reviewWritePro.pet")
	   public String writePro(MultipartHttpServletRequest request, int reviewHosNo, String pageNum, String petType,String hosSi,String hosGu, String diagnosis, MultipartFile mf) throws SQLException, UnsupportedEncodingException {
	            
//	      System.out.println("hosSi Pro: " + hosSi);
//	      System.out.println("hosGu Pro: " + hosGu);
	      
	         
		   ReviewDTO dto = new ReviewDTO();
		      dto.setReviewSubject(request.getParameter("reviewSubject"));
		      dto.setReviewId(request.getParameter("reviewId")); 
		      dto.setReviewPetType(request.getParameter("reviewPetType"));
		      dto.setReviewArticle(request.getParameter("reviewArticle"));
		      dto.setReviewPrice(request.getParameter("reviewPrice"));
		      dto.setReviewContent(request.getParameter("reviewContent"));
		      dto.setReviewHosNo(reviewHosNo);
		         
		      mf = request.getFile("reviewPhoto");
		      String path = request.getRealPath("photo");
		      String fileName = mf.getOriginalFilename();
		      if (!mf.isEmpty()) {
		         String contentType = mf.getContentType();
		         String[] type = contentType.split("/");
		         if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
		         mf = request.getFile("reviewPhoto");
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
		      dto.setReviewPhoto(newName);
		      }
		      }
		      reviewService.reviewWrite(dto);
		   
		      String si = URLEncoder.encode(hosSi, "UTF-8");
		      String gu = URLEncoder.encode(hosGu, "UTF-8");
		      
		      System.out.println("hosSi Pro: " + hosSi);
		      System.out.println("hosGu Pro: " + hosGu);
	      
	      return "redirect:/hospital/hosContent.pet?petType="+petType+"&hosNo="+reviewHosNo + "&pageNum="+pageNum +"&hosSi="+si+"&hosGu="+gu+"&diagnosis="+diagnosis;
	      
	   }
	
	//리뷰 수정 Form
	@RequestMapping("reviewModifyForm.pet")
	public String ModifyForm(int reviewNo, Model model,String pageNum,String sel,String search) throws SQLException {
		
		ReviewDTO review = reviewService.getReview(reviewNo);
		
		model.addAttribute("review", review);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sel", sel);
		model.addAttribute("search", search);
		return "review/reviewModifyForm";
	}
	
	//수정 pro
   @RequestMapping("reviewModifyPro.pet")
   public String modifyPro(MultipartHttpServletRequest request, MultipartFile mf) throws SQLException{
      

         
	   ReviewDTO dto = new ReviewDTO();
	      dto.setReviewNo((Integer.parseInt(request.getParameter("reviewNo")))); 
	      dto.setReviewSubject(request.getParameter("reviewSubject"));
	      dto.setReviewArticle(request.getParameter("reviewArticle"));
	      dto.setReviewPrice(request.getParameter("reviewPrice"));
	      dto.setReviewContent(request.getParameter("reviewContent"));
	      
	      reviewService.updateReview(dto);
	      
	      
	      mf = request.getFile("reviewPhoto");
	      String path = request.getRealPath("photo");
	      String fileName = mf.getOriginalFilename();
	      if (!mf.isEmpty()) {
	         String contentType = mf.getContentType();
	         String[] type = contentType.split("/");
	         if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
	         mf = request.getFile("reviewPhoto");
	         System.out.println("파일삭제 완료");
	         return "redirect:/review/alert.pet";
	         //return "redirect:/review/alert.pet";
	         }else {
	            String imgName = fileName.substring(0, fileName.lastIndexOf('.'));
	            String ext = fileName.substring(fileName.lastIndexOf('.'));   
	            
	      UUID uuid = UUID.randomUUID();
	      String newName = uuid.toString().replace("-", "") + ext;
	      
	      String imgpath = path + "/" + newName;
	      
	      if (fileName != "") {
	         File uploadFile = new File(imgpath);
	         try {
	            mf.transferTo(uploadFile);
	         }catch (Exception e) {
	            e.printStackTrace();
	         }
	         dto.setReviewPhoto(newName);
	         reviewService.updateReviewPhoto(dto);
	         }
	      }
	      }
      return "redirect:/user/userReviewList.pet";
   }
	
   	//리뷰 삭제
 	@RequestMapping("reviewDeletePro.pet")
 	public String deleteForm(ReviewDTO dto, Model model, HttpSession session) throws SQLException{
 		
 		System.out.println("reviewhosno 뜨냐ㅐ?" + dto.getReviewHosNo());
 		
 		int delete = reviewService.deleteReview(dto);
 		model.addAttribute("delete", delete);
 		// ====================================================================== 내일 할꺼.
 		
 		if(session.getAttribute("userId") != null) {//유저 아이디가 있을때 실행 kakako는 x
	 		if(session.getAttribute("userId").equals("admin")&&session.getAttribute("kakaoId") == null) {//관리자일때만
	 			return "redirect:/admin/adReviewStatus.pet";
	 		}
 		}
 		
 		return "redirect:/user/userReviewList.pet";
 	}
	
	//이미지가 아닐경우
	@RequestMapping("alert.pet")
	public String alert() {
		
		return "review/alert";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}