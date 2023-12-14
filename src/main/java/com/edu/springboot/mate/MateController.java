package com.edu.springboot.mate;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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
            
            System.out.println("메이트작성결과 유저들어오냐? : "+mateDTO);

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
    public String mateList(Model model, HttpServletRequest req, ParameterDTO parameterDTO, MateDTO mateDTO) {
        
        int totalCount = dao.getTotalCount(parameterDTO);
        int pageSize = 12;
        int blockPage = 5;
        int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1
                : Integer.parseInt(req.getParameter("pageNum"));
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;
        parameterDTO.setStart(start);
        parameterDTO.setEnd(end);

        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("totalCount", totalCount);
        maps.put("pageSize", pageSize);
        maps.put("pageNum", pageNum);
        model.addAttribute("maps", maps);

        ArrayList<MateDTO> lists = dao.listPage(parameterDTO);
        model.addAttribute("lists", lists);
        
        System.out.println("Tl: "+lists);

        String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum,
                req.getContextPath() + "/mateList?");
        model.addAttribute("pagingImg", pagingImg);

        return "/mate/list";
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
}


 











