package com.board.vo;

import lombok.Data;

@Data
public class ReportVO {
	
	private int reportIdx;
	private String reportSubject;
	private String reportTitle;
	private String reportContents;
	private String reportDate;
	private int userIdx;
	private int boardIdx;
	private String boardSubject;
	private String boardTitle;
	
}
