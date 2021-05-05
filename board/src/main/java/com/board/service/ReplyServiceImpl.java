package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.ReplyDAO;
import com.board.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO dao;

	// 댓글 등록
	@Override
	public void insertReply(String replyContents, int userIdx, int boardIdx, int replySecret, int replyRecipient) {
		dao.insertReply(replyContents, userIdx, boardIdx, replySecret, replyRecipient);

	}

	// 댓글 삭제
	@Override
	public void deleteReply(int replyIdx) {
		dao.deleteReply(replyIdx);
	}

	// 댓글 업데이트
	@Override
	public void updateReply(String replyContents, int replySecret) {
		dao.updateReply(replyContents, replySecret);

	}

	// 댓글 최신순으로 불러오기
	@Override
	public List<ReplyVO> selectReply(int boardIdx,int userIdx) {
		List<ReplyVO> list = dao.selectReply(boardIdx,userIdx);
		return list;

	}

	// 댓글수 +1
	@Override
	public void updateReplyPlus(int boardIdx) {
		dao.updateReplyPlus(boardIdx);

	}

	// 댓글수 -1
	@Override
	public void updateReplyMinus(int boardIdx) {
		dao.updateReplyMinus(boardIdx);

	}
	
	// 유저가 작성한 댓글들
	@Override
	public List<ReplyVO> selectReplyByUser(int userIdx) {
		return dao.selectReplyByUser(userIdx);
	}
}
