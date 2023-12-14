package com.edu.springboot.gallery;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface IGalleryService {

	// Paging처리를 위한 게시물의 갯수 카운트
	public int getTotalCount(GalleryDTO galleryDTO);
	
	// 게시판 목록 (페이징 기능 추가)
	public ArrayList<GalleryDTO> listPage(GalleryDTO galleryDTO);
    
	// 작성하기(받은 폼값은 이름을 변경한 후 매퍼로 전달)
	public int write(GalleryDTO galleryDTO);
//	public int write(
//			@Param("_ga_title") String ga_title, 
//            @Param("_user_id") String user_id,
//            @Param("_ga_sdate") String ga_sdate,
//            @Param("_ga_edate") String ga_edate,
//            @Param("_ga_content") String ga_content,
//            @Param("_art_image1") Object art_image1,
//            @Param("_art_title1") String art_title1,
//            @Param("_art_content1") String art_content1,
//            @Param("_art_image2") Object art_image2,
//            @Param("_art_title2") String art_title2,
//            @Param("_art_content2") String art_content2,
//            @Param("_art_image3") Object art_image3,
//            @Param("_art_title3") String art_title3,
//            @Param("_art_content3") String art_content3,
//            @Param("_art_image4") Object art_image4,
//            @Param("_art_title4") String art_title4,
//            @Param("_art_content4") String art_content4,
//            @Param("_art_image5") Object art_image5,
//            @Param("_art_title5") String art_title5,
//            @Param("_art_content5") String art_content5);
	
	// 내용보기
	public GalleryDTO view(GalleryDTO galleryDTO);
	
	// 온라인 갤러리
	public GalleryDTO onlineGallery(GalleryDTO galleryDTO);
	
	// 수정하기
	public int edit(GalleryDTO galleryDTO);
	
	// 삭제하기
	public int delete(String ga_id);
	
	// 조회수 올리기
	public int visitCount(String ga_id);
	
	// 북마크 올리기
	public int bomcount(String ga_id);
	
	////////////////////////////////////////////////////////////
	
	// 갤러리 댓글 목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getGalleryComments(GalleryDTO parameterDTO);
	
	// 갤러리 댓글 목록 조회
    public ArrayList<GalleryCommentDTO> listGalleryComments(GalleryDTO galleryDTO);
    
    // 갤러리 댓글 내용
    public GalleryCommentDTO viewGalleryComments(GalleryCommentDTO galleryCommentDTO);
    
    // 갤러리 댓글 작성
	public int writeGalleryComments(GalleryCommentDTO galleryCommentDTO);
    
    // 댓글 수정
	public int editGalleryComments(GalleryCommentDTO galleryCommentDTO);
    
    // 댓글 삭제
	public int deleteGalleryComments(String cm_id);

}
