package com.edu.springboot.gallery;

import lombok.Data;


@Data
public class GalleryCommentDTO {
	private int cm_id;
    private String cm_content;
    private java.sql.Date cm_postdate;
    private String rv_id;
    private String mt_id;
    private String ga_id;
    private String user_id;
    
    private String user_name;
	private String user_image;
}
