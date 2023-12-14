package com.edu.springboot.mate;

import java.sql.Date;
import java.time.LocalDate;

import lombok.Data;

@Data
public class MateDTO {
	private String mt_id;
	private String mt_title;
	//private String ex_info;
	private LocalDate mt_viewdate;
	private Date mt_postdate;
	private int mt_visitcount;
	private int mt_bmcount; 
	private String mt_status;
	private String mt_gender;
	private String mt_age1;
	private String mt_age2;
	private String mt_content;
	
	private String user_id;
	private String user_name;
	private String user_image;
	 
	 

	/*
	 * //view를 위한 생성
	 * 
	 * @Override public String toString() { return "MateDTO [mt_id=" + mt_id +
	 * ", mt_title=" + mt_title + ", mt_viewdate=" + mt_viewdate + ", mt_postdate="
	 * + mt_postdate + ", mt_visitcount=" + mt_visitcount + ", mt_bmcount=" +
	 * mt_bmcount + ", mt_status=" + mt_status + ", mt_gender=" + mt_gender +
	 * ", mt_age=" + mt_age + ", mt_content=" + mt_content + "]"; }
	 */
}
