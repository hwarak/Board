package com.board.vo;

import lombok.Data;

@Data
public class CommentVO {

	private int commentIdx;
	private String commtentContents;
	private int userIdx;
	private int boardIdx;
	private int commentSecreat;
	private int commetRecipient;
}
