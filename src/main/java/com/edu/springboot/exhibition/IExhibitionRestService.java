package com.edu.springboot.exhibition;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IExhibitionRestService {
	// 한줄평 총 갯수 가져오기
	public int getSimpleReviewCount(ParameterDTO parameterDTO);
	// 한줄평 목록 가져오기
    public ArrayList<SimpleReviewDTO> listSimpleReview(ParameterDTO  parameterDTO);
    // 한줄평 내용보기
    public SimpleReviewDTO viewSimpleReview(ParameterDTO parameterDTO);
    // 한줄평 작성
    public int writeSimpleReview(SimpleReviewDTO exSimpleReviewDTO);
}
