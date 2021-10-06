package petbill.review.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Repository
public class ReviewDAOImpl implements ReviewDAO{

	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	// 리뷰 작성 
	@Override
	public int reviewWrite(ReviewDTO dto) throws SQLException{
		
		int result = sqlSession.insert("review.reviewWrite", dto);
		System.out.println("result : " + result);
		
		return result;
	}

	// 리뷰 개수 count
	@Override
	public int totleRevCount(ReviewDTO dto) throws SQLException {
		
		int count = sqlSession.selectOne("review.totleRevCount",dto);
		
		return count;
	}

	// 리뷰 count up +1 메서드 건우/태준 
	@Override
	public void revCountUp(ReviewDTO dto,int count) throws SQLException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewHosNo", dto.getReviewHosNo());
		map.put("count", count);
		
		
		sqlSession.update("review.revCountUp", map);
	}
	

	// 한페이지 게시글 목록 
	@Override
	public List getReview() throws SQLException {
		
		List<ReviewDTO> reviewList = sqlSession.selectList("review.getReview");
		
		return reviewList;
	}

	// 리뷰 1개 가져오기
	@Override
	public ReviewDTO getReviewOne(int reviewNo) throws SQLException{
		ReviewDTO review = sqlSession.selectOne("review.getReviewOne", reviewNo);
		
		return review;
	}
	 
	// 리뷰 수정
	@Override
	public int updateReview(ReviewDTO dto) throws SQLException{
		int update = sqlSession.update("review.updateReview", dto);
		return update;
	}

	// 리뷰 삭제
	@Override 
	public int deleteReview(ReviewDTO dto) throws SQLException{
		int delete = sqlSession.delete("review.deleteReview", dto);
		return delete;
	}

	public int updateReviewPhoto(ReviewDTO dto) {
		int update = sqlSession.update("review.updateReviewFile", dto);
		return update;
	}



	








	

 
  


}
