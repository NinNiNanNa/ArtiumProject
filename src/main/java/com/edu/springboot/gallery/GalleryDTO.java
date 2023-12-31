package com.edu.springboot.gallery;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GalleryDTO {

	private String ga_id;				// 작가 갤러리 일련번호
	private String user_id;				// 회원 ID
	private String ga_title;			// 갤러리 제목
	private String ga_type;				// 작품 타입
	private Date ga_sdate;				// 갤러리 시작일
	private Date ga_edate;				// 갤러리 마감일
	private String ga_content;			// 갤러리 내용
	private java.sql.Date ga_postdate;	// 작성일
	private int ga_visitcount;			// 조회수
	private int ga_bmcount;				// 북마크수
	private Object art_image1;
	private String art_title1;
	private String art_date1;
	private String art_content1;
	private Object art_image2;
	private String art_title2;
	private String art_date2;
	private String art_content2;
	private Object art_image3;
	private String art_title3;
	private String art_date3;
	private String art_content3;
	private Object art_image4;
	private String art_title4;
	private String art_date4;
	private String art_content4;
	private Object art_image5;
	private String art_title5;
	private String art_date5;
	private String art_content5;
	
	private String num;
	private String pageNum;
	private String searchField;
	private String searchOption;
	private String searchKeyword;
	private int start;
	private int end;
	
	private String user_name;
	private String user_image;
}

