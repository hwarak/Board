package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.dao.ReplyDAO;
import com.board.dao.ReportDAO;
import com.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDao;
	
	@Autowired
	private ReplyDAO replyDao;
	
	@Autowired
	private ReportDAO reportDao;

	// 게시물 등록
	@Override
	public void insertBoard(int userIdx, String boardSubject, String boardTitle, String boardContents) {
		boardDao.insertBoard(userIdx, boardSubject, boardTitle, boardContents);
	}

	// 모든 게시물 가져오기
	@Override
	public List<BoardVO> selectAllBoard(int startNum) {
		return boardDao.selectAllBoard(startNum);
	}
	
	// 모든 게시물 인기순으로 가져오기
	@Override
	public List<BoardVO> selectAllBoardPopularity(int startNum) {
		return boardDao.selectAllBoardPopularity(startNum);
		
	}

	// 한개의 게시물 가져오기
	@Override
	public BoardVO selectOneInfo(int boardIdx) {
		return boardDao.selectOneInfo(boardIdx);
	}
	
	// 검색한 단어가 포함된 게시물 가져오기
	@Override
	public List<BoardVO> selectSearch(String word, int startNum) {
		return boardDao.selectSearch(word, startNum);
	}

	// 조회수 +1
	@Override
	public void updateViews(int boardIdx) {
		boardDao.updateViews(boardIdx);
	}

	// 게시물 삭제
	@Override
	public void deleteBoard(int boardIdx) {
		boardDao.deleteBoard(boardIdx); // 게시물 삭제
		replyDao.deleteBoardReply(boardIdx); // 해당 게시물 댓글 삭제
		reportDao.deleteReport(boardIdx); // 해당 게시물 신고 삭제
	}

	// 게시물 수정
	@Override
	public void updateBoard(String boardSubject, String boardTitle, String boardContents, int boardIdx) {
		boardDao.updateBoard(boardSubject, boardTitle, boardContents, boardIdx);

	}

	// 모든 게시물 페이지 개수
	@Override
	public int selectPageNumAll() {
		return boardDao.selectPageNumAll();
	}
	
	// 검색된 게시물 페이지 개수
	@Override
	public int selectPageNumSearch(String word) {
		return boardDao.selectPageNumSearch(word);
	}

	// 유저가 작성한 모든 게시물들
	@Override
	public List<BoardVO> selectBoardByUser(int userIdx) {
		return boardDao.selectBoardByUser(userIdx);
	}
	
	
}
