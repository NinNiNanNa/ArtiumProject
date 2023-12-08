package com.edu.springboot.review;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.jdbc.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import utils.MyFunctions;
import utils.PagingUtil;

@Controller
public class ReviewController {
	// DAO호출을 위한 빈 자동주입. 이 인터페이스를 통해 Mapper를 호출한다.
	@Autowired
	IReviewService dao; 
	// 리뷰 목록
	@RequestMapping("/reviewList") 
	//매개변수는 View로 전달할 데이터를 저장하기 위한 Model객체와 요청을 받아 처리하기위한 requset내장객체, DTO객체를 추가한다.
	public String reviewList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) { 
		// 게시물의 갯수를 카운트(검색어가 있는경우 DTO객체에 자동으로 저장된다.)
		int totalCount = dao.getTotalCount(parameterDTO); 
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
		
		// 데이터베이스에서 인출한 게시물의 목록을 Model객체에 저장한다.
		ArrayList<ReviewDTO> lists = dao.listPage(parameterDTO);
		model.addAttribute("lists", lists);
		
		// 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장한다.
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/reviewList?list=?");
		model.addAttribute("pagingImg", pagingImg);
		
		// View로 포워드한다.
		return "/review/list";
	}
	
	// 상페보기 페이지
	@RequestMapping("/reviewView")
	public String reviewView(Model model, ReviewDTO reviewDTO) {
		reviewDTO = dao.view(reviewDTO);
		reviewDTO.setRv_content(reviewDTO.getRv_content().replace("\r\n", "<br>"));
		model.addAttribute("reviewDTO", reviewDTO);
		System.out.println("reviewDTO"+ reviewDTO);
		return "/review/view";
	}
	
	// 글쓰기 페이지 로딩
	@GetMapping("/reviewWrite")
	public String reviewWriteGet(Model model) {
		return "/review/write";
	}
	// 글쓰기 처리
	@PostMapping("/reviewWrite")
	public String reviewWritePost(Model model, HttpServletRequest req, ReviewDTO reviewDTO) {
		try {
			//물리적 경로 얻어오기 
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			System.out.println("물리적경로:"+uploadDir);
			/* 파일명 저장을 위한 Set 생성. value는 서버에 저장된 파일명을 저장한다. */
			Set<String> saveFileSets = new HashSet<>();
			//2개 이상의 파일이므로 getParts() 메서드를 통해 폼값을 받는다. 
			Collection<Part> parts = req.getParts();
			//폼값의 갯수만큼 반복 
			for(Part part : parts) {
				/* 폼값 중 파일인 경우에만 업로드 처리를 위해 continue를 걸어준다. 즉 파일이 아니라면 for문의 처음으로 돌아간다. */
				if(!part.getName().equals("rvUpload"))
					continue;
				//파일명 추출을 위해 헤더값을 얻어온다.
		        String partHeader = part.getHeader("content-disposition");
		        System.out.println("partHeader="+ partHeader);
		        //파일명을 추출한 후 따옴표를 제거한다. 
		        String[] phArr = partHeader.split("filename=");
		        String originalFileName = phArr[1].trim().replace("\"", "");
		        //파일을 원본파일명으로 저장한다. 
				if (!originalFileName.isEmpty()) {				
					part.write(uploadDir+ File.separator +originalFileName);
				}
				//저장된 파일을 UUID로 생성한 새로운 파일명으로 저장한다. 
				String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
				/* Map컬렉션에 원본파일명과 저장된파일명을 key와 value로 저장한다.*/
				saveFileSets.add(savedFileName);
			}
			//View로 전달하기 위해 Model객체에 저장한다. (일단 혹시몰라서 그대로 두는중)
		    model.addAttribute("saveFileSets", saveFileSets);
		    //View로 전달하기 위해 DTO객체에 문자열타입으로 저장한다. 
		    reviewDTO.setRv_image(saveFileSets.toString());
		}
		catch (Exception e) {			
			System.out.println("업로드 실패");
			e.printStackTrace();
		}
		/* request 내장객체를 통해 폼값을 받아온다. DTO에 저장된 첨부파일의 값을 받아온다. */
		String rv_title = req.getParameter("rv_title");
		String rv_date = req.getParameter("rv_date");
		String rv_stime = req.getParameter("rv_stime");
		String rv_etime = req.getParameter("rv_etime");
		String rv_congestion = req.getParameter("rv_congestion");
		String rv_transportation = req.getParameter("rv_transportation");
		String rv_revisit = req.getParameter("rv_revisit");
		String rv_image = reviewDTO.getRv_image();
		String rv_content = req.getParameter("rv_content");
		// 폼값을 개별적으로 전달한다.
		int result = dao.write(rv_title, rv_date, rv_stime, rv_etime, rv_congestion, rv_transportation, rv_revisit, rv_image, rv_content);
		System.out.println("글쓰기결과:"+ result);
		// 글쓰기가 완료되면 목록으로 이동한다.
		return "redirect:/reviewList";
	}
}