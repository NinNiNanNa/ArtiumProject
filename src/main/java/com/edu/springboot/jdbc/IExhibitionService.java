package com.edu.springboot.jdbc;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IExhibitionService {
	// 현재전시 Paging처리를 위해 게시물의 갯수 카운트
	public int getTotalCount_1(ParameterDTO parameterDTO);
	// 예정전시 Paging처리를 위해 게시물의 갯수 카운트
	public int getTotalCount_2(ParameterDTO parameterDTO);
	// 만료전시 Paging처리를 위해 게시물의 갯수 카운트
	public int getTotalCount_3(ParameterDTO parameterDTO);
	// 현재전시 목록
	public ArrayList<ExhibitionDTO> listPage_1(ParameterDTO parameterDTO);
	// 예정전시 목록
	public ArrayList<ExhibitionDTO> listPage_2(ParameterDTO parameterDTO);
	// 만료전시 목록
	public ArrayList<ExhibitionDTO> listPage_3(ParameterDTO parameterDTO);
	// 게시판 상세보기
	public ExhibitionDTO view(ExhibitionDTO exhibitionDTO);
	// 조회수 올리기
	public int visitCount(String ex_seq);
	// 북마크수 올리기
	public int bmCount(String ex_seq);
}
