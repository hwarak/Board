package com.board.vo;

import lombok.Data;

@Data
public class BoardVO {

	private int boardIdx;
	private int userIdx;
	private String userNickname;
	private String boardSubject;
	private String boardTitle;
	private String boardContents;
	private String boardDate;
	private int boardViews;
	private int boardComments;
}
