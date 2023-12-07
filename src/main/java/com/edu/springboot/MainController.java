package com.edu.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.jdbc.IMemberService;
import com.edu.springboot.jdbc.MemberDTO;
import com.edu.springboot.smtp.RegisterMail;


@Controller
public class MainController {
	
	@Autowired
	IMemberService dao;
	
	//회원가입 메일 서비스
	@Autowired
	RegisterMail registerMail;
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	//로그인
	@ResponseBody
	@RequestMapping(value="/login/loginCheck", method=RequestMethod.POST)
	public int loginCheck(@RequestParam("id") String id,
			@RequestParam("pw") String pw) {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setUser_id(id);
		memberDTO.setUser_pass(pw);
		int result = dao.loginCheck(memberDTO);
		return result;
	}
	
	//회원가입
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		return "join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join6(MemberDTO memberDTO) {
		int result = dao.insert(memberDTO);
		if(result==1) System.out.println("입력되었습니다.");
		return "login";
	}
	
	//아이디 중복 확인
	@ResponseBody
	@RequestMapping(value="/join/idCheck", method=RequestMethod.POST)
	public int idCheck(@RequestParam("id") String id) {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setUser_id(id);
		int cnt = dao.idCheck(memberDTO);
		return cnt;
	}
	
	//이메일 인증
	@ResponseBody
    @PostMapping(value = "/mail")
    public String mailConfirm(@RequestParam(name = "email") String email) throws Exception{
		System.out.println(email);
        String code = registerMail.sendSimpleMessage(email);
        System.out.println("사용자에게 발송한 인증코드 ==> " + code);

        return code;
    }
	
	//회원 삭제
	@RequestMapping(value="/admin/accountUser/delete", method=RequestMethod.POST)
	public String deleteMember(MemberDTO memberDTO) {
		dao.delete(memberDTO);
		return "/admin/accountUser";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}
	
	@GetMapping("/reviewList")
	public String reviewList() {
		return "/review/list";
	}
	@GetMapping("/reviewView")
	public String reviewView() {
		return "/review/view";
	}
	@GetMapping("/reviewWrite")
	public String reviewWrite() {
		return "/review/write";
	}
	
	@GetMapping("/mateList")
	public String mateList() {
		return "/mate/list";
	}
	@GetMapping("/mateView")
	public String mateView() {
		return "/mate/view";
	}
	@GetMapping("/mateWrite")
	public String mateWrite() {
		return "/mate/write";
	}
	
	@GetMapping("/galleryList")
	public String galleryList() {
		return "/gallery/list";
	}
	@GetMapping("/galleryView")
	public String galleryView() {
		return "/gallery/view";
	}
	@GetMapping("/galleryWrite")
	public String galleryWrite() {
		return "/gallery/write";
	}
	

	@GetMapping("/admin")
	public String adminLogin() {
		return "/admin/adminLogin";
	}
	@GetMapping("/adminMain")
	public String adminMain() {
		return "/admin/adminMain";
	}
	@GetMapping("/admin/accountAdmin")
	public String accountAdmin() {
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
	
	@GetMapping("/admin/exComments")
	public String exComments() {
		return "/admin/exComments";
	}
	@GetMapping("/admin/exList")
	public String exList() {
		return "/admin/exList";
	}
	@GetMapping("/admin/gaComments")
	public String gaComments() {
		return "/admin/gaComments";
	}
	@GetMapping("/admin/gaList")
	public String gaList() {
		return "/admin/gaList";
	}
	@GetMapping("/admin/mtComments")
	public String mtComments() {
		return "/admin/mtComments";
	}
	@GetMapping("/admin/mtList")
	public String mtList() {
		return "/admin/mtList";
	}
	@GetMapping("/admin/rvComments")
	public String rvComments() {
		return "/admin/rvComments";
	}
	@GetMapping("/admin/rvList")
	public String rvList() {
		return "/admin/rvList";
	}
	
	

}
