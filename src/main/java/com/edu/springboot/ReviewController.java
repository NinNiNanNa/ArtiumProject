package com.edu.springboot;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.jdbc.IReviewService;
import com.edu.springboot.jdbc.ParameterDTO;
import com.edu.springboot.jdbc.ReviewDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import utils.MyFunctions;
import utils.PagingUtil;

@Controller
public class ReviewController {
	
	@Autowired
	IReviewService dao;

	@RequestMapping("/reviewList")
	public String reviewList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		int totalCount = dao.getTotalCount(parameterDTO);
		int pageSize = 12;
		int blockPage = 5;
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))	
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		ArrayList<ReviewDTO> lists = dao.listPage(parameterDTO);
		model.addAttribute("lists", lists);
		
		//게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Modle객체에 저장한다.
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/reviewList?list=?");
		model.addAttribute("pagingImg", pagingImg);
		
		return "/review/list";
	}
	
	@RequestMapping("/reviewView")
	public String reviewView(Model model, ReviewDTO reviewDTO) {
		reviewDTO = dao.view(reviewDTO);
		reviewDTO.setRv_content(reviewDTO.getRv_content().replace("\r\n", "<br>"));
		model.addAttribute("reviewDTO", reviewDTO);
		System.out.println("reviewDTO"+ reviewDTO);
		return "/review/view";
	}
	
	@GetMapping("/reviewWrite")
	public String reviewWriteGet(Model model) {
		return "/review/write";
	}
	@PostMapping("/reviewWrite")
	public String reviewWritePost(Model model, HttpServletRequest req, ReviewDTO reviewDTO) {
		try {			
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			System.out.println("물리적경로:"+uploadDir);
			
			Map<String, String> saveFileMaps = new HashMap<>();
			Collection<Part> parts = req.getParts();
			for(Part part : parts) {
				if(!part.getName().equals("rvUpload"))
					continue;
				
		        String partHeader = part.getHeader("content-disposition");
		        System.out.println("partHeader="+ partHeader);
		        String[] phArr = partHeader.split("filename=");
		        String originalFileName = phArr[1].trim().replace("\"", "");
				if (!originalFileName.isEmpty()) {				
					part.write(uploadDir+ File.separator +originalFileName);
				}
				String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
				saveFileMaps.put(originalFileName, savedFileName);
			}
		    model.addAttribute("saveFileMaps", saveFileMaps);
		    reviewDTO.setRv_image(saveFileMaps.toString());
		}
		catch (Exception e) {			
			System.out.println("업로드 실패");
			e.printStackTrace();
		}
		String rv_title = req.getParameter("rv_title");
		String rv_date = req.getParameter("rv_date");
		String rv_stime = req.getParameter("rv_stime");
		String rv_etime = req.getParameter("rv_etime");
		String rv_congestion = req.getParameter("rv_congestion");
		String rv_transportation = req.getParameter("rv_transportation");
		String rv_revisit = req.getParameter("rv_revisit");
		String rv_image = reviewDTO.getRv_image();
		String rv_content = req.getParameter("rv_content");
		int result = dao.write(rv_title, rv_date, rv_stime, rv_etime, rv_congestion, rv_transportation, rv_revisit, rv_image, rv_content);
		System.out.println("글쓰기결과:"+ result);
		return "redirect:/reviewList";
	}
}
