package com.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.board.vo.ReportVO;

public class ReportDAOImpl implements ReportDAO {

	@Autowired
	private SqlSession sqlSession;

	// 댓글 등록
	@Override
	public void insertReport(String reportSubject, String reportTitle, String reportContents, int userIdx,
			int boardIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportSubject", reportSubject);
		map.put("reportTitle", reportTitle);
		map.put("reportContents", reportContents);
		map.put("userIdx", userIdx);
		map.put("boardIdx", boardIdx);
		sqlSession.insert("com.board.mappers.ReportMapper.insertReport", map);
	}

	// 신고 목록 삭제
	@Override
	public void deleteReport(int boardIdx) {
		sqlSession.delete("com.board.mappers.ReportMapper.deleteReport", boardIdx);

	}

	// 종류별 신고 리스트
	@Override
	public List<ReportVO> selectReport(String reportSubject) {
		return sqlSession.selectList("com.board.mappers.ReportMapper.selectReport", reportSubject);
	}

}
