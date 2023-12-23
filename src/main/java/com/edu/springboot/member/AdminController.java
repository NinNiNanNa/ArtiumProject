package com.edu.springboot.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	IAdminService dao;
	
	//관리자 로그인
	@GetMapping("/admin")
	public String adminLogin() {
		return "/admin/adminLogin";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/adminLogin", method=RequestMethod.POST)
	public int logincheck(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpServletRequest req, HttpServletResponse rsp) {
		HttpSession session = req.getSession();
		AdminDTO adminDTO = new AdminDTO();
		
		adminDTO.setAdmin_id(id);
		adminDTO.setAdmin_pass(pw);
		int result = dao.loginCheck(adminDTO);
		if(result == 1) {
			AdminDTO admin = dao.selectOne(adminDTO);
			
			session.setAttribute("adminName", admin.getAdmin_name());
			session.setAttribute("adminId", admin.getAdmin_id());
			session.setAttribute("adminPass", admin.getAdmin_pass());
			session.setAttribute("adminPhone", admin.getAdmin_phone());
		}
		return result;
	}
	
	@GetMapping("/adminMain")
	public String adminMain() {
		return "/admin/adminMain";
	}
	
	//관리자 가입
	@RequestMapping(value="/admin/accountAdmin/join", method=RequestMethod.POST)
	public String admininsert(AdminDTO adminDTO) throws Exception {
		int result = dao.admininsert(adminDTO);
		if(result==1) System.out.println("입력되었습니다.");
		return "redirect:/admin/accountAdmin";
	}
	
	//관리자 목록
	@GetMapping("/admin/accountAdmin")
	public String accountAdmin(Model model) {
		model.addAttribute("adminList", dao.adminselect());
		return "/admin/accountAdmin";
	}
	
	//관리자 검색
//	@RequestMapping(value="/admin/accountAdmin", method=RequestMethod.POST)
//	public String adminsearch(AdminDTO adminDTO, Model model) throws Exception {
//		model.addAttribute("adminList", dao.adminsearch(adminDTO));
//		return "/admin/accountAdmin";
//	}
	
	//관리자정보 수정페이지
	@RequestMapping("/adminInfoEdit.api")
	@ResponseBody
	public Map<String, Object> modifyAdminPage(@RequestParam("admin_id") String admin_id) throws Exception {
		Map<String, Object> maps = new HashMap<>();
		AdminDTO adminDTO = new AdminDTO();
		adminDTO.setAdmin_id(admin_id);
		adminDTO = dao.selectOne(adminDTO);
		maps.put("admin_id", adminDTO.getAdmin_id());
		maps.put("admin_pass", adminDTO.getAdmin_pass());
		maps.put("admin_name", adminDTO.getAdmin_name());
		maps.put("admin_phone", adminDTO.getAdmin_phone());
		maps.put("admin_regidate", adminDTO.getAdmin_regidate());
		System.out.println("관리자 수정: "+maps);
		return maps;
	}
	
	//관리자정보 수정페이지
//	@RequestMapping(value="/admin/accountAdmin", method=RequestMethod.POST)
//	public String modifyAdminPage(@RequestParam("admin_id") String admin_id, Model model) throws Exception {
//		AdminDTO adminDTO = new AdminDTO();
//		adminDTO.setAdmin_id(admin_id);
//		adminDTO = dao.selectOne(adminDTO);
//		model.addAttribute("admin_id", adminDTO.getAdmin_id());
//		model.addAttribute("admin_pass", adminDTO.getAdmin_pass());
//		model.addAttribute("admin_name", adminDTO.getAdmin_name());
//		model.addAttribute("admin_phone", adminDTO.getAdmin_phone());
//		model.addAttribute("admin_regidate", adminDTO.getAdmin_regidate());
//		return "/admin/accountAdmin";
//	}
//	
	//관리자정보 수정
	@RequestMapping(value="/admin/accountAdmin", method=RequestMethod.POST)
	public String modifyAdmin(AdminDTO adminDTO, HttpServletRequest req) {
		HttpSession session = req.getSession();
		int result = dao.update(adminDTO);
		if(result==1) {
			
			System.out.println("관리자정보 수정이 완료되었습니다.");
			session.setAttribute("adminName", adminDTO.getAdmin_name());
			session.setAttribute("adminId", adminDTO.getAdmin_id());
			session.setAttribute("adminPass", adminDTO.getAdmin_pass());
			session.setAttribute("adminPhone", adminDTO.getAdmin_phone());
		}
		return "redirect:/admin/accountAdmin";
	}
	
	
	//관리자 삭제
	@RequestMapping(value="/admin/accountAdmin/admindelete", method=RequestMethod.POST)
	public String admindelete(AdminDTO adminDTO) {
		dao.admindelete(adminDTO);
		return "/admin/accountAdmin";
	}
	
	@GetMapping("/admin/accountAuthor")
	public String accountAuthor() {
		return "/admin/accountAuthor";
	}
	
	//회원목록
	@RequestMapping("/admin/accountUser")
	public String accountUser(Model model) {
		model.addAttribute("memberList", dao.select());
		return "/admin/accountUser";
	}
	
	//회원검색
	@RequestMapping(value="/admin/accountUser", method=RequestMethod.POST)
	public String search(MemberDTO memberDTO, Model model) throws Exception {
		model.addAttribute("memberList", dao.search(memberDTO));
		return "/admin/accountUser";
	}
	
	//회원삭제
	@RequestMapping(value="/admin/accountUser/delete", method=RequestMethod.POST)
	public String adminDeleteMember(MemberDTO memberDTO) {
		System.out.println(memberDTO.getUser_id());
		dao.delete(memberDTO);
		return "/admin/accountUser";
	}
	
//	@GetMapping("/admin/exComments")
//	public String exComments() {
//		return "/admin/exComments";
//	}
//	@GetMapping("/admin/exList")
//	public String exList() {
//		return "/admin/exList";
//	}

}
