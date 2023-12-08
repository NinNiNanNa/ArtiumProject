package com.edu.springboot.gallery;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edu.springboot.jdbc.ParameterDTO;

@Mapper
public interface IGalleryService {

	// Paging처리를 위한 게시물의 갯수 카운트
	public int getTotalCount(ParameterDTO parameterDTO);
	
	// 게시판 목록 (페이징 기능 추가)
	public ArrayList<GalleryDTO> listPage(ParameterDTO parameterDTO);
	
	// 갤러리 댓글 목록 조회
    public List<GalleryCommentDTO> getGalleryComments(int cm_id);

    // 갤러리 댓글 작성
    public void addGalleryComment(GalleryCommentDTO galleryCommentDTO);
    
	
	// 작성하기(받은 폼값은 이름을 변경한 후 매퍼로 전달)
	public int write(GalleryDTO galleryDTO);
	public int write(@Param("_title") String ga_title, 
            @Param("_name") String user_id,
            @Param("_sdate") String ga_sdate,
            @Param("_edate") String ga_edate,
            @Param("_content") String ga_content,
            @Param("_image1") String art_image1,
            @Param("_title1") String art_title1,
            @Param("_content1") String art_content1,
            @Param("_image2") String art_image2,
            @Param("_title2") String art_title2,
            @Param("_content2") String art_content2,
            @Param("_image3") String art_image3,
            @Param("_title3") String art_title3,
            @Param("_content3") String art_content3,
            @Param("_image4") String art_image4,
            @Param("_title4") String art_title4,
            @Param("_content4") String art_content4,
            @Param("_image5") String art_image5,
            @Param("_title5") String art_title5,
            @Param("_content5") String art_content5);
	
	// 내용보기
	public GalleryDTO view(GalleryDTO galleryDTO);
	
	// 수정하기
	public int edit(GalleryDTO galleryDTO);
	
	// 삭제하기
	public int delete(String ga_id);
	
	// 조회수 올리기
	public int visitCount(String ga_id);
	
	// 북마크 올리기
	public int bomcount(String ga_id);

	

	

}
