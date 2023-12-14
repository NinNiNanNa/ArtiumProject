package com.edu.springboot.common;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IBookMarkService {
	// 게시글 북마크
	public BookMarkDTO viewBM(BookMarkDTO bookMarkDTO);
	public int deleteBM(int bm_id);
	public BookMarkDTO insertBM(@Param("userId") String user_id, @Param("exSeq") String ex_seq);
	public int countBM();
	public int updateBM();
}
