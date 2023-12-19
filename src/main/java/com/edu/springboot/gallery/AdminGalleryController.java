package com.edu.springboot.gallery;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

/* 관리자 */
@Controller
public class AdminGalleryController {

	// DAO호출을 위한 빈 자동주입. 이 인터페이스를 통해 Mapper 호출
	@Autowired
	IAdminGalleryService dao;
	
	// 작가 갤러리 리스트 관리
	@GetMapping("/admin/gaList")
	public String gaList(Model model, HttpServletRequest req, GalleryDTO galleryDTO) {
		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장
		int totalCount = dao.getTotalCount(galleryDTO);
		
		// 페이징을 위한 설정값
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		// 현재 페이지에 출력한 게시물의 구간 계산
		int start = (pageNum-1) * pageSize +1;
		int end = pageNum * pageSize;
		
		// 계산된 값 DTO에 저장
		galleryDTO.setStart(start);
		galleryDTO.setEnd(end);
		
		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		// 데이터베이스에서 인출한 게시물의 목록을 Model객체에 저장
		ArrayList<GalleryDTO> gaList = dao.listPage(galleryDTO);
		
		model.addAttribute("gaList", gaList);
		
//				System.out.println("뀨: "+galleryList);
		
		// 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/gaList?");
		model.addAttribute("pagingImg", pagingImg);
		
//				System.out.println(galleryDTO);
		return "/admin/gaList";
	}
	
	// 삭제하기
	@PostMapping("/admin/gaList")
	public String galleryAdminDelete(HttpServletRequest req, Model model) {
		int result = dao.delete(req.getParameter("ga_id"));
		System.out.println("글삭제결과: "+ result);

		return "redirect:/admin/gaList";
	}
	
//	@PostMapping(value="/admin/gaList/delete", method=RequestMethod.POST)
//	public String galleryAdminDelete(HttpServletRequest req, Model model) {
//		int result = dao.delete(req.getParameter("ga_id"));
//		System.out.println("글삭제결과: "+ result);
//
//		return "redirect:/admin/gaList";
//	}
		
/************************************************************************************************************************************/	
	
	// 작가갤러리 댓글 목록
	@RequestMapping("/admin/gaComments")
	@ResponseBody
	public Map<String, Object> listGalleryComment(HttpServletRequest req, GalleryDTO galleryDTO) {
//			HttpSession session = req.getSession();
//			String gaid = (String)session.getAttribute("ga_id");
		String gaid = req.getParameter("ga_id");
		galleryDTO.setGa_id(gaid);
		System.out.println("이유가 뭐야: "+ gaid);
		
		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장)
		int totalCount = dao.getGalleryComment(galleryDTO);
		System.out.println("왜 안되는거야: "+ totalCount);
		
		// 페이징을 위한 설정값(하드코딩)
		int pageSize = 10;		// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		
		// 목록에 첫 진입시에는 페이지 번호가 없으므로 무조건 1로 설정, 파라미터로 전달된 페이지 번호가 있다면 받은 후 정수로 변경해서 설정
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		//현재 페이지에 출력한 게시물의 구간 계산
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		
		// 계산된 값 DTO에 저장
		galleryDTO.setStart(start);
		galleryDTO.setEnd(end);
		
		ArrayList<GalleryCommentDTO> lists = dao.listGalleryComment(galleryDTO);
		
		System.out.println(lists);
		
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/galleryView?ga_id="+gaid+"&");
		
		// View 게시물의 가상번호 계산을 위한 값을 Map에 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		maps.put("lists", lists);
		maps.put("pagingImg", pagingImg);
		
		System.out.println("댓글 목록 나오나요?: "+maps);
		
		return maps;
	}
	
	// 갤러리 댓글 삭제
//	@PostMapping("/admin/gaCommentsDelete")
//	@ResponseBody
//	public Map<String, Object> restGalleryCommentDelete(HttpServletRequest req) {
//	    Map<String, Object> maps = new HashMap<>();
	    
//	    int result = dao.deleteGalleryComment(req.getParameter("cm_id"));
//	    maps.put("result", result);
//		    System.out.println("한줄평삭제: "+ maps);
	    
//	    return maps;
//	}

	
}
