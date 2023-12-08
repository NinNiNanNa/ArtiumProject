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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class MateController {

	//DAO호출을 위한 빈 자동주입. 이 인터페이스를 통해 Mapper를 호출한다. 
	@Autowired
	IMateService dao;
	
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate mt_viewdate;

	
 
	//게시판 목록
	@RequestMapping("mateList")
	public String mateList(Model model, HttpServletRequest req, 
			ParameterDTO parameterDTO) {
		/* 매개변수는 View로 전달할 데이터를 저장하기 위한 Model객체와 요청을 받아
		처리하기위한 request 내장객체, DTO 객체를 추가한다. */
		
		//게시물의 갯수를 카운트(검색어가 있는 경우 DTO객체에 자동으로 저장된다.) 
		int totalCount = dao.getTotalCount(parameterDTO);
		//페이징을 위한 설정값(하드코딩)
		int pageSize = 12;//한 페이지당 게시물 수
		int blockPage = 12;//한 블럭당 페이지번호 수
		/* 목록에 첫 진입시에는 페이지 번호가 없으므로 무조건 1로 설정하고, 파라미터로 
		전달된 페이지 번호가 있다면 받은 후 정수로 변경해서 설정한다. */
		int pageNum = (req.getParameter("pageNum")==null 
			|| req.getParameter("pageNum").equals("")) 
			? 1 : Integer.parseInt(req.getParameter("pageNum"));
		//현재 페이지에 출력한 게시물의 구간을 계산한다. 
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		//계산된 값은 DTO에 저장한다. 
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		//View에서 게시물의 가상번호 계산을 위한 값들을 Map에 저장한다. 
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		//데이터베이스에서 인출한 게시물의 목록을 Model객체에 저장한다. 
		ArrayList<MateDTO> lists = dao.listPage(parameterDTO);
		model.addAttribute("lists", lists);
		
		//게시판 하단에 출력한 페이지번호를 String으로 반환받은 후 Model객체에 저장한다.
		String pagingImg =
			PagingUtil.pagingImg(totalCount, pageSize, 
				blockPage, pageNum,
				req.getContextPath()+"/list.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		//View로 포워드한다. 
		return "mate/list";       
	}	
	
	
	 //글쓰기 페이지 로딩
	 @GetMapping("/mateWrite") public String mateWriteGet(Model model) { return
	 "mate/write"; }
	 
	 //글쓰기 처리
	 @PostMapping("/mateWrite")
	 public String mateWritePost(Model model, HttpServletRequest req, MateDTO mateDTO) {
		 try {
			//request 내장객체를 통해 폼값을 받아온다. 
				//int mt_id = Integer.parseInt(req.getParameter("mt_id"));
				String mt_status = req.getParameter("mt_status");
				String mt_title = req.getParameter("mt_title");
				//전시회 정보 확인필요
				String ex_info = req.getParameter("ex_info");
				LocalDate mt_viewdate = LocalDate.parse(req.getParameter("mt_viewdate"));
				String mt_gender = req.getParameter("mt_gender");
				String mt_age = req.getParameter("mt_age");
				String mt_content = req.getParameter("mt_content");
				int result = dao.write(mt_status, mt_title, ex_info, mt_viewdate, mt_gender, mt_age, mt_content);
				System.out.println("글쓰기결과:"+ result);
				
				//글쓰기가 완료되면 목록으로 이동한다. 
				return "redirect:mateList";    
		} 
		catch (Exception e) {
			 System.out.println("업로드 실패");
		        e.printStackTrace();
		        return "redirect:/mateList"; 
		}
	}
	 
	 
	//상세보기 페이지 로딩
	 @GetMapping("/mateView") public String mateView() { return "/mate/view"; }
	 //@GetMapping("/mateView") public String mateWiewGet(Model model) { return
	 //"mate/wiew"; }
	 
	
	 
	 //글쓰기 처리 
	/*
	 * @PostMapping("/write.do") public String boardWritePost(Model model,
	 * HttpServletRequest req) { //request 내장객체를 통해 폼값을 받아온다. String name =
	 * req.getParameter("name"); String title = req.getParameter("title"); String
	 * content = req.getParameter("content"); //폼값을 개별적으로 전달한다. int result =
	 * dao.write(name, title, content); System.out.println("글쓰기결과:"+ result); //글쓰기가
	 * 완료되면 목록으로 이동한다. return "redirect:list.do"; }
	 */
	
	/*
	 * @RequestMapping("/view.do") public String boardView(Model model, mateDTO
	 * mateDTO) { mateDTO = dao.view(mateDTO);
	 * mateDTO.setContent(mateDTO.getContent() .replace("\r\n","<br/>"));
	 * model.addAttribute("mateDTO", mateDTO); return "view"; }
	 * 
	 * @GetMapping("/edit.do") public String boardEditGet(Model model, BoardDTO
	 * boardDTO) { boardDTO = dao.view(boardDTO); model.addAttribute("boardDTO",
	 * boardDTO); return "edit"; }
	 * 
	 * @PostMapping("/edit.do") public String boardEditPost(BoardDTO boardDTO) { int
	 * result = dao.edit(boardDTO); System.out.println("글수정결과:"+ result); return
	 * "redirect:view.do?idx="+ boardDTO.getIdx(); }
	 * 
	 * @PostMapping("/delete.do") public String boardDeletePost(HttpServletRequest
	 * req) { int result = dao.delete(req.getParameter("idx"));
	 * System.out.println("글삭제결과:"+ result); return "redirect:list.do"; }
	 */
}
 