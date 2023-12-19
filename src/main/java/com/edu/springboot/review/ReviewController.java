package com.edu.springboot.review;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
		

		// 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장한다.
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/reviewList?");
		model.addAttribute("pagingImg", pagingImg);
		
		// View로 포워드한다.
		return "/review/list";
	}
		
	// 상페보기 페이지
	@RequestMapping("/reviewView")
	public String reviewView(Model model, ReviewDTO reviewDTO) {
		dao.visitCount(reviewDTO.getRv_id());
		reviewDTO = dao.view(reviewDTO);
		reviewDTO.setRv_content(reviewDTO.getRv_content().replace("\r\n", "<br>"));
		String imageFileNamesString = reviewDTO.getRv_image().replaceAll("[\\[\\] ]", "");
		String[] imageFileNames = imageFileNamesString.split(",");
		List<String> imageFileList = Arrays.asList(imageFileNames);
		model.addAttribute("imageFileList", imageFileList);
		model.addAttribute("reviewDTO", reviewDTO);
		return "/review/view";
	}
	
	// 글쓰기 페이지 로딩
	@GetMapping("/reviewWrite")
	public String reviewWriteGet(Model model) {
		return "/review/write";
	}
	
	// 글쓰기 처리
	@PostMapping("/reviewWrite")
	public String reviewWritePost(Model model, HttpServletRequest req, ReviewDTO reviewDTO, HttpSession session) {
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
		// 세션에서 사용자 아이디 가져오기
		String userId = (String) session.getAttribute("userId");
		reviewDTO.setUser_id(userId);
		
		// 폼값을 개별적으로 전달한다.
		int result = dao.write(reviewDTO);
		System.out.println("글쓰기결과:"+ result);
		// 글쓰기가 완료되면 목록으로 이동한다.
		return "redirect:/reviewList";
	}
	
	@GetMapping("/reviewEdit")
	public String reviewEditGet(Model model, ReviewDTO reviewDTO) {
		reviewDTO = dao.view(reviewDTO);
		String imageFileNamesString = reviewDTO.getRv_image().replaceAll("[\\[\\] ]", "");
		String[] imageFileNames = imageFileNamesString.split(",");
		List<String> imageFileList = Arrays.asList(imageFileNames);
		model.addAttribute("imageFileList", imageFileList);
		model.addAttribute("reviewDTO", reviewDTO);
		return "/review/edit";       
	}	
	
	@PostMapping("/reviewEdit")
	public String reviewEditPost(Model model, HttpServletRequest req, ReviewDTO reviewDTO) {
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
		        //파일명을 추출한 후 따옴표를 제거한다. 
		        String[] phArr = partHeader.split("filename=");
		        String originalFileName = phArr[1].trim().replace("\"", "");

		         
				if (!originalFileName.isEmpty()) {	
			        //파일을 원본파일명으로 저장한다.
					part.write(uploadDir+ File.separator +originalFileName);
					//저장된 파일을 UUID로 생성한 새로운 파일명으로 저장한다. 
					String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
					/* Set에 저장된파일명을 저장한다.*/
					saveFileSets.add(savedFileName);
				}else {
					String imageFileNamesString = req.getParameter("prev_rv_image").replaceAll("[\\[\\] ]", "");
					String[] imageFileNames = imageFileNamesString.split(",");
					for (String filenames : imageFileNames) {
						String imageFileList = filenames.trim().replace("\"", "");
						// 파일을 수정하지 않은경우
						saveFileSets.add(imageFileList);
					}
				}
				
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
		int result = dao.edit(reviewDTO);
		System.out.println("글수정결과:"+ result);
		return "redirect:reviewView?rv_id="+ reviewDTO.getRv_id();       
	}
	
	@PostMapping("/reviewDelete")
	public String reviewDeletePost(HttpServletRequest req) {
		int result = dao.delete(req.getParameter("rv_id"));
		System.out.println("글삭제결과:"+ result);
		return "redirect:/reviewList";       
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	// 댓글 목록
	@RequestMapping("/reviewCommentList.api")
	@ResponseBody
	public Map<String, Object> listReviewComment(HttpServletRequest req, ParameterDTO parameterDTO) {
		HttpSession session = req.getSession();
		String rvId = (String) req.getParameter("rv_id");
		parameterDTO.setRv_id(rvId);
		System.out.println("확인용"+rvId);
	
		// 댓글 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장된다.)
		int totalCount = dao.getReviewCommentCount(parameterDTO);
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
		
		ArrayList<ReviewCommentDTO> lists = dao.listReviewComment(parameterDTO);
		
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/reviewView?rv_id="+rvId+"&");
		
		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다.
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		maps.put("lists", lists);
		maps.put("pagingImg", pagingImg);
		System.out.println("댓글 목록: "+maps);
		
		return maps;
	}
	
	// 댓글 작성
	@PostMapping("/reviewCommentWrite.api")
	@ResponseBody
	public Map<String, Object> restReviewCommentWrite(@RequestBody ReviewCommentDTO reviewCommentDTO, HttpSession session) {
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    String userId = (String) session.getAttribute("userId");
	    reviewCommentDTO.setUser_id(userId);
	    
	    int result = dao.writeReviewComment(reviewCommentDTO);
	    resultMap.put("result", result);
	    
	    return resultMap;
	}
	
	// 댓글 수정
	@PostMapping("/reviewCommentEdit.api")
	@ResponseBody
	public Map<String, Object> restReviewCommentEdit(@RequestBody ReviewCommentDTO reviewCommentDTO, HttpSession session) {
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    String userId = (String) session.getAttribute("userId");
	    reviewCommentDTO.setUser_id(userId);
	    
	    int result = dao.editReviewComment(reviewCommentDTO);
	    resultMap.put("result", result);
	    System.out.println(resultMap);
	    
	    return resultMap;
	}
	
	// 댓글 삭제
	@PostMapping("/reviewCommentDelete.api")
	@ResponseBody
	public Map<String, Object> restReviewCommentDelete(HttpServletRequest req) {
	    Map<String, Object> maps = new HashMap<>();
	    
	    int result = dao.deleteReviewComment(req.getParameter("rvc_id"));
	    maps.put("result", result);
	    System.out.println("댓글 삭제: "+ maps);
	    
	    return maps;
	}
}
