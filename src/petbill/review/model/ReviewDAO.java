package petbill.review.model;

import java.sql.SQLException;
import java.util.List;


public interface ReviewDAO {
	
	// 리뷰 저장
	public int reviewWrite(ReviewDTO dto) throws SQLException;
	
	// 리뷰 개수 count
	public int totleRevCount(ReviewDTO dto) throws SQLException;
	
	// 리뷰 count up +1 메서드 건우/태준 
	public void revCountUp(ReviewDTO dto,int count) throws SQLException;
	
	// 한페이지
	public List<ReviewDTO> getReview() throws SQLException; 
	
	// 리뷰 1개
	public ReviewDTO getReviewOne(int reviewNo) throws SQLException;

	// 리뷰 수정
	public int updateReview(ReviewDTO dto) throws SQLException;
	
	// 사진 수정
	public int updateReviewPhoto(ReviewDTO dto) throws SQLException;

	// 리뷰 삭제
	public int deleteReview(ReviewDTO dto) throws SQLException;


	
	
} 
 