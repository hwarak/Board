package com.board.vo;

import lombok.Data;

@Data
public class ReportVO {

	private int reportIdx;
	private int userIdx;
	private int boardIdx;
	private String reportSubject;
	private String reportTitle;
	private String reportContents;
}
