package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.dao.ReplyDAO;
import com.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private ReplyDAO rdao;

	// 게시물 등록
	@Override
	public void insertBoard(int userIdx, String boardSubject, String boardTitle, String boardContents) {
		dao.insertBoard(userIdx, boardSubject, boardTitle, boardContents);
	}

	// 모든 게시물 가져오기
	@Override
	public List<BoardVO> selectAllBoard(int startNum) {
		return dao.selectAllBoard(startNum);
	}
	
	// 모든 게시물 인기순으로 가져오기
	@Override
	public List<BoardVO> selectAllBoardPopularity(int startNum) {
		return dao.selectAllBoardPopularity(startNum);
		
	}

	// 한개의 게시물 가져오기
	@Override
	public BoardVO selectOneInfo(int boardIdx) {
		return dao.selectOneInfo(boardIdx);
	}
	
	// 검색한 단어가 포함된 게시물 가져오기
	@Override
	public List<BoardVO> selectSearch(String word, int startNum) {
		return dao.selectSearch(word, startNum);
	}

	// 조회수 +1
	@Override
	public void updateViews(int boardIdx) {
		dao.updateViews(boardIdx);
	}

	// 게시물 삭제
	@Override
	public void deleteBoard(int boardIdx) {
		dao.deleteBoard(boardIdx);
		rdao.deleteBoardReply(boardIdx);
	}

	// 게시물 수정
	@Override
	public void updateBoard(String boardSubject, String boardTitle, String boardContents, int boardIdx) {
		dao.updateBoard(boardSubject, boardTitle, boardContents, boardIdx);

	}

	// 모든 게시물 페이지 개수
	@Override
	public int selectPageNumAll() {
		return dao.selectPageNumAll();
	}
	
	// 검색된 게시물 페이지 개수
	@Override
	public int selectPageNumSearch(String word) {
		return dao.selectPageNumSearch(word);
	}

	// 유저가 작성한 모든 게시물들
	@Override
	public List<BoardVO> selectBoardByUser(int userIdx) {
		return dao.selectBoardByUser(userIdx);
	}
	
	
}
