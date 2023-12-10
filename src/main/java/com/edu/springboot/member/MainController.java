package com.edu.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.smtp.RegisterMail;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


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
	public int loginCheck(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpServletRequest req, HttpServletResponse rsp) {
		HttpSession session = req.getSession();
		MemberDTO memberDTO = new MemberDTO();
		
		memberDTO.setUser_id(id);
		memberDTO.setUser_pass(pw);
		int result = dao.loginCheck(memberDTO);
		if(result == 1) {
			MemberDTO member = dao.selectOne(memberDTO);
              
			session.setAttribute("userId", member.getUser_id());
			session.setAttribute("userPass", member.getUser_pass());
			session.setAttribute("userName", member.getUser_name());
			session.setAttribute("userEmail", member.getUser_email());
			session.setAttribute("userGender", member.getUser_gender());
			session.setAttribute("userImg", member.getUser_image());
			session.setAttribute("userType", member.getUser_type());
		}
		return result;
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
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
	
	//회원삭제
	@RequestMapping(value="/admin/accountUser/delete", method=RequestMethod.POST)
	public String adminDeleteMember(MemberDTO memberDTO) {
		dao.delete(memberDTO);
		return "/admin/accountUser";
	}
	
	//회원정보 수정
	@RequestMapping(value="/mypage", method=RequestMethod.POST)
	public String modifyMember(MemberDTO memberDTO, HttpServletRequest req) {
		HttpSession session = req.getSession();
		int result = dao.update(memberDTO);
		if(result==1) {
			
			System.out.println("회원정보 수정이 완료되었습니다.");
			session.setAttribute("userPass", memberDTO.getUser_pass());
			session.setAttribute("userName", memberDTO.getUser_name());
			session.setAttribute("userEmail", memberDTO.getUser_email());
			session.setAttribute("userGender", memberDTO.getUser_gender());
			session.setAttribute("userImg", memberDTO.getUser_image());
		}
		return "mypage";
	}
	
	//회원탈퇴
	@RequestMapping(value="/mypage/delete", method=RequestMethod.POST)
	public String deleteMember(MemberDTO memberDTO, HttpSession session) {
		session.invalidate();
		dao.delete(memberDTO);
		return "mypage";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}
	

	/*
	 * @GetMapping("/mateList") public String mateList() { return "/mate/list"; }
	 * 
	 * @GetMapping("/mateView") public String mateView() { return "/mate/view"; }
	 * 
	 * @GetMapping("/mateWrite") public String mateWrite() { return "/mate/write"; }
	 */
	
	
	@GetMapping("/idFind")
	public String idFind() {
		return "/idFind";
	}
	@GetMapping("/pwFind")
	public String pwFind() {
		return "/pwFind";
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
	
	@RequestMapping(value="/admin/accountUser", method=RequestMethod.POST)
	public String search(MemberDTO memberDTO, Model model) throws Exception {
		model.addAttribute("memberList", dao.search(memberDTO));
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
