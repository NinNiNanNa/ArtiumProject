package com.edu.springboot.gallery;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.MyFunctions;
import utils.PagingUtil;


@Controller
public class GalleryController {
	
	// DAO호출을 위한 빈 자동주입. 이 인터페이스를 통해 Mapper 호출
	@Autowired
	IGalleryService dao;

	
	// 갤러리 목록
	@RequestMapping("/galleryList")
	public String galleryList(Model model, HttpServletRequest req, GalleryDTO galleryDTO, HttpSession session) {
		
		// 세션에서 사용자 아이디 가져오기
		String userId = (String) session.getAttribute("userId");
		galleryDTO.setUser_id(userId);

		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장
		int totalCount = dao.getTotalCount(galleryDTO);
		
		// 페이징을 위한 설정값
		int pageSize = 12;	// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		// 현재 페이지에 출력한 게시물의 구간 계산
		int start = (pageNum-1) * pageSize +1;
		int end = pageNum * pageSize;
		
		// 계산된 값 DTO에 저장
		galleryDTO.setStart(start);
		galleryDTO.setEnd(end);
		
		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		// 데이터베이스에서 인출한 게시물의 목록을 Model객체에 저장
		ArrayList<GalleryDTO> galleryList = dao.listPage(galleryDTO);
		model.addAttribute("galleryList", galleryList);
		
//		System.out.println("뀨: "+galleryList);
		
		// 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/galleryList?");
		model.addAttribute("pagingImg", pagingImg);
		
//		System.out.println(galleryDTO);

		return "/gallery/list";
	}

	// 글쓰기 페이지 로딩
	@GetMapping("/galleryWrite")
	public String reviewWriteGet(Model model, HttpSession session) {
		// 세션에서 사용자 아이디 가져오기
		String userId = (String) session.getAttribute("userId");
		// 사용자 아이디를 모델에 추가
		model.addAttribute("userId", userId);
		
		return "/gallery/write";
	}
	
	
	// 글쓰기 처리		
    @PostMapping("/galleryWrite")
    public String galleryWritePost(Model model, HttpServletRequest req, GalleryDTO galleryDTO, HttpSession session) { 

    	try {
    		// 업로드 디렉토리의 물리적 경로 얻어오기
    		String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
    		System.out.println("물리적경로:"+uploadDir);
    		
    		// 파일명 저장을 위한 Map생성. Key는 원본파일명, value는 서버에 저장된 파일명을 저장한다.
    		Map<String, String> saveFileMaps  = new HashMap<>();
    		
    		for(int i=1 ; i<=5 ; i++) {
	    		// 전송된 첨부파일을 Part객체를 통해 얻어오기
	    		Part part = req.getPart("art_image"+ i);
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
	    		// 저장된 파일명을 UUID로 생성한 새로운 파일명으로 저장한다.
				String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
				
	    		/* Map컬렉션에 원본파일명과 저장된 파일명을 key와 value로 저장한다. */
	    		saveFileMaps.put(originalFileName, savedFileName);
//	    		saveFileMaps.put(originalFileName, originalFileName);
	    		
	    		if(i==1) galleryDTO.setArt_image1(savedFileName);
	    		if(i==2) galleryDTO.setArt_image2(savedFileName);
	    		if(i==3) galleryDTO.setArt_image3(savedFileName);
	    		if(i==4) galleryDTO.setArt_image4(savedFileName);
	    		if(i==5) galleryDTO.setArt_image5(savedFileName);
    		}
			
			// 세션에서 사용자 아이디 가져오기
			String userId = (String) session.getAttribute("userId");
			// 사용자 아이디를 GallerDTO에 설정
			galleryDTO.setUser_id(userId);
			
			System.out.println("galleryDTO"+galleryDTO);
			
			// JDBC연동			
			dao.write(galleryDTO);
		}
		catch (Exception e) {
			System.out.println("업로드 실패");
			e.printStackTrace();
		}
	
	    //글쓰기 완료되면 목록으로이동 
	    return "redirect:/galleryList";  	    
	 }
     
	// 갤러리 내용

	@RequestMapping("/galleryView")
	public String galleryView(Model model, GalleryDTO galleryDTO, HttpSession session) {
		
		// 세션에서 사용자 아이디 가져오기
		String userId = (String) session.getAttribute("userId");
		// 사용자 아이디를 GallerDTO에 설정
        galleryDTO.setUser_id(userId);

//        System.out.println("DTO: "+ galleryDTO);
		
		dao.visitCount(galleryDTO.getGa_id());
		
		galleryDTO = dao.view(galleryDTO);
		galleryDTO.setGa_content(galleryDTO.getGa_content().replace("\r\n", "<br/>"));
		model.addAttribute("galleryDTO", galleryDTO);	
        
//        System.out.println("모델DTO: "+ galleryDTO);	
        
		return "gallery/view";
//        return "redirect:/galleryView";
	}

	// 온라인 갤러리
	@GetMapping("/galleryRoom")
	public String galleryRoom(Model model, GalleryDTO galleryDTO, HttpSession session) {
		
//		System.out.println("온라인갤러리: "+ galleryDTO);
		
		galleryDTO = dao.onlineGallery(galleryDTO);
		galleryDTO.setGa_content(galleryDTO.getGa_content().replace("\r\n", "<br/>"));
//		System.out.println("온라인갤러리나오나: "+ galleryDTO);
		
		model.addAttribute("galleryDTO", galleryDTO);
		
		return "/gallery/room";
	}
	
	// 수정하기
	@GetMapping("/galleryEdit")
	public String galletEditGet(Model model, GalleryDTO galleryDTO, HttpSession session) {
		// 세션에서 사용자 아이디 가져오기
		String userId = (String) session.getAttribute("userId");
		// 사용자 아이디를 모델에 추가
		model.addAttribute("userId", userId);
		
		galleryDTO = dao.view(galleryDTO);
		model.addAttribute("galleryDTO", galleryDTO);
		System.out.println("수정 전: "+ galleryDTO);
		return "gallery/edit";
	}
	
	@PostMapping("/galleryEdit")
	public String galletEditPost(Model model, HttpServletRequest req, GalleryDTO galleryDTO, HttpSession session) {
		
		try {
    		// 업로드 디렉토리의 물리적 경로 얻어오기
    		String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
    		System.out.println("물리적경로:"+uploadDir);
    		
    		// 파일명 저장을 위한 Map생성. Key는 원본파일명, value는 서버에 저장된 파일명을 저장한다.
    		Map<String, String> saveFileMaps  = new HashMap<>();
    		
    		for(int i=1 ; i<=5 ; i++) {
	    		// 전송된 첨부파일을 Part객체를 통해 얻어오기
	    		Part part = req.getPart("art_image"+ i);
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
	    		else { 
	    			String imageFileNamesString = req.getParameter(originalFileName).replaceAll("[\\[\\] ]", "");
	    			String[] imageFileNames = imageFileNamesString.split(",");
	    			for(String filenames : imageFileNames) {
	    				String imageFileList = filenames.trim().replace("\"", "");
	    				// 파일을 수정하지 않은경우
	    				saveFileMaps.put(imageFileList, imageFileList);
	    				
	    			}
	    		}
	    		// 저장된 파일명을 UUID로 생성한 새로운 파일명으로 저장한다.
				String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
				
	    		/* Map컬렉션에 원본파일명과 저장된 파일명을 key와 value로 저장한다. */
	    		saveFileMaps.put(originalFileName, savedFileName);
//	    		saveFileMaps.put(originalFileName, originalFileName);
	    		
	    		if(i==1) galleryDTO.setArt_image1(savedFileName);
	    		if(i==2) galleryDTO.setArt_image2(savedFileName);
	    		if(i==3) galleryDTO.setArt_image3(savedFileName);
	    		if(i==4) galleryDTO.setArt_image4(savedFileName);
	    		if(i==5) galleryDTO.setArt_image5(savedFileName);
    		}
			
			// 세션에서 사용자 아이디 가져오기
			String userId = (String) session.getAttribute("userId");
			// 사용자 아이디를 GallerDTO에 설정
			galleryDTO.setUser_id(userId);
			
			System.out.println("galleryDTO"+galleryDTO);
			
			// JDBC연동			
			dao.write(galleryDTO);
		}
		catch (Exception e) {
			System.out.println("업로드 실패");
			e.printStackTrace();
		}
		
		System.out.println("수정이 되는거니...?: "+ galleryDTO);
		int result = dao.edit(galleryDTO);
		System.out.println("수정결과: "+ result);
		return "redirect:/galleryView?ga_id="+ galleryDTO.getGa_id();
	}
	
	// 삭제하기
	@PostMapping("/galleryList")
	public String galleryViewDelete(HttpServletRequest req, Model model) {
		int result = dao.delete(req.getParameter("ga_id"));
		System.out.println("글삭제결과: "+ result);

		return "redirect:/galleryList";
	}
	
/************************************************************************************************************/

	// 갤러리 댓글 조회
	@RequestMapping("/galleryCommentList.api")
	@ResponseBody
	public Map<String, Object> galleryCommentList(HttpServletRequest req, GalleryDTO galleryDTO) {
		HttpSession session = req.getSession();
		String gaid = (String)session.getAttribute("ga_id");
		galleryDTO.setGa_id(gaid);
		System.out.println(gaid);
		
		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장)
		int totalCount = dao.getGalleryComments(galleryDTO);
		// 페이징을 위한 설정값(하드코딩)
		int pageSize = 10;		// 한 페이지당 게시물 수
		int blockPage = 5;	// 한 블럭당 페이지번호 수
		
		// 목록에 첫 진입시에는 페이지 번호가 없으므로 무조건 1로 설정, 파라미터로 전달된 페이지 번호가 있다면 받은 후 정수로 변경해서 설정
		int pageNum = (req.getParameter("pageNum")==null || req.getParameter("pageNum").equals(""))
						? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		//현재 페이지에 출력한 게시물의 구간 계산
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		
		// 계산된 값 DTO에 저장
		galleryDTO.setStart(start);
		galleryDTO.setEnd(end);
		
		ArrayList<GalleryCommentDTO> lists = dao.listGalleryComments(galleryDTO);
		
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/galleryView?ga_id="+gaid+"&");
		
		// View 게시물의 가상번호 계산을 위한 값을 Map에 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		maps.put("lists", lists);
		maps.put("pagingImg", pagingImg);
		
		System.out.println("댓글 목록 나오나요?: "+maps);
		
		return maps;
	}


	
/************************************************************************************************************/
	     
	
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
