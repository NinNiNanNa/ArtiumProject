package com.edu.springboot.mate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class AdminMateController {
	@Autowired
    IAdminMateService dao;

    //리스트 출력 
    @RequestMapping("/admin/mtList")
    public String mtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO, MateDTO mateDTO) {
    	
    	System.out.println("페이지접근");
    	
    	//각 리스트에 대한 총 게시물 수 계산 
        int totalCount = dao.getTotalCount(parameterDTO);
        System.out.println("totalCount="+ totalCount);
        
        int pageSize = 12;//한 페이지당 게시물 수  
        int blockPage = 5;//한 블럭당 페이지 번호 수 
        int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1
                : Integer.parseInt(req.getParameter("pageNum"));
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;
        parameterDTO.setStart(start);
        parameterDTO.setEnd(end);
        
        //페이징 정보를 모델에 추가 
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("totalCount", totalCount);
        maps.put("pageSize", pageSize);
        maps.put("pageNum", pageNum);
        model.addAttribute("maps", maps);
        System.out.println(maps);
        //전시 목록을 가져와 모델에 추가 
        ArrayList<MateDTO> lists = dao.listPage(parameterDTO);
        model.addAttribute("lists", lists);
        
        System.out.println("Tl: "+lists);
        
        //mt_id를 model에 추가
//        for (MateDTO mt : lists) {
//            model.addAttribute("mt_id_" + mt.getMt_id(), mt.getMt_id());
//        }
        for (MateDTO mt : lists) {
            System.out.println("mt_id: " + mt.getMt_id());
        }
        
    	
        return "/admin/mtList";
 	}
    
    //삭제하기
    @PostMapping("/admin/mtDelete")
    public String mateDeletePost(HttpServletRequest req) {
    	int result = dao.delete(req.getParameter("mt_id"));
    	System.out.println("글 삭제결과:" + result);
    	return "redirect:mtList";
    }
    
	
 // 메이트 댓글 목록
//    @GetMapping("/admin/mtComments")
//	public String mtComments() {
//		return "/admin/mtComments";
//	}
    @RequestMapping("/admin/mtComments")
  	public Map<String, Object> listMateComment(Model model, HttpServletRequest req, MateDTO mateDTO) {
//  		String mtid = req.getParameter("mt_id");
//  		mateDTO.setMt_id(mtid);
//  		System.out.println("mtid:" + mtid);
  		
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
  		
  		
  		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum, req.getContextPath()+"/admin/mtComments?");
  		
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
   	
// // 메이트 댓글 삭제
//  	@PostMapping("/mateCommentDelete.api")
   	@PostMapping("/adminMateCommentDelete.api")
  	@ResponseBody
  	public Map<String, Object> restMateCommentDelete(HttpServletRequest req) {
  	    Map<String, Object> maps = new HashMap<>();
  	    
  	    int result = dao.deleteMateComment(req.getParameter("mtcom_id"));
  	    maps.put("result", result);
  	    System.out.println("댓글삭제: "+ maps);
  	    
  	    return maps;
  	}
}


 










