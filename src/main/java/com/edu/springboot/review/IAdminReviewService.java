package com.edu.springboot.review;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminReviewService {
	// 리뷰목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getTotalCount(ParameterDTO parameterDTO);
	// 리뷰목록
	public ArrayList<ReviewDTO> listPage(ParameterDTO parameterDTO);
	// 리뷰 상세보기
	public ReviewDTO view(ReviewDTO reviewDTO);
	// 리뷰 수정하기
	public int edit(ReviewDTO reviewDTO);
	// 리뷰 삭제하기
	public int delete(String rv_id);
	// 조회수 올리기
	public int visitCount(String rv_id);
	// 북마크수 올리기
	public int bmCount(String rv_id);

	
	// 댓글 목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getReviewCommentCount(ParameterDTO parameterDTO);
	// 댓글 목록
	public ArrayList<ReviewCommentDTO> listReviewComment(ParameterDTO parameterDTO);
	// 댓글 내용
	public ReviewCommentDTO viewReviewComment(ReviewCommentDTO reviewCommentDTO);
	// 댓글 작성
	public int writeReviewComment(ReviewCommentDTO reviewCommentDTO);
	// 댓글 수정
	public int editReviewComment(ReviewCommentDTO reviewCommentDTO);
	// 댓글 삭제
	public int deleteReviewComment(String rvc_id);
}
