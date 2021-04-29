package com.board.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.service.BoardService;
import com.board.vo.BoardVO;

@Controller
public class HomeController {
	
	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "/")
	public String home(Model model, HttpSession session) {
		
		session.invalidate();
		
		List<BoardVO> list = boardService.selectAllBoard();
		model.addAttribute("list", list);

		return "main";
	}
	
	@RequestMapping(value = "/main")
	public String main(Model model, HttpSession session, @RequestParam int userIdx) {
		
		List<BoardVO> list = boardService.selectAllBoard();
		model.addAttribute("list", list);
		
		session.setAttribute("userIdx",userIdx);
		
		return "main";
	}
	
	
}
