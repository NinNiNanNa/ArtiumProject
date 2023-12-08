package com.edu.springboot.review;

import lombok.Data;
	
@Data
public class ReviewDTO {
	private String rv_id;
	private String rv_title;
	private java.sql.Date rv_date;
	private String rv_stime;
	private String rv_etime;
	private String rv_congestion;
	private String rv_transportation;
	private String rv_revisit;
	private String rv_image;
	private String rv_content;
	private java.sql.Date rv_postdate;
	private int rv_visitcount;
	private int rv_bmcount;
}
