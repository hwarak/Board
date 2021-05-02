package com.board.web;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.JsonEcDcService;
import com.board.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private JsonEcDcService jsonService;
	
	@ResponseBody
	@PostMapping("/reply")
	public Map insertReply(@RequestBody String str) {
		System.out.println(str);
		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		System.out.println(obj);
		String replyContents = (String) obj.get("replyContents"); 
		int userIdx = (int)(long) obj.get("userIdx");
		int boardIdx = (int)(long) obj.get("boardIdx");
		int replySecret = (int)(long) obj.get("replySecret");
		int replyRecipient = (int)(long) obj.get("replyRecipient");
		
		// 댓글 등록
		replyService.insertReply(replyContents, userIdx, boardIdx, replySecret, replyRecipient);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");
		
		return map;
	}

}
