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
	public int bookmark(HttpServletRequest req, BookMarkDTO bookMarkDTO) {
		int result = 0;
		String userId = req.getParameter("user_id");
		String exSeq = req.getParameter("ex_seq");
		System.out.println("아이디불러옴? :"+userId);
		System.out.println("전시회불러옴? :"+exSeq);
		try {
		    if (userId != null) {
		        if (bookMarkDTO.getEx_seq() != null) {
		            BookMarkDTO resultDTO = dao.viewBM(bookMarkDTO);
		            if (resultDTO != null) {
		                bookMarkDTO = resultDTO;
		                System.out.println("아이디 O 전시회 O :" + resultDTO);
		            }
		        } else {
		            BookMarkDTO resultDTO = dao.insertBM(userId, exSeq);
		            if (resultDTO != null) {
		                bookMarkDTO = resultDTO;
		                System.out.println("아이디 O 전시회 X :" + resultDTO);
		            }
		        }
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		    System.out.println("실패애애애애");
		}
		return result;
	}
	
//	@GetMapping("/bookmark.api")
//	public int bookmark(HttpServletRequest req, BookMarkDTO bookMarkDTO) {
//		int result = 0;
//		String userId = req.getParameter("user_id");
//		String exSeq = req.getParameter("ex_seq");
//		System.out.println("아이디불러옴? :"+userId);
//		System.out.println("전시회불러옴? :"+exSeq);
//		try {
//			if(userId != null) {
//				int inUserId = bookMarkDTO.setUser_id(userId);
//				int inExSeq = bookMarkDTO.setEx_seq(exSeq);
//				if(bookMarkDTO.getEx_seq() != null) {
//					bookMarkDTO = dao.viewBM(bookMarkDTO);
//					System.out.println("아이디 O 전시회 O :"+dao.viewBM(bookMarkDTO));
//				}
//				else if(bookMarkDTO.getEx_seq() == null){
//					String inUserId = bookMarkDTO.setUser_id(userId);
//					String inExSeq = bookMarkDTO.setEx_seq(exSeq);
//					bookMarkDTO = dao.insertBM(userId, exSeq);
//					System.out.println("아이디 O 전시회 X :"+bookMarkDTO);
//				}
//				bookMarkDTO = dao.viewBM(bookMarkDTO);
//				bookMarkDTO = dao.viewBM(bookMarkDTO);
//				System.out.println("DB불러라: "+bookMarkDTO);
//				if(bookMarkDTO.getEx_seq() != null) {
//					System.out.println("북마크일련번호: "+bookMarkDTO.getBm_id());
//					result = dao.deleteBM(bookMarkDTO.getBm_id());
//				}
//				else {
//					result = dao.insertBM(userId, bookMarkDTO.getEx_seq());
//				}
//			}
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("실패애애애애");
//		}
//		System.out.println("결과: "+result);
//		return result;
//	}

}
