package com.edu.springboot.jdbc;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MateParameterDTO {	
	private String searchField;  
	private String searchKeyword;
	private int start;		 
	private int end;
	public String getSearchField() {
		return searchField;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	} 
	
}




