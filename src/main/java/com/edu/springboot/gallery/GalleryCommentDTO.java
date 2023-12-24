package com.edu.springboot.gallery;

import java.sql.Date;

import lombok.Data;


@Data
public class GalleryCommentDTO {
	private int cm_id;
    private String cm_content;
    private Date cm_postdate;
    private String ga_id;
    private String user_id;
    
    private String num;
	private String pageNum;
	private String searchField;
	private String searchKeyword;
	private String searchOption;
	private String keyword;
	private int start;
	private int end;
    
    private String user_name;
	private String user_image;

}
