package com.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.board.vo.BoardVO;

@Service
public interface BoardService {

	// 게시물 등록
	public void insertBoard(int userIdx, String boardSubject, String boardTitle, String boardContents);

	// 모든 게시물 가져오기
	public List<BoardVO> selectAllBoard();

	// 한개의 게시물 가져오기
	public BoardVO selectOneInfo(int boardIdx);

	// 조회수 +1
	public void updateViews(int boardIdx);

	// 댓글수 +1
	public void updateCommentsPlus(int boardIdx);

	// 댓글수 -1
	public void updateCommentsMinus(int boardIdx);
}
