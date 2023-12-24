package com.edu.springboot.gallery;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminGalleryService {

	// Paging처리를 위한 게시물의 갯수 카운트
	public int getTotalCount(GalleryDTO galleryDTO);
	
	// 게시판 목록 (페이징 기능 추가)
	public ArrayList<GalleryDTO> listPage(GalleryDTO galleryDTO);
	
	// 상세보기
	public GalleryDTO view(GalleryDTO galleryDTO);
	
	// 온라인 갤러리
	public GalleryDTO onlineGallery(GalleryDTO galleryDTO);
	
	// 삭제하기
	public int delete(String ga_id);
	
	// 조회수 올리기
	public int visitCount(String ga_id);
	
	// 북마크 올리기
	public int bomcount(String ga_id);
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 갤러리 댓글 목록 Paging처리를 위해 게시물의 갯수 카운트
	public int getGalleryComment(GalleryDTO galleryDTO);
	
	// 갤러리 댓글 목록 조회
    public ArrayList<GalleryCommentDTO> listGalleryComment(GalleryDTO galleryDTO);

    // 갤러리 댓글 검색
    public List<GalleryCommentDTO> galleryCmSearch(GalleryCommentDTO galleryCommentDTO);
    
    // 갤러리 댓글 내용
    public GalleryCommentDTO viewGalleryComments(GalleryCommentDTO galleryCommentDTO);    
  	
    // 갤러리 댓글 삭제
	public int deleteGalleryComment(String cm_id);
		
}
