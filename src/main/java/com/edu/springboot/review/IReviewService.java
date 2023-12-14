package com.edu.springboot.review;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface IReviewService {
		// 리뷰목록 Paging처리를 위해 게시물의 갯수 카운트
		public int getTotalCount(ParameterDTO parameterDTO);
	
		// 리뷰목록
		public ArrayList<ReviewDTO> listPage(ParameterDTO parameterDTO);

		// 리뷰 상세보기
		public ReviewDTO view(ReviewDTO reviewDTO);
		
		// 리뷰 작성하기
		public int write(ReviewDTO reviewDTO);
		
		// 리뷰 수정하기
		public int edit(ReviewDTO reviewDTO);
		
		// 리뷰 삭제하기
		public int delete(String rv_id);
		
		// 조회수 올리기
		public int visitCount(String rv_id);
		
		// 북마크수 올리기
		public int bmCount(String rv_id);
}
