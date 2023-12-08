package com.edu.springboot.exhibition;

import java.sql.Date;

import lombok.Data;

@Data
public class SimpleReviewDTO {
	private String srv_id;
	private String ex_seq;
	private String user_id;
	private String srv_star;
	private String srv_content;
	private Date srv_postdate;
}
