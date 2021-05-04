package com.board.service;

public interface ReportService {
	
	// 신고 등록하기
	public void inserReport(int userIdx, int boardIdx, String reportSubject, String reportTitle,String reportContent);
	
	// 신고 삭제하기
	public void deleteReport(int reportIdx);

}