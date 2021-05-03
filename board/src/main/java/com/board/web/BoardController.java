package com.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.BoardService;
import com.board.service.JsonEcDcService;
import com.board.service.ReplyService;
import com.board.vo.BoardVO;
import com.board.vo.ReplyVO;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReplyService replyService;

	@Autowired
	private JsonEcDcService jsonService;

	// 게시물 작성 페이지
	@RequestMapping(value = "/writeBoard")
	public String writeBoardPage(@RequestParam(required = false) String boardIdx, HttpSession session, Model model) {

		if (boardIdx == null) {
			session.setAttribute("boardIdx", null);
		} else {
			session.setAttribute("boardIdx", boardIdx);
			BoardVO bvo = boardService.selectOneInfo(Integer.parseInt(boardIdx));
			model.addAttribute("boardInfo", bvo);
		}
		return "writeBoard";
	}

	// 게시물 등록
	@ResponseBody
	@PostMapping("/board")
	public Map postBoard(@RequestBody String str) {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);

		int userIdx = (int) (long) obj.get("userIdx");
		String boardSubject = (String) obj.get("boardSubject");
		String boardTitle = (String) obj.get("boardTitle");
		String boardContents = (String) obj.get("boardContents");

		boardService.insertBoard(userIdx, boardSubject, boardTitle, boardContents);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}

	// 게시물 수정
	@ResponseBody
	@PutMapping("/board")
	public Map putBoard(@RequestBody String str) {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);

		String boardSubject = (String) obj.get("boardSubject");
		String boardTitle = (String) obj.get("boardTitle");
		String boardContents = (String) obj.get("boardContents");
		int boardIdx = (int) (long) obj.get("boardIdx");

		System.out.println(str);

		boardService.updateBoard(boardSubject, boardTitle, boardContents, boardIdx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}

	// 게실물 삭제
	@ResponseBody
	@DeleteMapping("/board")
	public Map deleteBoard(@RequestBody String str) {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		int boardIdx = (int) (long) obj.get("boardIdx");

		// 선택한 게시물 삭제
		boardService.deleteBoard(boardIdx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}

	// 게시물 내용 가져오기
	@GetMapping("/board")
	public String getBoardInfoPre(@RequestParam int boardIdx, @RequestParam int userIdx, HttpSession session) {
		
		boardService.updateViews(boardIdx);

		session.setAttribute("writerIdx", userIdx);

		return "redirect:boardDetail?boardIdx=" + boardIdx;
	}

	// 게시물 내용 가져오기
	@GetMapping("/boardDetail")
	public String getBoardInfo(Model model, @RequestParam int boardIdx, HttpSession session) {

		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		
		// 게시물 정보
		BoardVO bvo = boardService.selectOneInfo(boardIdx);
		model.addAttribute("boardInfo", bvo);
		
		// 댓글 리스트
		List<ReplyVO> list = replyService.selectReply(boardIdx,userIdx);
		model.addAttribute("list", list);
		
		if(bvo.getUserIdx() == userIdx){
			model.addAttribute("compare", 1);
		}else {
			model.addAttribute("compare", 0);
		}
		
		return "boardDetail";
	}

	

}
