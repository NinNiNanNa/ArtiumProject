package com.edu.springboot.review;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewCommentDTO {
	private String rvc_id;
	private String rv_id;
	private String user_id;
	private String rvc_content;
	private Date rvc_postdate;

	private String user_name;
	private String user_image;
}
