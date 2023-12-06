package com.edu.springboot;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.jdbc.ExhibitionDTO;
import com.edu.springboot.jdbc.IExhibitionService;
import com.edu.springboot.jdbc.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class ExhibitionController {
	
	@Autowired
	IExhibitionService dao;
	
	// 구글 지도 api
	private static final String apiKey = "AIzaSyB1oZppzwBJjVNHpCaL49H98eNEUcO3K_k";
	
	// 현재전시 목록
	@RequestMapping("/exhibitionCurrentList")
	public String currentExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		// 각 리스트에 대한 총 게시물 수 계산
		int totalCount1 = dao.getTotalCount_1(parameterDTO);
//		System.out.println("totalCount1="+ totalCount1);
		
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals("")) 
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount1", totalCount1);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
//		System.out.println("maps="+ maps);
		
		ArrayList<ExhibitionDTO> lists1 = dao.listPage_1(parameterDTO);
		model.addAttribute("lists1", lists1);
//		System.out.println("lists1="+ lists1);
		
		String pagingImg1 = PagingUtil.pagingImg(totalCount1, pageSize, blockPage, pageNum, req.getContextPath()+"/exhibitionCurrentList?");
		model.addAttribute("pagingImg1", pagingImg1);
		
		return "/exhibition/list";
	}
	// 예정전시 목록
	@RequestMapping("/exhibitionFutureList")
	public String futureExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		// 각 리스트에 대한 총 게시물 수 계산
		int totalCount2 = dao.getTotalCount_2(parameterDTO);
//			System.out.println("totalCount2="+ totalCount2);
		
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals("")) 
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount2", totalCount2);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
//		System.out.println("maps="+ maps);
		
		ArrayList<ExhibitionDTO> lists2 = dao.listPage_2(parameterDTO);
		model.addAttribute("lists2", lists2);
//			System.out.println("lists2="+ lists2);
		
		String pagingImg2 = PagingUtil.pagingImg(totalCount2, pageSize, blockPage, pageNum, req.getContextPath()+"/exhibitionFutureList?");
		model.addAttribute("pagingImg2", pagingImg2);
		
		return "/exhibition/list";
	}
	// 만료전시 목록
	@RequestMapping("/exhibitionPastList")
	public String pastExList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		// 각 리스트에 대한 총 게시물 수 계산
		int totalCount3 = dao.getTotalCount_3(parameterDTO);
//		System.out.println("totalCount3="+ totalCount3);
		
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals("")) 
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount3", totalCount3);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
//		System.out.println("maps="+ maps);
		
		ArrayList<ExhibitionDTO> lists3 = dao.listPage_3(parameterDTO);
		model.addAttribute("lists3", lists3);
//		System.out.println("lists3="+ lists3);
		
		String pagingImg3 = PagingUtil.pagingImg(totalCount3, pageSize, blockPage, pageNum, req.getContextPath()+"/exhibitionPastList?");
		model.addAttribute("pagingImg3", pagingImg3);
		
		return "/exhibition/list";
	}
	
	@RequestMapping("/exhibitionView")
	public String exhibitionView(Model model, ExhibitionDTO exhibitionDTO) {
		dao.visitCount(exhibitionDTO.getEx_seq());
		exhibitionDTO = dao.view(exhibitionDTO);
		model.addAttribute("exhibitionDTO", exhibitionDTO);
//		System.out.println("exhibitionDTO"+ exhibitionDTO);
		model.addAttribute("apiKey", apiKey);
		return "/exhibition/view";
	}
	@GetMapping("/exhibitionWrite")
	public String exhibitionWrite() {
		return "/exhibition/write";
	}

}
