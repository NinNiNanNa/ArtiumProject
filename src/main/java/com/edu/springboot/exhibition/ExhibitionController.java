package com.edu.springboot.exhibition;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class ExhibitionController {
	
	@Autowired
	IExhibitionService dao;
	
	@Autowired
	IMemberService daoMember;
	
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
	public String exhibitionView(Model model, HttpServletRequest req, ExhibitionDTO exhibitionDTO) {
		 String exSeq = exhibitionDTO.getEx_seq();
	    HttpSession session = req.getSession();
	    session.setAttribute("ex_seq", exSeq);
		
		dao.visitCount(exhibitionDTO.getEx_seq());
		exhibitionDTO = dao.view(exhibitionDTO);
		model.addAttribute("exhibitionDTO", exhibitionDTO);
		//System.out.println("exhibitionDTO"+ exhibitionDTO);
		model.addAttribute("apiKey", apiKey);
		return "/exhibition/view";
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping("/exhibitionReviewList.api")
	@ResponseBody
	public Map<String, Object> simpleReviewList(HttpServletRequest req, ParameterDTO parameterDTO) {
		HttpSession session = req.getSession();
		String exSeq = (String) session.getAttribute("ex_seq");
		parameterDTO.setEx_seq(exSeq);
//		System.out.println(exSeq);
		
		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장된다.)
		int totalCount = dao.getSimpleReviewCount(parameterDTO);
		// 페이징을 위한 설정값(하드코딩)
		int pageSize = 10;		// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		/*
		목록에 첫 진입시에는 페이지 번호가 없으므로 무조건 1로 설정하고,
		파라미터로 전달된 페이지 번호가 있다면 받은 후 정수로 변경해서 설정한다.
		*/
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		// 현재 페이지에 출력한 게시물의 구간을 계산한다.
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		// 계산된 값은 DTO에 저장한다.
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		ArrayList<SimpleReviewDTO> lists = dao.listSimpleReview(parameterDTO);
		
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/exhibitionView?ex_seq="+exSeq+"&");
		
		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다.
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		maps.put("lists", lists);
		maps.put("pagingImg", pagingImg);
		
		System.out.println("맵이다"+maps);
		
		return maps;
	}
	
	
//	@RequestMapping("/exhibitionReviewList.api")
//	@ResponseBody
//	public Map<String, Object> simpleReviewList(HttpServletRequest req, ParameterDTO parameterDTO) {
//		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장된다.)
//		int totalCount = dao.getSimpleReviewCount(parameterDTO);
//		int pageSize = 10;
//		int pageNum = parameterDTO.getPageNum() == null ? 1 : Integer.parseInt(parameterDTO.getPageNum());
//		int start = (pageNum - 1) * pageSize + 1;
//		int end = pageNum * pageSize;
//		parameterDTO.setStart(start);
//		parameterDTO.setEnd(end);
//		
//		ArrayList<SimpleReviewDTO> lists = dao.listSimpleReview(parameterDTO);
//		
//		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다.
//		Map<String, Object> maps = new HashMap<String, Object>();
//		maps.put("totalCount", totalCount);
//		maps.put("pageSize", pageSize);
//		maps.put("pageNum", pageNum);
//		maps.put("lists", lists);
//		
//		return maps;
//	}
	
	@GetMapping("/restBoardView.do")
	@ResponseBody
	public SimpleReviewDTO restSimpleReviewView(Model model, SimpleReviewDTO simpleReviewDTO){
		
		simpleReviewDTO = dao.viewSimpleReview(simpleReviewDTO);
		model.addAttribute("simpleReviewDTO"+ simpleReviewDTO);
		
		System.out.println("호잇!"+simpleReviewDTO);
		return simpleReviewDTO;
	}
	
	
	@PostMapping("/exhibitionReviewWrite.api")
	public String restSimpleReviewWrite(HttpServletRequest req, SimpleReviewDTO simpleReviewDTO) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("userId");
		simpleReviewDTO.setUser_id(id);
		
		// Exhibition의 일련번호(ex_seq)를 SimpleReviewDTO에 설정
		String exhibitionSeq = req.getParameter("ex_seq");
		simpleReviewDTO.setEx_seq(exhibitionSeq);
		
//	    System.out.println("평점: " + simpleReviewDTO.getSrv_star());
//	    System.out.println("일련번호: " + simpleReviewDTO.getEx_seq());
//	    System.out.println("아이디: " + simpleReviewDTO.getUser_id());

		int result = dao.writeSimpleReview(simpleReviewDTO);
//		Map<String, Integer> map = new HashMap<>();
//		map.put("result", result);
		return "redirect:exhibitionView?ex_seq="+exhibitionSeq;
	}
	
}
