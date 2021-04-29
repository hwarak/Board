package com.board.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.service.BoardService;
import com.board.vo.BoardVO;

@Controller
public class HomeController {

	@Autowired
	private BoardService boardService;

	@GetMapping(value = "/")
	public String home(Model model, HttpSession session) {

		session.invalidate();

		List<BoardVO> list = boardService.selectAllBoard(0);
		model.addAttribute("list", list);

		return "main";
	}

	@GetMapping(value = "/main")
	public String main(Model model, HttpSession session, @RequestParam int userIdx) {

		List<BoardVO> list = boardService.selectAllBoard(0);
		model.addAttribute("list", list);

		session.setAttribute("userIdx", userIdx);

		return "main";
	}

	// 게시물 검색하기
	@GetMapping("/main/popularity")
	public String getPopularity(Model model) {

		List<BoardVO> list = boardService.selectAllBoard(0);
		model.addAttribute("list", list);
		
		return "main";
	}

	// 게시물 검색하기
	@GetMapping("/main/search")
	public String getSearch(@RequestParam String word, Model model) {

		System.out.println(word);

		List<BoardVO> list = boardService.selectSearch(word, 0);

		model.addAttribute("list", list);

		return "main";
	}

	// 게시물 검색하기
	@GetMapping("/main/search/popularity")
	public String getSearchPopularity() {


		return "main";
	}

	
}
