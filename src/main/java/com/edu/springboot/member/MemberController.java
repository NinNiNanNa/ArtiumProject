package com.edu.springboot.member;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.smtp.IdFindMail;
import com.edu.springboot.smtp.PwFindMail;
import com.edu.springboot.smtp.RegisterMail;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.MyFunctions;


@Controller
public class MemberController {
	
	@Autowired
	IMemberService dao;
	
	//회원가입 메일 서비스
	@Autowired
	RegisterMail registerMail;
	
	//아이디 찾기 메일 서비스
	@Autowired
	IdFindMail idFindMail;
	
	//비밀번호 찾기 메일 서비스
	@Autowired
	PwFindMail pwFindMail;
	
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
	
	//회원정보 수정
//	@RequestMapping(value="/mypage", method=RequestMethod.GET)
//	public String modifygetMember(MemberDTO memberDTO, Model model) {
//		memberDTO = dao.selectOne(memberDTO);
//		model.addAttribute("memberDTO", memberDTO);
//		
//		System.out.println("불러? : "+memberDTO);
//		
//		return "mypage";
//	}
	
	//회원정보 수정
	@RequestMapping(value="/mypage", method=RequestMethod.POST)
	public String modifyMember(MemberDTO memberDTO, HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		try {
			//업로드 디렉토리의 물리적경로 얻어오기 
			String uploadDir = ResourceUtils
				.getFile("classpath:static/uploads/").toPath().toString();
			System.out.println("물리적경로:"+uploadDir);
			
			//전송된 첨부파일을 Part객체를 통해 얻어온다. 
			Part part = req.getPart("user_image");
			//파일명 확인을 위해 헤더값을 얻어온다. 
			String partHeader = part.getHeader("content-disposition");
		    System.out.println("partHeader="+ partHeader);
		    //헤더값에서 파일명 추출을 위해 문자열을 split()한다. 
		    String[] phArr = partHeader.split("filename=");
		    //따옴표를 제거한 후 원본파일명을 추출한다. 
		    String originalFileName = phArr[1].trim().replace("\"", "");
		    //전송된 파일이 있다면 서버에 저장한다. 
		    if (!originalFileName.isEmpty()) {				
				part.write(uploadDir+ File.separator +originalFileName);
			    //서버에 저장된 파일명을 중복되지 않는 이름으로 변경한다. 
			    String savedFileName = 
			    	MyFunctions.renameFile(uploadDir, originalFileName);
			    memberDTO.setUser_image(originalFileName);
			} else {
				 // 파일을 수정하지 않은 경우
    	        String savedFileName = req.getParameter("preview_img");
    	        memberDTO.setUser_image(savedFileName);
			}		
		}
		catch (Exception e) {
			System.out.println("업로드 실패");
		}

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
	
	
	//아이디 찾기
	@GetMapping("/idFind")
	public String idFind() {
		return "idFind";
	}
	
	@ResponseBody
	@RequestMapping(value="/idFind/searchId", method=RequestMethod.POST)
	public String searchId(@RequestParam("name") String name, @RequestParam("email") String email, HttpServletRequest req, HttpServletResponse rsp) throws Exception {
		MemberDTO memberDTO = new MemberDTO();
		String code;
		memberDTO.setUser_name(name);
		memberDTO.setUser_email(email);
		String result = dao.searchId(memberDTO);
		if(result == null) {
			code = null;
		} else {
			code = idFindMail.sendSimpleMessage(email, result);
			System.out.println("사용자에게 발송한 회원아이디 ==> " + code);
		}
		
		return code;
	}
	
	
	//비밀번호 찾기	
	@GetMapping("/pwFind")
	public String pwFind() {
		return "pwFind";
	}
	
	@ResponseBody
	@RequestMapping(value="/pwFind/searchPw", method=RequestMethod.POST)
	public String searchPw(@RequestParam("id") String id, @RequestParam("email") String email, HttpServletRequest req, HttpServletResponse rsp) throws Exception {
		MemberDTO memberDTO = new MemberDTO();
		String code;
		memberDTO.setUser_id(id);
		memberDTO.setUser_email(email);
		String result = dao.searchPw(memberDTO);
		if(result == null) {
			code = null;
		} else {
			code = pwFindMail.sendSimpleMessage(email, result);
			System.out.println("사용자에게 발송한 회원비밀번호 ==> " + code);
		}
		
		return code;
	}

	
	


}
