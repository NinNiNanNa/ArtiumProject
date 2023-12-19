package com.edu.springboot.member;

import lombok.Data;

//artium계정의 admin 테이블 사용을 위한 DTO클래스
@Data
public class AdminDTO {
	private String admin_id;
	private String admin_pass;
	private String admin_name;
	private String admin_phone;
	private String admin_regidate;
	
	//검색
	private String searchOption;
	private String keyword;

}
