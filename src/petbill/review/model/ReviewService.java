package petbill.review.model;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import petbill.user.model.UserDTO;

public interface ReviewService {
	
	// 리뷰 저장
	public void reviewWrite(ReviewDTO dto) throws SQLException;

	// 리뷰 하나 가져오기
	public ReviewDTO getReview(int reviewNo) throws SQLException;
	
	// 리뷰 업데이트
	public int updateReview(ReviewDTO dto)throws SQLException;
	
	//사진 업데이트
	public int updateReviewPhoto(ReviewDTO dto)throws SQLException;
	
	// 리뷰 삭제
	public int deleteReview(ReviewDTO dto)throws SQLException;

}
 