package com.board.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.board.service.UserService;
import com.board.vo.UserInfoVO;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@GetMapping(value = "/userInfo")
	public String userInfoPage(HttpSession session, Model model) {

		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		UserInfoVO uivo = userService.selectUserInfo(userIdx);
		
		model.addAttribute("userInfo",uivo);
		
		return "userInfo";
	}
}
