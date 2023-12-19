package com.edu.springboot.common;

import lombok.Data;

@Data
public class BookMarkDTO {
	private String bm_id;			// 북마크 일련번호
	private String user_id;		// 북마크한 유저 아이디
	private String post_id;		// 북마크한 게시글일련번호
	private String post_type;	// 게시글 유형
}
