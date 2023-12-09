package com.edu.springboot.gallery;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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

	// 글쓰기 페이지 로딩
		@GetMapping("/galleryWrite")
		public String reviewWriteGet(Model model) {
			return "/gallery/write";
		}
	
	
	// 글쓰기 처리
//    @PostMapping("/galleryWrite")
//    public String galleryWritePost(Model model, HttpServletRequest req, GalleryDTO galleryDTO) { 
//	  
//    	System.out.println("galleryDTO="+ galleryDTO);
//    	
//    	try {
//    		// 업로드 디렉토리의 물리적 경로 얻어오기
//    		String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
//    		System.out.println("물리적경로:"+uploadDir);
//    		
//    		Map<String, String> saveFileMaps = new HashMap<>();
//			Collection<Part> parts = req.getParts();
//			for(Part part : parts) {
//				if(!part.getName().equals("art_image1"))
//					continue;
//    			
//    			// 파일명 확인을 위해 해더값 얻어오기
//    			String partHeader = part.getHeader("content-disposition");
//	    		System.out.println("partHeader="+ partHeader);
//	    		// 헤더값에서 파일명 추출을 위해 문자열을 split()하기
//	    		String[] phArr = partHeader.split("filename=");
//	    		// 따옴표를 제거한 후 원본 파일명 추출.
//	    		String originalFileName = phArr[1].trim().replace("\"", "");
//	    		
//	    		// 전송된 파일이 있다면 서버에 저장하기
//	    		if(!originalFileName.isEmpty()) {
//	    			part.write(uploadDir+ File.separator +originalFileName);
//	    		}
//	    		saveFileMaps.put(originalFileName," ");
//    		}
//    		// JDBC연동 하지 않았으므로 Model객체에 정보 저장
//    		model.addAttribute("saveFileMaps", saveFileMaps);
//    		
//    		// JDBC연동
//    		galleryDTO.setArt_image1(saveFileMaps.toString());
//    		dao.write(galleryDTO);
//    		
//    	}catch (Exception e) {
//			System.out.println("업로드 실패");
//			e.printStackTrace();
//		}
//    		
//    	// request 내장객체를 통해 폼값 받아오기 
//    	String title = req.getParameter("ga_title"); 
//	    String name = req.getParameter("user_id");
//	    String sdate = req.getParameter("ga_sdate"); 
//	    String edate = req.getParameter("ga_edate"); 
//	    String content = req.getParameter("ga_content");
//	    String image1 = req.getParameter("art_image1"); 
//	    String title1 = req.getParameter("art_title1");
//	    String content1 = req.getParameter("art_content1"); 
//	    String image2 = req.getParameter("art_image2"); 
//	    String title2 = req.getParameter("art_title2");
//	    String content2 = req.getParameter("art_content2"); 
//	    String image3 = req.getParameter("art_image3"); 
//	    String title3 = req.getParameter("art_title3");
//	    String content3 = req.getParameter("art_content3"); 
//	    String image4 = req.getParameter("art_image4"); 
//	    String title4 = req.getParameter("art_title4");
//	    String content4 = req.getParameter("art_content4"); 
//	    String image5 = req.getParameter("art_image5"); 
//	    String title5 = req.getParameter("art_title5");
//	    String content5 = req.getParameter("art_content5");
//	    
//    	// 폼값 개별적으로 전달 
//	    int result = dao.write(title, name, sdate, edate, content,
//	    	    image1, title1, content1, image2, title2, content2, image3, title3, content3,
//	    	    image4, title4, content4, image5, title5, content5);
//	  
//	    System.out.println("글쓰기 결과:"+ result);
//	  
//	    //글쓰기 완료되면 목록으로이동 
//	    return "redirect:/galleryList";
//	 }

    
	@PostMapping("/galleryWrite")
    public String galleryWritePost(Model model, GalleryDTO galleryDTO) {
        // 파일 업로드 처리
        try {
            // 업로드 디렉토리의 물리적 경로 얻어오기
            String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
            System.out.println("물리적경로:" + uploadDir);

            Map<String, String> saveFileMaps = new HashMap<>();
            
            // 각 이미지에 대한 처리 추가
            MultipartFile[] imageFiles = {
            		galleryDTO.getArt_image1(), 
            		galleryDTO.getArt_image2(), 
            		galleryDTO.getArt_image3(), 
            		galleryDTO.getArt_image4(), 
            		galleryDTO.getArt_image5()
            		};
            
            for (MultipartFile imageFile : imageFiles) {
                // 파일이 비어있지 않으면 저장
                if (!imageFile.isEmpty()) {
                    String originalFileName = imageFile.getOriginalFilename();
                    imageFile.transferTo(new File(uploadDir + File.separator + originalFileName));
                    saveFileMaps.put(originalFileName, " ");
                }
            }

            // JDBC연동 하지 않았으므로 Model객체에 정보 저장
            model.addAttribute("saveFileMaps", saveFileMaps);
            
            // JDBC연동
    		galleryDTO.setArt_title1(saveFileMaps.toString());
    		dao.write(galleryDTO);

        } 
        catch (Exception e) {
            System.out.println("업로드 실패");
            e.printStackTrace();
        }

        //글쓰기 완료되면 목록으로 이동
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
	
	// 갤러리 댓글 기능
	@GetMapping("/galleryView/getComments")
    public List<GalleryCommentDTO> getComments(@RequestParam(name = "cm_id")int cm_id) {
		
		List<GalleryCommentDTO> list = dao.getGalleryComments(cm_id);
	
		return list;
		}
	
//	// 갤러리 댓글 기능
	/*
	 * @PostMapping("/galleryView/addComment")
	 * 
	 * @ResponseBody public ResponseEntity<String>
	 * addComment(@RequestParam("commentContent") String commentContent) { try {
	 * 
	 * return ResponseEntity.ok("댓글이 성공적으로 등록되었습니다."); } catch (Exception e) { // 오류
	 * 발생 시 오류 응답 반환 return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).
	 * body("댓글 등록 중 오류가 발생했습니다."); } }
	 */
	

	

	@PostMapping("/galleryView/addComment")
	@ResponseBody
	public ResponseEntity<String> addComment(@RequestParam("commentContent") String commentContent, GalleryCommentDTO dto,Model model) {
		var userId = dto.getUser_id();
		try {
			
			model.addAttribute(userId);
			dao.addGalleryComment(dto);
            return ResponseEntity.ok("댓글이 성공적으로 등록되었습니다.");
		} 
		catch (Exception e) {
			// 오류 발생 시 오류 응답 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 등록 중 오류가 발생했습니다.");
		}
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
