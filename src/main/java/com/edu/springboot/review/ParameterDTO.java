package com.edu.springboot.review;

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
	private String rv_id;
}
