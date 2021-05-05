package com.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.BoardService;
import com.board.service.UserService;
import com.board.vo.BoardVO;
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

	
	@ResponseBody
	@DeleteMapping("/user")
	public Map deleteUser(HttpSession session) {
		
		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		userService.deleteUser(userIdx);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}
}
