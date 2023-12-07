package com.edu.springboot;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.jdbc.GalleryDTO;
import com.edu.springboot.jdbc.IGalleryService;
import com.edu.springboot.jdbc.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import utils.PagingUtil;


@Controller
public class GalleryController {
	
	// DAO호출을 위한 빈 자동주입. 이 인터페이스를 통해 Mapper 호출
	@Autowired
	IGalleryService dao;
	
	// 갤러리 목록
	@RequestMapping("/galleryList")
	public String galleryList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {

		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장
		int totalCount = dao.getTotalCount(parameterDTO);
		
		// 페이징을 위한 설정값
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		// 현재 페이지에 출력한 게시물의 구간 계산
		int start = (pageNum-1) * pageSize +1;
		int end = pageNum * pageSize;
		
		// 계산된 값 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		// 데이터베이스에서 인출한 게시물의 목록을 Model객체에 저장
		ArrayList<GalleryDTO> galleryList = dao.listPage(parameterDTO);
		model.addAttribute("galleryList", galleryList);
		
		// 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/galleryList?");
		model.addAttribute("pagingImg", pagingImg);

		return "/gallery/list";
	}

	// 갤러리 등록
	@GetMapping("/galleryWrite")
	public String galleryWriteGet(Model model) {
		return "/gallery/write";
	}
	
	// 글쓰기 처리
    @PostMapping("/galleryWrite")
    public String galleryWritePost(Model model, HttpServletRequest req, GalleryDTO galleryDTO) { 
	  
    	System.out.println("galleryDTO="+ galleryDTO);
    	
    	try {
    		
    		// 업로드 디렉토리의 물리적 경로 얻어오기
    		String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
    		System.out.println("물리적경로:"+uploadDir);
    		
    		// 전송된 파일을 Part객체 통해 얻어오기
    		Part part = req.getPart("art_image1");
			// 파일명 확인을 위해 해더값 얻어오기
    		String partHeader = part.getHeader("content-disposition");
    		System.out.println("partHeader="+ partHeader);
    		// 헤더값에서 파일명 추출을 위해 문자열을 split()하기
    		String[] phArr = partHeader.split("filename=");
    		// 따옴표를 제거한 후 원본 파일명 추출.
    		String originalFileName = phArr[1].trim().replace("\"", "");
    		
    		// 전송된 파일이 있다면 서버에 저장하기
    		if(!originalFileName.isEmpty()) {
    			part.write(uploadDir+ File.separator +originalFileName);
    		}
    		
    		// JDBC연동 하지 않았으므로 Model객체에 정보 저장
    		model.addAttribute("originalFileName", originalFileName);
    		
    		// 파일 외 나머지 폼값도 받아서 저장한다.
    		model.addAttribute("ga_title", req.getParameter("ga_title"));
    		model.addAttribute("ga_sdate", req.getParameter("ga_sdate"));
    		model.addAttribute("ga_edate", req.getParameter("ga_edate"));
    		model.addAttribute("ga_content", req.getParameter("ga_content"));
//    		model.addAttribute("ga_visitcount", req.getParameter("ga_visitcount"));
//    		model.addAttribute("ga_bmcount", req.getParameter("ga_bmcount"));
//    		model.addAttribute("art_image1", req.getParameter("art_image1"));
    		model.addAttribute("art_title1", req.getParameter("art_title1"));
    		model.addAttribute("art_content1", req.getParameter("art_content1"));
//    		model.addAttribute("art_image2", req.getParameter("art_image2"));
    		model.addAttribute("art_title2", req.getParameter("art_title2"));
    		model.addAttribute("art_content2", req.getParameter("art_content2"));
//    		model.addAttribute("art_image3", req.getParameter("art_image3"));
    		model.addAttribute("art_title3", req.getParameter("art_title3"));
    		model.addAttribute("art_content3", req.getParameter("art_content3"));
//    		model.addAttribute("art_image4", req.getParameter("art_image4"));
    		model.addAttribute("art_title4", req.getParameter("art_title4"));
    		model.addAttribute("art_content4", req.getParameter("art_content4"));
//    		model.addAttribute("art_image5", req.getParameter("art_image5"));
    		model.addAttribute("art_title5", req.getParameter("art_title5"));
    		model.addAttribute("art_content5", req.getParameter("art_content5"));
    		
    		// JDBC연동
    		galleryDTO.setArt_image1(originalFileName);
    		dao.write(galleryDTO);
		}
    	catch (Exception e) {
    		System.out.println("업로드 실패");
    		e.printStackTrace();
    		// 사용자에게 오류 메시지를 반환할 수 있도록 모델에 오류 메시지 추가
    		model.addAttribute("error", "파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요");
    		return "/gallery/write"; // 또는 다른 적절한 뷰 페이지로 이동
		}
    	
    	
    	// request 내장객체를 통해 폼값 받아오기 
    	String title = req.getParameter("ga_title"); 
	    String name = req.getParameter("user_id");
	    String sdate = req.getParameter("ga_sdate"); 
	    String edate = req.getParameter("ga_edate"); 
	    String content = req.getParameter("ga_content");
	    String image1 = req.getParameter("art_image1"); 
	    String title1 = req.getParameter("art_title1");
	    String content1 = req.getParameter("art_content1"); 
	    String image2 = req.getParameter("art_image2"); 
	    String title2 = req.getParameter("art_title2");
	    String content2 = req.getParameter("art_content2"); 
	    String image3 = req.getParameter("art_image3"); 
	    String title3 = req.getParameter("art_title3");
	    String content3 = req.getParameter("art_content3"); 
	    String image4 = req.getParameter("art_image4"); 
	    String title4 = req.getParameter("art_title4");
	    String content4 = req.getParameter("art_content4"); 
	    String image5 = req.getParameter("art_image5"); 
	    String title5 = req.getParameter("art_title5");
	    String content5 = req.getParameter("art_content5");
	    
    	// 폼값 개별적으로 전달 
	    int result = dao.write(title, name, sdate, edate, content,
	    	    image1, title1, content1, image2, title2, content2, image3, title3, content3,
	    	    image4, title4, content4, image5, title5, content5);
	  
	    System.out.println("글쓰기 결과:"+ result);
	  
	    //글쓰기 완료되면 목록으로이동 
	    return "redirect:/galleryList"; 
	 }
	

	 
	// 갤러리 내용
	@RequestMapping("/galleryView")
	public String galleryView(Model model, GalleryDTO galleryDTO) {
		dao.visitCount(galleryDTO.getGa_id());
		galleryDTO = dao.view(galleryDTO);
		galleryDTO.setGa_content(galleryDTO.getGa_content().replace("\r\n", "<br/>"));
		model.addAttribute("galleryDTO", galleryDTO);		
		return "/gallery/view";
	}
		
	// 온라인 갤러리
	@GetMapping("/galleryRoom")
	public String galleryRoom() {
		return "/gallery/room";
	}
	
	
	/* 관리자 */

	@GetMapping("/admin/gaComments")
	public String gaComments() {
		return "/admin/gaComments";
	}
	@GetMapping("/admin/gaList")
	public String gaList() {
		return "/admin/gaList";
	}
	
	

}
