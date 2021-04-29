package com.board.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.service.BoardService;
import com.board.vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "/writeBoard")
	public String writeBoardPage() {

		return "writeBoard";
	}

	@PostMapping("/board")
	public String postBoard(HttpSession session, BoardVO bvo) {

		int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
		boardService.insertBoard(userIdx, bvo.getBoardSubject(), bvo.getBoardTitle(), bvo.getBoardContents());

		return "redirect:main?userIdx="+userIdx;
	}
	
	@RequestMapping("/board")
	public String getBoardInfo(Model model, @RequestParam int boardIdx) {
		
		boardService.updateViews(boardIdx);
		
		BoardVO bvo = boardService.selectOneInfo(boardIdx);
		model.addAttribute("boardInfo", bvo);
		
		
		return "boardDetail";
	}

}
