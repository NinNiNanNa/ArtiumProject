package com.edu.springboot.common;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BookMarkController {
	
	@Autowired
	IBookMarkService dao;
	
	// 북마크 표시
	@RequestMapping("/bookmarkList.api")
	@ResponseBody
	public Map<String, Object> bookmarkList(BookMarkDTO bookMarkDTO, HttpServletRequest req) {
		Map<String, Object> maps = new HashMap<>();
		String userId = req.getParameter("user_id");
		String postType = req.getParameter("post_type");
		
//		System.out.println("아이디?: "+userId);
//		System.out.println("ajax게시글유형?: "+postType);
//		System.out.println("요건?: "+bookMarkDTO);
		if(userId != null) {
			ArrayList<BookMarkDTO> bmlists = dao.getBookMark(bookMarkDTO);
			
			maps.put("bmlists", bmlists);
//			System.out.println("???"+bmlists);
		}

		return maps;
	}
	
	// 북마크 추가
	@PostMapping("/bookmarkAdd.api")
	@ResponseBody
	public Map<String, Object> bookmarkAdd(@RequestBody BookMarkDTO bookMarkDTO) {
		Map<String, Object> maps = new HashMap<>();
	    
	    System.out.println("(추가)뭐가나오냐?"+bookMarkDTO.getBm_id());
	    
	    int result = dao.addBookMark(bookMarkDTO);
	    
	    System.out.println("(추가)뭐가나오냐?"+bookMarkDTO.getBm_id());
	    maps.put("result", result);
		
		return maps;
	}

	
	// 북마크 삭제
	@PostMapping("/bookmarkRemove.api")
	@ResponseBody
	public Map<String, Object> bookmarkRemove(@RequestBody Map<String, String> requestBody) {
	    Map<String, Object> maps = new HashMap<>();
	    
	    String bmId = requestBody.get("bm_id");
	    System.out.println("(삭제)북마크일련번호: " + bmId);

	    int result = dao.removeBookMark(bmId);
	    maps.put("result", result);
	    System.out.println("삭제 : " + maps);

	    return maps;
	}

}
