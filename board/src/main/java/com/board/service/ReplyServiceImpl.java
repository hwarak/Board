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
	public List<ReplyVO> selectReply(int boardIdx) {
		List<ReplyVO> list = dao.selectReply(boardIdx);
		return list;

	}

}
