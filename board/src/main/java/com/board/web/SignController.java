package com.board.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.UserService;
import com.board.vo.UserVO;

@Controller
public class SignController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/signIn")
	public String signInPage() {

		return "signIn";
	}

	@RequestMapping(value = "/signUp")
	public String signUpPage() {

		return "signUp";
	}

	@ResponseBody
	@GetMapping(value = "/signIn/checkIdPw")
	public int signIn(@RequestParam String userId,@RequestParam String userPw) {
		// 로그인 성공이면 유저 번호 반환
		// 로그인 실패면 0을 반환
		int result = userService.checkIdPw(userId,userPw);
		return result;
	}

	@PostMapping(value = "/signUp")
	public String signUp(UserVO uvo) {
		userService.insertUser(uvo.getUserId(), uvo.getUserPw(), uvo.getUserNickname());
		return "signIn";
	}

	@ResponseBody
	@GetMapping(value = "/signUp/idCheck")
	public int checkId(@RequestParam String userId) {
		// 아이디가 이미 존재하는지 확인
		// 1 = 이미 있는 아이디, 가입 불가능
		// 0 = 존재하지 않는 아이디, 가입 가능
		int result = userService.idCheck(userId);
		return result;
	}

	@ResponseBody
	@GetMapping(value = "/signUp/nickCheck")
	public int checkNickname(@RequestParam String userNickname) {
		// 닉네임이 이미 존재하는지 확인
		// 1 = 이미 있는 아이디, 가입 불가능
		// 0 = 존재하지 않는 아이디, 가입 가능
		int result = userService.nickCheck(userNickname);
		if (result == 1)
			result = 2; // 아이디와 구분
		return result;
	}

}
