package com.board.vo;

import lombok.Data;

@Data
public class BoardVO {

	private int boardIdx;
	private int userIdx;
	private String boardTitle;
	private int boardViews;
	private int boardComments;
	private String boardDateTime;
}
