package com.edu.springboot.gallery;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GalleryDTO {

	private String ga_id;				// 작가 갤러리 일련번호
	private String user_id;				// 회원 ID
	private String ga_title;			// 갤러리 제목
	private Date ga_sdate;			// 갤러리 시작일
	private Date ga_edate;			// 갤러리 마감일
	private String ga_content;			// 갤러리 내용
	private java.sql.Date ga_postdate;	// 작성일
	private int ga_visitcount;		// 조회수
	private int ga_bmcount;			// 북마크수
//	private MultipartFile art_image1;
	private Object art_image1;
	private String art_title1;
	private String art_content1;
//	private MultipartFile art_image2;
	private Object art_image2;
	private String art_title2;
	private String art_content2;
//	private MultipartFile art_image3;
	private Object art_image3;
	private String art_title3;
	private String art_content3;
//	private MultipartFile art_image4;
	private Object art_image4;
	private String art_title4;
	private String art_content4;
//	private MultipartFile art_image5;
	private Object art_image5;
	private String art_title5;
	private String art_content5;
	
//	// getArt_image getter/setter 
//	public MultipartFile getArt_image1() {
//	    return art_image1;
//	}
//	public void setArt_image1(MultipartFile art_image1) {
//		this.art_image1 = art_image1;
//	}
//	
//	public MultipartFile getArt_image2() {
//	    return art_image2;
//	}
//	public void setArt_image2(MultipartFile art_image2) {
//	    this.art_image2 = art_image2;
//	}
//
//	public MultipartFile getArt_image3() {
//	    return art_image3;
//	}
//	public void setArt_image3(MultipartFile art_image3) {
//	    this.art_image3 = art_image3;
//	}
//	
//	public MultipartFile getArt_image4() {
//	    return art_image4;
//	}
//	public void setArt_image4(MultipartFile art_image4) {
//	    this.art_image4= art_image4;
//	}
//	
//	public MultipartFile getArt_image5() {
//	    return art_image5;
//	}
//	public void setArt_image5(MultipartFile art_image5) {
//	    this.art_image5 = art_image5;
//	}
	
}

