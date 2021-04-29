package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;

	// 게시물 등록
	@Override
	public void insertBoard(int userIdx, String boardSubject, String boardTitle, String boardContents) {
		dao.insertBoard(userIdx, boardSubject, boardTitle, boardContents);
	}

	// 모든 게시물 가져오기
	@Override
	public List<BoardVO> selectAllBoard() {
		return dao.selectAllBoard();
	}

	// 한개의 게시물 가져오기
	@Override
	public BoardVO selectOneInfo(int boardIdx) {
		return dao.selectOneInfo(boardIdx);
	}

	// 조회수 +1
	@Override
	public void updateViews(int boardIdx) {
		dao.updateViews(boardIdx);
		
	}

	// 조회수 +1
	@Override
	public void updateCommentsPlus(int boardIdx) {
		dao.updateCommentsPlus(boardIdx);
		
	}

	// 조회수 -1
	@Override
	public void updateCommentsMinus(int boardIdx) {
		dao.updateCommentsMinus(boardIdx);
		
	}
	
	
	

}
