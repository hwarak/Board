package com.board.dao;

import java.util.List;

import com.board.vo.ReplyVO;

public interface ReplyDAO {

	// 댓글 등록
	public void insertReply(String replyContents, int userIdx, int boardIdx, int replySecret, int replyRecipient);

	// 댓글 삭제
	public void deleteReply(int replyIdx);

	// 댓글 수정
	public void updateReply(String replyContents, int replySecret);

	// 댓글 최신순으로 불러오기
	public List<ReplyVO> selectReply(int boardIdx);

}
