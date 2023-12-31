package com.edu.springboot.mate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.exhibition.ExhibitionDTO;
import com.edu.springboot.exhibition.IExhibitionService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class MateController {

    @Autowired
    IMateService dao;
    


//    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
//    private LocalDate mt_viewdate;
//
//    @Autowired
//    private IMateService mateService;
    
    //작성하기 
    @GetMapping("/mateWrite")
    public String mateWriteGet(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

//        if (userId != null) {
//            // 로그인한 사용자의 경우
//            // 세션에 저장된 userId를 이용하여 필요한 작업 수행
//             // 모집 등록 페이지로 이동
//        }
        return "mate/write";
    }

    @PostMapping("/mateWrite")
    public String mateWritePost(Model model, HttpServletRequest req, MateDTO mateDTO) {
        System.out.println("helloWorld");
        
        try {
            // request 내장객체를 통해 폼값을 받아온다.
//            String mt_status = req.getParameter("mt_status");
//            String mt_title = req.getParameter("mt_title");
//            
//            LocalDate mt_viewdate = null;
//            String mtViewDateParameter = req.getParameter("mt_viewdate");
//            if (mtViewDateParameter != null && !mtViewDateParameter.isEmpty()) {
//                try {
//                    mt_viewdate = LocalDate.parse(mtViewDateParameter);
//                } catch (DateTimeParseException e) {
//                    System.out.println("날짜 형식이 잘못되었습니다. 날짜를 확인해주세요.");
//                    e.printStackTrace();
//                    return "redirect:/mateList";
//                }
//            }

//            String mt_gender = req.getParameter("mt_gender");
//            String mt_age1 = req.getParameter("mt_age1");
//            String mt_age2 = req.getParameter("mt_age2");
//            String mt_content = req.getParameter("mt_content");
            
            HttpSession session = req.getSession();
    		String userId = (String) session.getAttribute("userId");
    		String userImg = (String) session.getAttribute("userImg");
    		String userName = (String) session.getAttribute("userName");
            mateDTO.setUser_id(userId);
            mateDTO.setUser_image(userImg);
            mateDTO.setUser_name(userName);
            System.out.println("userId: "+userId);
            
            System.out.println("메이트작성결과 유저들어오냐? : "+ mateDTO);

            int result = dao.write(mateDTO);
            System.out.println("글쓰기결과:" + result);

            // 글쓰기가 완료되면 목록으로 이동한다.
            return "redirect:/mateList";
        } catch (Exception e) {
            System.out.println("업로드 실패");
            e.printStackTrace();
            return "redirect:/mateList";
        }
    } 
    
 


    
    
    //리스트 출력 
    @RequestMapping("/mateList")
    public String mateList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
//    	System.out.println("mateList 메서드 호출여부 확인용");
    	int status = parameterDTO.getStatus();
    	
    	// status 값을 모델에 추가
        model.addAttribute("status", parameterDTO.getStatus());

    	
    	//각 리스트에 대한 총 게시물 수 계산 
        int totalCount = dao.getTotalCount(parameterDTO);
        //System.out.println("totalCount="+ totalCount);
        
        int pageSize = 12;//한 페이지당 게시물 수  
        int blockPage = 5;//한 블럭당 페이지 번호 수 
        int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1
                : Integer.parseInt(req.getParameter("pageNum"));
        int start = (pageNum-1) * pageSize + 1;
        int end = pageNum * pageSize;
        parameterDTO.setStart(start);
        parameterDTO.setEnd(end);
        
        //페이징 정보를 모델에 추가 
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("totalCount", totalCount);
        maps.put("pageSize", pageSize);
        maps.put("pageNum", pageNum);
        model.addAttribute("maps", maps);
        
        //전시 목록을 가져와 모델에 추가 
        ArrayList<MateDTO> lists = dao.listPage(parameterDTO);
        model.addAttribute("lists", lists);
        
        System.out.println("lists: "+lists);
        
        
        //모집중, 모집완료 구분 
        String mappingName = "";
        
        if (status == 1) {
    		mappingName = "/mateCurrentList?";
    	} else if (status == 2) {
    		mappingName = "/mateFutureList?";
    	} 
    	System.out.println("status:" + status);
    	
    	// 상태가 설정되어 있지 않으면 기본적으로 모집중으로 설정
        if (status == 0) {
            parameterDTO.setStatus(1);
        }
    	
    	// 기존 코드에서 목록을 가져오는 dao.listPage 메서드를 dao.listPageByStatus로 변경
//    	ArrayList<MateDTO> listsByStatus = dao.listPageByStatus(parameterDTO);
//    	model.addAttribute("lists", listsByStatus);
    	
        // 게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장한다.
        String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum,
        		//req.getContextPath()+"/mateList?");
        		//req.getContextPath() + "/mateList?list=?");
                req.getContextPath() + mappingName);
        model.addAttribute("pagingImg", pagingImg);
        System.out.println("status 상태:" + mappingName);
        //view로 포워드한다. 
        return "/mate/list";
    }
    // 모집중 
// 	@RequestMapping("/mateCurrentList")
// 	public String currentMtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
// 		parameterDTO.setStatus(1);
// 		System.out.println("모집중");
// 		return mateList(model, req, parameterDTO);
// 	}
 	// 모집완료
// 	@RequestMapping("/mateFutureList")
// 	public String futureMtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
// 		System.out.println("모집완료:" + parameterDTO);
// 		parameterDTO.setStatus(2);
// 		return mateList(model, req, parameterDTO);
// 	}
    
 // 모집중
    @RequestMapping("/mateCurrentList")
    public String currentMtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
        parameterDTO.setStatus(1);
        return mateList(model, req, parameterDTO);
    }

    // 모집완료
    @RequestMapping("/mateFutureList")
    public String futureMtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
        parameterDTO.setStatus(2);
        return mateList(model, req, parameterDTO);
    }


    
    
    
    
    //상세보기 
    @RequestMapping("/mateView")
    public String mateView(Model model, MateDTO mateDTO) {
        dao.visitCount(mateDTO.getMt_id());
        mateDTO = dao.view(mateDTO);
        mateDTO.setMt_content(mateDTO.getMt_content().replace("\r\n", "<br>"));
        
        model.addAttribute("mateDTO", mateDTO);
        System.out.println("나옴?"+ mateDTO);
        return "/mate/view";
    }
    
    
    //수정하기
    @GetMapping("/mateEdit")
	public String mateEditGet(Model model, MateDTO mateDTO) {
    	mateDTO = dao.view(mateDTO);
		model.addAttribute("mateDTO", mateDTO);
		System.out.println("수정GET: "+mateDTO);
		return "mate/edit";       
	}	
	@PostMapping("/mateEdit")
	public String mateEditPost(@ModelAttribute("mateDTO") MateDTO mateDTO) {
		System.out.println("수정 전 mateDTO: " + mateDTO);
		int result = dao.edit(mateDTO);
		System.out.println("수정된 글의Mt_id: " + mateDTO.getMt_id());
		System.out.println("글수정결과:"+ result);
		return "redirect:/mateView?Mt_id="+ mateDTO.getMt_id();   
		//return "redirect:/mateList";
	}
    
    
    
    
    //삭제하기
    @PostMapping("/delete")
	public String mateDeletePost(HttpServletRequest req) {
		int result = dao.delete(req.getParameter("mt_id"));
		System.out.println("글삭제결과:"+ result);
		return "redirect:/mateList";       
	}
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 // 메이트 댓글 목록
  	@RequestMapping("/mateCommentList.api")
  	@ResponseBody
  	public Map<String, Object> listMateComment(HttpServletRequest req, MateDTO mateDTO) {
//  		HttpSession session = req.getSession();
//  		String mtId = (String) session.getAttribute("mt_id");
//  		parameterDTO.setMt_id(mtId);
//  		System.out.println(mtId);
  		String mtid = req.getParameter("mt_id");
  		mateDTO.setMt_id(mtid);
  		System.out.println("mtid:" + mtid);
  		
  		// 게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장된다.)
  		int totalCount = dao.getMateComment(mateDTO);
  		System.out.println("totalCount:" + totalCount);
  		
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
  		mateDTO.setStart(start);
  		mateDTO.setEnd(end);
  		
  		ArrayList<MtCommentDTO> lists = dao.listMateComment(mateDTO);
  		System.out.println(lists);
  		
  		
  		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/mateView?mt_id="+ mtid +"&");
  		
  		// View 에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다.
  		Map<String, Object> maps = new HashMap<String, Object>();
  		maps.put("totalCount", totalCount);
  		maps.put("pageSize", pageSize);
  		maps.put("pageNum", pageNum);
  		maps.put("lists", lists);
  		maps.put("pagingImg", pagingImg);
  		
  		System.out.println("한줄평 목록: "+maps);
  		
  		return maps;
  	}
     
    
    
    //메이트 댓글 작성
 	@PostMapping("/mateCommentWrite.api")
 	@ResponseBody
 	public Map<String, Object> restMateCommentWrite(@RequestBody MtCommentDTO mtCommentDTO, HttpSession session) {
 		Map<String, Object> resultMap = new HashMap<>();
 		
 		String userId = (String) session.getAttribute("userId");
 		mtCommentDTO.setUser_id(userId);
 		
 		System.out.println("DTO="+ mtCommentDTO);
 		
 		int result = dao.writeMateComment(mtCommentDTO);
 		resultMap.put("result", result);
 		
 		System.out.println(resultMap);
 		
 		return resultMap;
 	}
 // 메이트 댓글 수정
 	@PostMapping("/mateCommentEdit.api")
 	@ResponseBody
 	public Map<String, Object> restMateCommentEdit(@RequestBody MtCommentDTO mtCommentDTO, HttpSession session) {
 		Map<String, Object> resultMap = new HashMap<>();
 		
 		String userId = (String) session.getAttribute("userId");
 		mtCommentDTO.setUser_id(userId);
 		
 		System.out.println("DTO="+ mtCommentDTO);
 		
 		int result = dao.editMateComment(mtCommentDTO);
 		resultMap.put("result", result);
 		
 		System.out.println(resultMap);
 		
 		return resultMap;
 	}
 	
 	// 메이트 댓글 삭제
 	@PostMapping("/mateCommentDelete.api")
 	@ResponseBody
 	public Map<String, Object> restMateCommentDelete(HttpServletRequest req) {
 	    Map<String, Object> maps = new HashMap<>();
 	    
 	    int result = dao.deleteMateComment(req.getParameter("mtcom_id"));
 	    maps.put("result", result);
// 	    System.out.println("한줄평삭제: "+ maps);
 	    
 	    return maps;
 	}
    
    
    
    
}


 









