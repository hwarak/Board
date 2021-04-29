package com.board.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.BoardService;
import com.board.service.JsonEcDcService;
import com.board.vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private JsonEcDcService jsonService;

	@RequestMapping(value = "/writeBoard")
	public String writeBoardPage() {

		return "writeBoard";
	}

	@PostMapping("/board")
	public String postBoard(HttpSession session, BoardVO bvo) {

		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		boardService.insertBoard(userIdx, bvo.getBoardSubject(), bvo.getBoardTitle(), bvo.getBoardContents());

		return "redirect:main?userIdx=" + userIdx;
	}

	@RequestMapping("/board")
	public String getBoardInfo(Model model, HttpServletRequest request, @RequestParam int boardIdx) {

		boardService.updateViews(boardIdx);

		BoardVO bvo = boardService.selectOneInfo(boardIdx);
		model.addAttribute("boardInfo", bvo);
		request.setAttribute("userIdx", bvo.getUserIdx());

		return "boardDetail";
	}

	@ResponseBody
	@DeleteMapping("/board")
	public Map deleteBoard(@RequestBody String str) throws Exception {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		int boardIdx = (int) (long) obj.get("boardIdx");

		// 선택한 게시물 삭제
		boardService.deleteBoard(boardIdx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}

}
