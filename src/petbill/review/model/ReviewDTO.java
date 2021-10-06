package petbill.review.model;

import java.sql.Timestamp;

public class ReviewDTO {
	
	private Integer reviewNo;
	private String reviewSubject;
	private String reviewId;
	private String reviewPetType;
	private String reviewArticle;
	private String reviewPhoto;
	private String reviewPrice;
	private String reviewContent;
	private Integer reviewHosNo;
	private Timestamp reviewDate;
	
	
	public Integer getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(Integer reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getReviewSubject() {
		return reviewSubject;
	}
	public void setReviewSubject(String reviewSubject) {
		this.reviewSubject = reviewSubject;
	}
	public String getReviewId() {
		return reviewId;
	}
	public void setReviewId(String reviewId) {
		this.reviewId = reviewId;
	}
	public String getReviewPetType() {
		return reviewPetType;
	}
	public void setReviewPetType(String reviewPetType) {
		this.reviewPetType = reviewPetType;
	}
	public String getReviewArticle() {
		return reviewArticle;
	}
	public void setReviewArticle(String reviewArticle) {
		this.reviewArticle = reviewArticle;
	}
	public String getReviewPhoto() {
		return reviewPhoto;
	}
	public void setReviewPhoto(String reviewPhoto) {
		this.reviewPhoto = reviewPhoto;
	}
	public String getReviewPrice() {
		return reviewPrice;
	}
	public void setReviewPrice(String reviewPrice) {
		this.reviewPrice = reviewPrice;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Integer getReviewHosNo() {
		return reviewHosNo;
	}
	public void setReviewHosNo(Integer reviewHosNo) {
		this.reviewHosNo = reviewHosNo;
	}
	public Timestamp getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}
	
	

	

}
