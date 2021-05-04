package com.board.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class ReportDAOImpl implements ReportDAO{
	
	@Autowired
	private SqlSession sqlSession;

	// 신고 등록하기
	@Override
	public void inserReport(int userIdx, int boardIdx, String reportSubject, String reportTitle, String reportContent) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", userIdx);
		map.put("boardIdx", boardIdx);
		map.put("reportSubject", reportSubject);
		map.put("reportTitle", reportTitle);
		map.put("reportContent", reportContent);
		sqlSession.insert("com.board.mappers.ReportMapper.insertReport",map);
	}

	// 신고 삭제하기
	@Override
	public void deleteReport(int reportIdx) {
		sqlSession.delete("com.board.mappers.ReportMapper.deleteReport",reportIdx);
	}
	
	

}
