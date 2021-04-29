package com.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.board.vo.BoardVO;

public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSession sqlSession;

	// 게시물 등록
	@Override
	public void insertBoard(int userIdx, String boardSubject, String boardTitle, String boardContents) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", userIdx);
		map.put("boardSubject", boardSubject);
		map.put("boardTitle", boardTitle);
		map.put("boardContents", boardContents);
		sqlSession.insert("com.board.mappers.Boardmapper.insertBoard", map);

	}

	// 모든 게시물 가져오기
	@Override
	public List<BoardVO> selectAllBoard() {
		List<BoardVO> list = sqlSession.selectList("com.board.mappers.Boardmapper.selectAllBoard");
		return list;
	}

	// 한개의 게시물 가져오기
	@Override
	public BoardVO selectOneInfo(int boardIdx) {
		BoardVO bavo = sqlSession.selectOne("com.board.mappers.Boardmapper.selectOneInfo", boardIdx);
		return bavo;
	}

	// 조회수 +1
	@Override
	public void updateViews(int boardIdx) {
		sqlSession.update("com.board.mappers.Boardmapper.updateViews", boardIdx);

	}

	// 댓글수 +1
	@Override
	public void updateCommentsPlus(int boardIdx) {
		sqlSession.update("com.board.mappers.Boardmapper.updateCommentsPlus", boardIdx);

	}

	// 댓글수 -1
	@Override
	public void updateCommentsMinus(int boardIdx) {
		sqlSession.update("com.board.mappers.Boardmapper.updateCommentsMinus", boardIdx);

	}

	// 게시물 삭제
	@Override
	public void deleteBoard(int boardIdx) {
		sqlSession.delete("com.board.mappers.Boardmapper.deleteBoard", boardIdx);

	}

	// 게시물 수정
	@Override
	public void updateBoard(String boardSubject, String boardTitle, String boardContents, int boardIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardSubject", boardSubject);
		map.put("boardTitle", boardTitle);
		map.put("boardContents", boardContents);
		map.put("boardIdx", boardIdx);
		sqlSession.update("com.board.mappers.Boardmapper.updateBoard", map);

	}

}
