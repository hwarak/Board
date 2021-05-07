package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.ReportDAO;
import com.board.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDAO dao;

	// 댓글 등록
	@Override
	public void insertReport(String reportSubject, String reportTitle, String reportContents, int userIdx,
			int boardIdx) {
		dao.insertReport(reportSubject, reportTitle, reportContents, userIdx, boardIdx);

	}

	// 종류별 신고 리스트
	@Override
	public List<ReportVO> selectReport(String reportSubject) {
		return dao.selectReport(reportSubject);
	}

}
