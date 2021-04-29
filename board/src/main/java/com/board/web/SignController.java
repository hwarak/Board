package com.board.web;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.JsonEcDcService;
import com.board.service.UserService;
import com.board.vo.UserVO;

@Controller
public class SignController {

	@Autowired
	private UserService userService;

	@Autowired
	private JsonEcDcService jsonService;

	@RequestMapping(value = "/signIn")
	public String signInPage() {

		return "signIn";
	}

	@RequestMapping(value = "/signUp")
	public String signUpPage() {

		return "signUp";
	}

	@ResponseBody
	@PostMapping(value = "/signIn/checkIdPw")
	public Map signIn(@RequestBody String str) {
		
		System.out.println(str);

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		String userId = (String) obj.get("userId");
		String userPw = (String) obj.get("userPw");
		
		

		// 로그인 성공이면 유저 번호 반환
		// 로그인 실패면 0을 반환
		int result = userService.checkIdPw(userId, userPw);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

	@PostMapping(value = "/signUp")
	public String signUp(UserVO uvo) {
		userService.insertUser(uvo.getUserId(), uvo.getUserPw(), uvo.getUserNickname());
		return "signIn";
	}

	@ResponseBody
	@PostMapping("/signUp/idCheck")
	public Map checkId(@RequestBody String str) {
		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		String userId = (String) obj.get("userId");

		// 아이디가 이미 존재하는지 확인
		// 1 = 이미 있는 아이디, 가입 불가능
		// 0 = 존재하지 않는 아이디, 가입 가능
		int result = userService.idCheck(userId);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

	@ResponseBody
	@PostMapping("/signUp/nickCheck")
	public Map checkNickname(@RequestBody String str) {
		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		String userNickname = (String) obj.get("userNickname");
		// 닉네임이 이미 존재하는지 확인
		// 1 = 이미 있는 아이디, 가입 불가능
		// 0 = 존재하지 않는 아이디, 가입 가능
		int result = userService.nickCheck(userNickname);
		if (result == 1)
			result = 2; // 아이디와 구분

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

}
