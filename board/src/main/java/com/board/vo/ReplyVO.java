package com.board.vo;

import lombok.Data;

@Data
public class ReplyVO {

	private int replyIdx;
	private String replyContents;
	private int userIdx;
	private int boardIdx;
	private String boardSubject;
	private String boardTitle;
	private int replySecret;
	private int replyRecipient;
	private String replyDate;
	private String userNickname;
	private int compare;
}
