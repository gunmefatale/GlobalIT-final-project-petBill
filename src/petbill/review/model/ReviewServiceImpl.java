package petbill.review.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import petbill.user.model.UserDAOImpl;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDAOImpl reviewDAO = null;
 
	// 리뷰 저장 
	@Override
	public void reviewWrite(ReviewDTO dto) throws SQLException {
		int result = reviewDAO.reviewWrite(dto);
		if (result == 1) {
			int count = reviewDAO.totleRevCount(dto);
			reviewDAO.revCountUp(dto,count);
		}
	} 

	
	// 게시글 하나 불러오기
	@Override
	public ReviewDTO getReview(int reviewNo) throws SQLException {
		ReviewDTO review = reviewDAO.getReviewOne(reviewNo);
		return review;
	}

	// 게시글 수정
	public int updateReview(ReviewDTO dto) throws SQLException{
		int update = reviewDAO.updateReview(dto);
		
		return update;
	}
	
	// 게시글 삭제
	public int deleteReview(ReviewDTO dto) throws SQLException{
		int delete = reviewDAO.deleteReview(dto);
		
		System.out.println("dto에 담겨있나? : " + dto.getReviewHosNo());
		
		// 리뷰 삭제 -1 카운트 해주기 ** 건우/태준 **
		if (delete == 1) {
			int count = reviewDAO.totleRevCount(dto);
			reviewDAO.revCountUp(dto,count);
		}
		
		return delete;
	}

	public int updateReviewPhoto(ReviewDTO dto) {
		int update = reviewDAO.updateReviewPhoto(dto);
		
		return update;
	}




	
	

}
