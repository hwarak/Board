package com.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.JsonEcDcService;
import com.board.service.ReplyService;
import com.board.vo.BoardVO;
import com.board.vo.ReplyVO;

@Controller
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	@Autowired
	private JsonEcDcService jsonService;

	@ResponseBody
	@PostMapping("/reply")
	public Map insertReply(@RequestBody String str) {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		String replyContents = (String) obj.get("replyContents");
		int userIdx = (int) (long) obj.get("userIdx");
		int boardIdx = (int) (long) obj.get("boardIdx");
		int replySecret = (int) (long) obj.get("replySecret");
		int replyRecipient = (int) (long) obj.get("replyRecipient");

		// 댓글 등록
		replyService.insertReply(replyContents, userIdx, boardIdx, replySecret, replyRecipient);

		// 댓글 개수 플러스
		replyService.updateReplyPlus(boardIdx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}

	// 게시판 정렬
	@GetMapping("/reply")
	public String mainSort(HttpSession session,Model model,@RequestParam int boardIdx,@RequestParam int writer) {
		
		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		
		// 댓글 리스트
		List<ReplyVO> list = replyService.selectReply(boardIdx, userIdx);
		model.addAttribute("list", list);

		if (writer == userIdx) {
			model.addAttribute("compare", 1);
		} else {
			model.addAttribute("compare", 0);
		}

		model.addAttribute("list", list);

		return "replyListAjax";
	}

}
