package com.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.board.vo.ReportVO;

@Service
public interface ReportService {

	// 신고 등록
	public void insertReport(String reportSubject, String reportTitle, String reportContents, int userIdx, int boardIdx);

	// 종류별 신고 리스트
	public List<ReportVO> selectReport(String reportSubject);
}
