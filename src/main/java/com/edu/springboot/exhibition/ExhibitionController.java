package com.edu.springboot.exhibition;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class ExhibitionController {
	
	@Autowired
	IExhibitionService dao;
	
	// 구글 지도 api
	private static final String apiKey = "AIzaSyB1oZppzwBJjVNHpCaL49H98eNEUcO3K_k";
	
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
    		mappingName = "/exhibitionCurrentList?";
    	} else if (status == 2) {
    		mappingName = "/exhibitionFutureList?";
    	} else {
    		mappingName = "/exhibitionPastList?";
    	}
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+mappingName);
		model.addAttribute("pagingImg", pagingImg);
		
		return "/exhibition/list";
	}
	
	// 현재전시
	@RequestMapping("/exhibitionCurrentList")
	public String currentExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		parameterDTO.setStatus(1);
		return listExhibitions(model, req, parameterDTO);
	}
	// 예정전시
	@RequestMapping("/exhibitionFutureList")
	public String futureExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		parameterDTO.setStatus(2);
		return listExhibitions(model, req, parameterDTO);
	}
	// 만료전시
	@RequestMapping("/exhibitionPastList")
	public String pastExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		parameterDTO.setStatus(3);
		return listExhibitions(model, req, parameterDTO);
	}
	
	// 전시 상세보기
	@RequestMapping("/exhibitionView")
	public String exhibitionView(Model model, ExhibitionDTO exhibitionDTO) {
		dao.visitCount(exhibitionDTO.getEx_seq());
		exhibitionDTO = dao.view(exhibitionDTO);
		model.addAttribute("exhibitionDTO", exhibitionDTO);
		//System.out.println("exhibitionDTO"+ exhibitionDTO);
		model.addAttribute("apiKey", apiKey);
		return "/exhibition/view";
	}
	
}
