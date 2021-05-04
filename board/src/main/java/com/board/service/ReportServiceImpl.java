package com.board.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.board.dao.ReportDAO;

public class ReportServiceImpl implements ReportService{

	@Autowired
	private ReportDAO dao;
	
	// 신고 등록하기
	@Override
	public void inserReport(int userIdx, int boardIdx, String reportSubject, String reportTitle, String reportContent) {
		dao.inserReport(userIdx, boardIdx, reportSubject, reportTitle, reportContent);
		
	}

	// 신고 삭제하기
	@Override
	public void deleteReport(int reportIdx) {
		dao.deleteReport(reportIdx);
		
	}
}
