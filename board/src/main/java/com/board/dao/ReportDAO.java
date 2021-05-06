package com.board.dao;

import java.util.List;

import com.board.vo.ReportVO;

public interface ReportDAO {
	
	// 신고 등록
	public void insertReport(String reportSubject, String reportTitle, String reportContents, int userIdx, int boardIdx);
	
	// 신고 목록 삭제
	public void deleteReport(int boardIdx);
	
	// 종류별 신고 리스트
	public List<ReportVO> selectReport(String reportSubject);

 
}