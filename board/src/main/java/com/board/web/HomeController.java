package com.board.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

	@RequestMapping(value = "/")
	public String home(HttpSession session) {
		
		session.invalidate();

		return "main";
	}
	
	@RequestMapping(value = "/main")
	public String main(HttpSession session, @RequestParam int userIdx) {
		
		session.setAttribute("userIdx",userIdx);
		
		return "main";
	}
	
	
}
