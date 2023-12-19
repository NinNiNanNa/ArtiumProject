package com.edu.springboot.common;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBookMarkService {
	// 특정 사용자의 북마크 목록 가져오기
	public ArrayList<BookMarkDTO> getBookMark(BookMarkDTO bookMarkDTO);
	// 북마크 추가
    public int addBookMark(BookMarkDTO bookMarkDTO);
    // 북마크 삭제
    public int removeBookMark(String bmId);
}
