package com.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.board.vo.ReplyVO;

public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSession sqlSession;

	// 댓글 등록
	@Override
	public void insertReply(String replyContents, int userIdx, int boardIdx, int replySecret, int replyRecipient) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("replyContents", replyContents);
		map.put("userIdx", userIdx);
		map.put("boardIdx", boardIdx);
		map.put("replySecret", replySecret);
		map.put("replyRecipient", replyRecipient);
		sqlSession.insert("com.board.mappers.ReplyMapper.insertReply",map);

	}

	// 댓글 삭제
	@Override
	public void deleteReply(int replyIdx) {
		sqlSession.delete("com.board.mappers.ReplyMapper.deleteReply", replyIdx);
	}
	
	
	// 게시물 삭제시 해당 게시물에 달린 댓글들 삭제
	@Override
	public void deleteBoardReply(int boardIdx) {
		sqlSession.delete("com.board.mappers.ReplyMapper.deleteBoardReply", boardIdx);
	}

	// 댓글 업데이트
	@Override
	public void updateReply(String replyContents, int replySecret) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("replyContents", replyContents);
		map.put("replySecret", replySecret);
		sqlSession.update("com.board.mappers.ReplyMapper.updateReply", map);

	}

	// 댓글 최신순으로 불러오기
	@Override
	public List<ReplyVO> selectReply(int boardIdx,int userIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardIdx", boardIdx);
		map.put("userIdx", userIdx);
		List<ReplyVO> list = sqlSession.selectList("com.board.mappers.ReplyMapper.selectReply", map);
		return list;

	}
	
	// 댓글수 +1
	@Override
	public void updateReplyPlus(int boardIdx) {
		sqlSession.update("com.board.mappers.ReplyMapper.updateReplyPlus", boardIdx);

	}

	// 댓글수 -1
	@Override
	public void updateReplyMinus(int boardIdx) {
		sqlSession.update("com.board.mappers.ReplyMapper.updateReplyMinus", boardIdx);

	}


}
