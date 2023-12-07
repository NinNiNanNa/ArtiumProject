package com.edu.springboot.jdbc;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MateDTO {
	private int mt_id;
	private String mt_title;
	private String mt_location;
	private LocalDate mt_viewdate;
	private int mt_visitcount;
	private int mt_bmcount; 
	private String mt_status;
	private String mt_gender;
	private String mt_age;
	private String mt_content;
}
