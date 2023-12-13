package com.edu.springboot.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
public class BookMarkController {
	
	@Autowired
	IBookMarkService dao;
	
	@GetMapping("/bookmark.api")
	public int bookmark(HttpServletRequest req, BookMarkDTO bookMarkDTO, HttpSession session) {
		int result = 0;
		System.out.println(dao.viewBM(bookMarkDTO).getUser_id());
		System.out.println(dao.viewBM(bookMarkDTO).getEx_seq());
		try {
			String userId = (String) session.getAttribute("userId");
			System.out.println("서버유저아이디"+userId);
			if(userId != null) {
				bookMarkDTO = dao.viewBM(bookMarkDTO);
				System.out.println("DB불러라: "+bookMarkDTO);
				if(bookMarkDTO != null) {
					System.out.println("북마크일련번호: "+bookMarkDTO.getBm_id());
					result = dao.deleteBM(bookMarkDTO.getBm_id());
				}
				else {
					result = dao.insertBM(userId, bookMarkDTO.getEx_seq());
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("실패애애애애");
		}
		return result;
	}

}
