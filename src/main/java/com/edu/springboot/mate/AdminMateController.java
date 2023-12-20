package com.edu.springboot.mate;

import java.util.ArrayList;
import java.util.HashMap;
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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class AdminMateController {

    @Autowired
    IAdminMateService dao;

    //리스트 출력 
    @RequestMapping("/admin/mtList")
//    @GetMapping("/admin/mtList")
    public String mtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO, MateDTO mateDTO) {
//    	System.out.println("mateList 메서드 호출여부 확인용");
//    	int status = parameterDTO.getStatus();
//    	String status = String.valueOf(parameterDTO.getStatus());
//    	System.out.println(status);
    	

    	
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
        
        //전시 목록을 가져와 모델에 추가 
        ArrayList<MateDTO> mtLists = dao.listPage(parameterDTO);
        model.addAttribute("mtLists", mtLists);
        
        System.out.println("Tl: "+mtLists);
        
        
        //모집중, 모집완료 구분 
//        String mappingName = "";
//        
//    	if ("모집중".equals(status)) {
//    		mappingName = "/admin/mateCurrentList?";
//    	} 
//    	else if ("모집완료".equals(status)) {
//    		mappingName = "/admin/mateFutureList?";
//    	} 
//    	System.out.println("status:" + status);

    	// 기존 코드에서 목록을 가져오는 dao.listPage 메서드를 dao.listPageByStatus로 변경
//    	ArrayList<MateDTO> listsByStatus = dao.listPageByStatus(parameterDTO);
//    	model.addAttribute("lists", listsByStatus);
//    	
//        String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum,
//        		//req.getContextPath() + "/mateList?list=?");
//                req.getContextPath() + mappingName);
//        model.addAttribute("pagingImg", pagingImg);
//        System.out.println("status 상태:" + mappingName);
        return "/admin/mtList";
//    }
//    
    // 모집중 
// 	@RequestMapping("admin/mateCurrentList")
// 	public String currentMtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
// 		parameterDTO.setStatus("모집중");
// 		System.out.println("나와?");
// 		return mateList(model, req, parameterDTO, new MateDTO());
// 	}
 	// 모집완료 
// 	@RequestMapping("admin/mateFutureList")
 //	public String futureMtList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
 	//	System.out.println("DEBUG: futureMtList method called");
 		//parameterDTO.setStatus("모집완료");
 		//return mateList(model, req, parameterDTO, new MateDTO());
 	}
  
}


 










