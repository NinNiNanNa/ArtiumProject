package com.edu.springboot.jdbc;


import java.util.ArrayList;

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
		public int write(
			@Param("_rv_title") String rv_title,
			@Param("_rv_date") String rv_date,
			@Param("_rv_stime") String rv_stime,
			@Param("_rv_etime") String rv_etime,
			@Param("_rv_congestion") String rv_congestion,
			@Param("_rv_transportation") String rv_transportation,
			@Param("_rv_revisit") String rv_revisit,
			@Param("_rv_image") String rv_image,
			@Param("_rv_content") String rv_content
		);
		
		// 리뷰 수정하기
		public int edit(ReviewDTO reviewDTO);
		
		// 리뷰 삭제하기
		public int delete(String rv_id);
		
		// 조회수 올리기
		public int visitCount(String rv_id);
		
		// 북마크수 올리기
		public int bmCount(String rv_id);
}
