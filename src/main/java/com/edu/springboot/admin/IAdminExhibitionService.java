package com.edu.springboot.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.exhibition.ExhibitionDTO;
import com.edu.springboot.exhibition.ParameterDTO;
import com.edu.springboot.exhibition.SimpleReviewDTO;


@Mapper
public interface IAdminExhibitionService {
	// 전시목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getTotalCount(ParameterDTO parameterDTO);
	// 전시목록
	public ArrayList<ExhibitionDTO> listPage(ParameterDTO parameterDTO);
	// 전시 상세보기
	public ExhibitionDTO view(ExhibitionDTO exhibitionDTO);
	// 조회수 올리기
	public int visitCount(String ex_seq);
	// 북마크수 올리기
	public int bmCount(String ex_seq);
	
	// 한줄평 목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getSimpleReviewCount(ParameterDTO parameterDTO);
	// 한줄평 목록
	public ArrayList<SimpleReviewDTO> listSimpleReview(ParameterDTO parameterDTO);
	// 한줄평 삭제
	public int deleteSimpleReview(String srv_id);
}
