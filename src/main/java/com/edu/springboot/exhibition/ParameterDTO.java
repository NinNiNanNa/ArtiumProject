package com.edu.springboot.exhibition;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ParameterDTO {
	private String num;
	private String pageNum;
	private String searchField;
	private String searchKeyword;
	private int start;
	private int end;
	// 전시상태를 구분
	private int status;
}
