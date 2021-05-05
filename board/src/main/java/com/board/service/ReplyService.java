package com.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.board.vo.ReplyVO;

@Service
public interface ReplyService {

	// 댓글 등록
	public void insertReply(String replyContents, int userIdx, int boardIdx, int replySecret, int replyRecipient);

	// 댓글 삭제
	public void deleteReply(int replyIdx);

	// 댓글 수정
	public void updateReply(String replyContents, int replySecret);

	// 댓글 최신순으로 불러오기
	public List<ReplyVO> selectReply(int boardIdx, int userIdx);

	// 댓글수 +1
	public void updateReplyPlus(int boardIdx);

	// 댓글수 -1
	public void updateReplyMinus(int boardIdx);

	// 유저가 작성한 댓글들
	public List<ReplyVO> selectReplyByUser(int userIdx);

}
