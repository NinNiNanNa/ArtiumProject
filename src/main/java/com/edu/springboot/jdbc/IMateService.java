package com.edu.springboot.jdbc;

import java.time.LocalDate;
import java.util.ArrayList;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
 
@Mapper
public interface IMateService {
	//Paging처리를 위해 게시물의 갯수를 카운트 
	public int getTotalCount(MateParameterDTO mateParameterDTO);
	
	//게시판 목록(페이징 기능 추가)
	public ArrayList<MateDTO> listPage(MateParameterDTO mateParameterDTO);
	
	
	//작성하기(받은 폼값은 이름을 변경한 후 매퍼로 전달한다) 
	public int write(
			@Param("_mt_id") int mt_id,
			@Param("_mt_status") String mt_status,
			@Param("_mt_title") String _mt_title,
			//전시일 선택은 추후 확인 필요!!!!
			@Param("_mt_viewdate") LocalDate mt_viewdate,
			@Param("_mt_gender") String mt_gender,
			@Param("_mt_age") String mt_age,
			@Param("_mt_content") String mt_content);
	/*
	//작성하기(받은 폼값은 이름을 변경한 후 매퍼로 전달한다) public int write(@Param("_name") String
	 * name,
	 * 
	 * @Param("_title") String title,
	 * 
	 * @Param("_content") String content);
	 * 
	 * //내용보기 public mateDTO view(mateDTO mateDTO); //수정하기 public int edit(mateDTO
	 * mateDTO);
	 * 
	 * //삭제하기 public int delete(String idx);
	 */
}

