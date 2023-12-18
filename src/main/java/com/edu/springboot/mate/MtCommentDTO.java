package com.edu.springboot.mate;

import java.sql.Date;

import lombok.Data;

@Data
public class MtCommentDTO {
	private int mtcom_id;
	private String mt_id;
	private String user_id;
	private String mtcom_content;
	private Date mtcom_postdate;
	
	private String user_name;
	private String user_image;
	
	
}