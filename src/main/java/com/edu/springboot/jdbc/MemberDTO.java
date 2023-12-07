package com.edu.springboot.jdbc;

import lombok.Data;

//artium계정의 members 테이블 사용을 위한 DTO클래스
@Data
public class MemberDTO {
	private String user_id;
	private String user_pass;
	private String user_name;
	private String user_email;
	private String user_gender;
	private String user_image;
	private String user_type;
	private String user_regidate;
}
