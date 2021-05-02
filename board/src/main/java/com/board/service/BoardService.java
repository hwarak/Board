package com.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.board.vo.BoardVO;

@Service
public interface BoardService {

	// 게시물 등록
	public void insertBoard(int userIdx, String boardSubject, String boardTitle, String boardContents);

	// 모든 게시물 가져오기
	public List<BoardVO> selectAllBoard(int startNum);

	// 모든 게시물 인기순으로 가져오기
	public List<BoardVO> selectAllBoardPopularity(int startNum);

	// 한개의 게시물 가져오기
	public BoardVO selectOneInfo(int boardIdx);

	// 검색한 단어가 포함된 게시물 가져오기
	public List<BoardVO> selectSearch(String word, int startNum);

	// 조회수 +1
	public void updateViews(int boardIdx);

	// 댓글수 +1
	public void updateReplyPlus(int boardIdx);

	// 댓글수 -1
	public void updateReplyMinus(int boardIdx);

	// 게시물 삭제
	public void deleteBoard(int boardIdx);

	// 게시물 수정
	public void updateBoard(String boardSubject, String boardTitle, String boardContents, int boardIdx);

	// 모든 게시물 페이지 개수
	public int selectPageNumAll();

	// 검색된 게시물 페이지 개수
	public int selectPageNumSearch(String word);
}
