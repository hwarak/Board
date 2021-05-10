package com.board.web;

import java.util.ArrayList;
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
	public String home(Model model, HttpSession session, @RequestParam(required = false) String pageNum) {

		session.invalidate();
		System.out.println("세션 무효화!");

		int allPage = boardService.selectPageNumAll();
		int startNum = 0;

		if (pageNum != null) {
			startNum = Integer.parseInt(pageNum) * 10 - 10;
		}

		List<BoardVO> list = boardService.selectAllBoard(startNum);

		model.addAttribute("list", list);
		model.addAttribute("allPage", allPage);

		return "main";
	}

	@GetMapping(value = "/main")
	public String main(Model model, HttpSession session, @RequestParam int userIdx,
			@RequestParam(required = false) String pageNum) {

		int allPage = boardService.selectPageNumAll();
		int startNum = 0;

		if (pageNum != null) {
			startNum = Integer.parseInt(pageNum) * 10 - 10;
		}

		List<BoardVO> list = boardService.selectAllBoard(startNum);

		model.addAttribute("list", list);
		model.addAttribute("allPage", allPage);

		session.setAttribute("userIdx", userIdx);

		return "main";
	}

	// 게시판 정렬
	@GetMapping("/sort")
	public String mainSort(HttpSession session, @RequestParam int sortNum, Model model,
			@RequestParam(required = false) String pageNum) {

		int allPage = boardService.selectPageNumAll();
		int startNum = 0;

		if (pageNum != null) {
			startNum = Integer.parseInt(pageNum) * 10 - 10;
		}

		List<BoardVO> list = new ArrayList<>();

		if (sortNum == 1) {
			session.setAttribute("sort", 1);
			list = boardService.selectAllBoard(startNum);
		} else if (sortNum == 2) {
			session.setAttribute("sort", 2);
			list = boardService.selectAllBoardPopularity(startNum);
		}

		model.addAttribute("list", list);
		model.addAttribute("allPage", allPage);

		return "indexListAjax";
	}

	// 게시물 검색하기
	@GetMapping("/search")
	public String getSearch(@RequestParam String word, Model model, @RequestParam(required = false) String pageNum) {

		int allPage = boardService.selectPageNumSearch(word);
		int startNum = 0;

		if (pageNum != null) {
			startNum = Integer.parseInt(pageNum) * 10 - 10;
		}

		List<BoardVO> list = boardService.selectSearch(word, startNum);

		model.addAttribute("allPage", allPage);
		model.addAttribute("list", list);

		return "main";
	}
}
