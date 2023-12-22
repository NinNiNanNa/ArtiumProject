package com.edu.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	IAdminService dao;
	
	
	@GetMapping("/admin")
	public String adminLogin() {
		return "/admin/adminLogin";
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
	@RequestMapping(value="/admin/accountAdmin", method=RequestMethod.POST)
	public String adminsearch(AdminDTO adminDTO, Model model) throws Exception {
		model.addAttribute("adminList", dao.adminsearch(adminDTO));
		return "/admin/accountAdmin";
	}
	
	//관리자정보 수정
	@RequestMapping(value="/admin/accountAdmin/update", method=RequestMethod.POST)
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
		return "/admin/accountAdmin";
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
	
	@GetMapping("/admin/exComments")
	public String exComments() {
		return "/admin/exComments";
	}
	@GetMapping("/admin/exList")
	public String exList() {
		return "/admin/exList";
	}
	
// 구현 완료 후 삭제예정 +_+
//	@GetMapping("/admin/mtComments")
//	public String mtComments() {
//		return "/admin/mtComments";
//	}
//	@GetMapping("/admin/mtList")
//	public String mtList() {
//		return "/admin/mtList";
//	}
}
