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
	public List<BoardVO> selectAllBoard(int startNum) {
		List<BoardVO> list = sqlSession.selectList("com.board.mappers.Boardmapper.selectAllBoard", startNum);
		return list;
	}
	
	// 모든 게시물 인기순으로 가져오기
	@Override
	public List<BoardVO> selectAllBoardPopularity(int startNum) {
		List<BoardVO> list = sqlSession.selectList("com.board.mappers.Boardmapper.selectAllBoardPopularity", startNum);
		return list;
	}

	// 한개의 게시물 가져오기
	@Override
	public BoardVO selectOneInfo(int boardIdx) {
		BoardVO bavo = sqlSession.selectOne("com.board.mappers.Boardmapper.selectOneInfo", boardIdx);
		return bavo;
	}

	// 검색한 단어가 포함된 게시물 가져오기
	@Override
	public List<BoardVO> selectSearch(String word, int startNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("word", "%"+word+"%");
		map.put("startNum",startNum);
		List<BoardVO> list = sqlSession.selectList("com.board.mappers.Boardmapper.selectSearch", map);
		return list;
	}

	// 조회수 +1
	@Override
	public void updateViews(int boardIdx) {
		sqlSession.update("com.board.mappers.Boardmapper.updateViews", boardIdx);

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

	// 모든 게시물 페이지 개수
	@Override
	public int selectPageNumAll() {
		return sqlSession.selectOne("com.board.mappers.Boardmapper.selectPageNumAll");
	}

	// 검색된 게시물 페이지 개수
	@Override
	public int selectPageNumSearch(String word) {
		return sqlSession.selectOne("com.board.mappers.Boardmapper.selectPageNumSearch",word);
	}

	// 유저가 작성한 모든 게시물들
	@Override
	public List<BoardVO> selectBoardByUser(int userIdx) {
		List<BoardVO> list = sqlSession.selectList("com.board.mappers.Boardmapper.selectBoardByUser",userIdx);
		return list;
	}
	
	

}
