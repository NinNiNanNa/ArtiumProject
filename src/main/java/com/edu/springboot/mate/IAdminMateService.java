package com.edu.springboot.mate;

import java.time.LocalDate;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.edu.springboot.mate.MtCommentDTO;
 
@Mapper
public interface IAdminMateService {
	// Paging처리를 위해 게시물의 갯수를 카운트
	public int getTotalCount(ParameterDTO parameterDTO);

	// 게시판 목록(페이징 기능 추가)
	public ArrayList<MateDTO> listPage(ParameterDTO parameterDTO);
	
	//모집중, 모집완료 분류 
	//public ArrayList<MateDTO> listPageByStatus(ParameterDTO parameterDTO);
	public ArrayList<MateDTO> listPageByStatus(@Param("parameterDTO") ParameterDTO parameterDTO);

	// mate 상세보기
	public MateDTO view(MateDTO mateDTO);

	// 조회수 올리기
	public int visitCount(String mt_id);

	// 북마크 올리기
	public int bomcount(String mt_id);

	// 작성하기(받은 폼값은 이름을 변경한 후 매퍼로 전달한다)
//	public int write(
//			@Param("_mt_status") String mt_status,
//			@Param("_mt_title") String mt_title,
//			//추후 변경해야 함   
//			//@Param("_ex_info") String ex_info,
//			@Param("_mt_viewdate") LocalDate mt_viewdate,
//			@Param("_mt_gender") String mt_gender,
//			@Param("_mt_age1") String mt_age1,
//			@Param("_mt_age2") String mt_age2,
//			@Param("_mt_content") String mt_content);
	public int write(MateDTO mateDTO);

	// 수정하기
	public int edit(MateDTO mateDTO);

	// 삭제하기
	public int delete(String mt_id);

	
	
	// 한줄평 목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getMateComment(MateDTO mateDTO);

	// 한줄평 목록
	public ArrayList<MtCommentDTO> listMateComment(MateDTO mateDTO);

	// 한줄평 내용
	public MtCommentDTO viewMateMt_Comment(MtCommentDTO mtCommentDTO);

	// 메이트 댓글 작성
	public int writeMateComment(MtCommentDTO mtCommentDTO);
	
	// 한줄평 수정
	public int editMateComment(MtCommentDTO mtCommentDTO);
		
	// 한줄평 삭제
	public int deleteMateComment(String mtcom_id);

	
	
	/*
	 * //작성하기(받은 폼값은 이름을 변경한 후 매퍼로 전달한다) public int write(@Param("_name") String
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