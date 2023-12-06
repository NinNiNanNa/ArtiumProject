package com.edu.springboot.jdbc;

import java.sql.Date;

import lombok.Data;

@Data
public class ExhibitionDTO {
	private String ex_seq;
	private String ex_title;
	private String ex_place;
	private Date ex_sDate;
	private Date ex_eDate;
	private String ex_area;
	private String ex_subTitle;
	private String ex_price;
	private String ex_content;
	private String ex_phone;
	private String ex_imgURL;
	private String ex_gpsX;
	private String ex_gpsY;
	private String ex_addr;
	private String ex_webURL;
	private int ex_visitCount;
	private int ex_bmCount;
}
