package com.board.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.JsonEcDcService;
import com.board.service.UserService;
import com.board.vo.UserInfoVO;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private JsonEcDcService jsonService;

	@GetMapping(value = "/userInfo")
	public String userInfoPage(HttpSession session, Model model) {

		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		UserInfoVO uivo = userService.selectUserInfo(userIdx);
		model.addAttribute("userInfo", uivo);

		return "userInfo";
	}

	// 회원 탈퇴
	@ResponseBody
	@DeleteMapping("/user")
	public Map deleteUser(HttpSession session) {

		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		userService.deleteUser(userIdx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}

	// 정보 업데이트
	@ResponseBody
	@PutMapping("/user")
	public Map updateUser(HttpSession session, @RequestBody String str) {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		String userNickname = (String) obj.get("userNickname");
		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = userService.nickCheck(userNickname);
		
		
		if (result == 1) {
			map.put("result", "no");
		}else {
			map.put("result", "ok");
			userService.updateNickname(userNickname, userIdx);
		}

		map.put("result", "ok");

		return map;
	}
}
