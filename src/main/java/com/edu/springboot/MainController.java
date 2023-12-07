package com.edu.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	@GetMapping("/join")
	public String join() {
		return "join";
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
	
	/*
	 * @GetMapping("/mateList") public String mateList() { return "/mate/list"; }
	 * 
	 * @GetMapping("/mateView") public String mateView() { return "/mate/view"; }
	 * 
	 * @GetMapping("/mateWrite") public String mateWrite() { return "/mate/write"; }
	 */
	
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
	@GetMapping("/admin/accountUser")
	public String accountUser() {
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
