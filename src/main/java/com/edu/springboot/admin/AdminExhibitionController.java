package com.edu.springboot.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.exhibition.ExhibitionDTO;
import com.edu.springboot.exhibition.ParameterDTO;
import com.edu.springboot.exhibition.SimpleReviewDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class AdminExhibitionController {
	
	@Autowired
	IAdminExhibitionService dao;
	
	// 전시 목록을 보여주는 메서드
	private String listExhibitions(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		int status = parameterDTO.getStatus();
		
		// 각 리스트에 대한 총 게시물 수 계산
		int totalCount = dao.getTotalCount(parameterDTO);
		//System.out.println("totalCount="+ totalCount);
		
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals("")) 
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		// 페이징 정보를 모델에 추가
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		//System.out.println("maps="+ maps);
		
		// 전시 목록을 가져와 모델에 추가
		ArrayList<ExhibitionDTO> lists = dao.listPage(parameterDTO);
		model.addAttribute("lists", lists);
		//System.out.println("lists="+ lists);
		
		String mappingName = "";
    	if (status == 1) {
    		mappingName = "/admin/exhibitionCurrentList?";
    	} else if (status == 2) {
    		mappingName = "/admin/exhibitionFutureList?";
    	} else {
    		mappingName = "/admin/exhibitionPastList?";
    	}
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+mappingName);
		model.addAttribute("pagingImg", pagingImg);
		
		return "/admin/exList";
	}
	
	// 현재전시
	@RequestMapping("/admin/exhibitionCurrentList")
	public String currentExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		parameterDTO.setStatus(1);
		return listExhibitions(model, req, parameterDTO);
	}
	// 예정전시
	@RequestMapping("/admin/exhibitionFutureList")
	public String futureExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		parameterDTO.setStatus(2);
		return listExhibitions(model, req, parameterDTO);
	}
	// 만료전시
	@RequestMapping("/admin/exhibitionPastList")
	public String pastExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		parameterDTO.setStatus(3);
		return listExhibitions(model, req, parameterDTO);
	}
	
	
	// 한줄평 목록
	@RequestMapping("/admin/exhibitionComments")
	public String simpleReviewList(HttpServletRequest req, ParameterDTO parameterDTO, Model model) {
		
		// 각 리스트에 대한 총 게시물 수 계산
		int totalCount = dao.getSimpleReviewCount(parameterDTO);
//		System.out.println("totalCount="+ totalCount);
		
		int pageSize = 10;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals("")) 
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다.
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
//		System.out.println("맵: "+maps);
		
		ArrayList<SimpleReviewDTO> srvLists = dao.listSimpleReview(parameterDTO);
		model.addAttribute("srvLists", srvLists);
//		System.out.println("한줄평 목록: "+srvLists);
		
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/admin/exhibitionComments?");
		model.addAttribute("pagingImg", pagingImg);
		
		return "/admin/exComments";
	}
	
	// 한줄평 삭제
	@PostMapping("/adminExhibitionReviewDelete")
	public String restSimpleReviewDelete(HttpServletRequest req) {
		System.out.println("삭제 나오나?"+req.getParameter("srv_id"));
	    int result = dao.deleteSimpleReview(req.getParameter("srv_id"));
	    System.out.println("한줄평삭제: "+ result);
	    
	    return "redirect:/admin/exhibitionComments";
	}

}
