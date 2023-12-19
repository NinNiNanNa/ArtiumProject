package com.edu.springboot.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class AdminReviewController {
	@Autowired
	IAdminReviewService dao; 
	
	// 리뷰 목록
	@RequestMapping("/admin/rvList") 
	public String rvList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) { 
		// 리스트에 대한 총 게시물 수 계산
		int totalCount = dao.getTotalCount(parameterDTO); 
		System.out.println("totalCount="+ totalCount);
		// 한 페이지당 게시물 수
		int pageSize = 12; 
		// 한 블럭당 페이지번호 수
		int blockPage = 5;
		//목록에 첫진입시에는 페이지 번호가 없으므로 무조건 1로 설정하고, 파라미터로 전달된 페이지 번호가 있다면 받은 후 변경해서 설정한다.
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))	
				? 1 : Integer.parseInt(req.getParameter("pageNum")); 
		// 현재 페이지에 출력한 게시물의 구간을 계산한다.
		int start = (pageNum-1) * pageSize + 1; 
		int end = pageNum * pageSize;
		// 계산된 값은 DTO에 저장한다.
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		// View에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다.
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		System.out.println("maps="+ maps);
		
		// 데이터베이스에서 인출한 게시물의 목록을 생성
		ArrayList<ReviewDTO> lists = dao.listPage(parameterDTO);
		// 게시물 목록마다 데이터베이스에서 이미지파일의 파일명을 불러와서 저장
		for (ReviewDTO row : lists) {
			Pattern pattern = Pattern.compile("([a-zA-Z0-9]+\\.[a-zA-Z0-9]+)");
			Matcher matcher = pattern.matcher(row.getRv_image());
			while (matcher.find()) {
				String fileNameWithExtension = matcher.group(1);
				row.setRv_image(fileNameWithExtension);
			}
		}
		// 데이터베이스에서 인출한 게시물의 목록을 Model객체에 저장한다.
		model.addAttribute("lists", lists);
		System.out.println("lists="+ lists);
		

		// 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장한다.
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/admin/reviewList?");
		model.addAttribute("pagingImg", pagingImg);
		
		return "/admin/rvList";
	}
	
}
