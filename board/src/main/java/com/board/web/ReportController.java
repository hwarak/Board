package com.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.service.JsonEcDcService;
import com.board.service.ReportService;
import com.board.vo.BoardVO;
import com.board.vo.ReplyVO;
import com.board.vo.ReportVO;

@Controller
public class ReportController {

	@Autowired
	private ReportService reportService;

	@Autowired
	private JsonEcDcService jsonService;

	// 댓글 등록하기
	@ResponseBody
	@PostMapping("/report")
	public Map insertReport(@RequestBody String str) {

		// json 파싱 후 반환
		JSONObject obj = jsonService.jsonDc(str);
		int boardIdx = (int) (long) obj.get("boardIdx");
		int userIdx = (int) (long) obj.get("userIdx");
		String reportSubject = (String) obj.get("reportSubject");
		String reportTitle = (String) obj.get("reportTitle");
		String reportContents = (String) obj.get("reportContents");

		// 신고 등록
		reportService.insertReport(reportSubject, reportTitle, reportContents, userIdx, boardIdx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");

		return map;
	}
	
	// 신고 접수 리스트 페이지
	@GetMapping("/report")
	public String selectReportPage(Model model) {
		
		// 선택된 주제로 접수된 신고 리스트
		List<ReportVO> list = reportService.selectReport("폭력적 또는 혐오스러운 콘텐츠");
		model.addAttribute("list", list);

		return "reportList";
	}

	// 신고 접수 리스트
	@GetMapping("/reportList")
	public String selectReport(@RequestParam String reportSubject, Model model) {

		// 선택된 주제로 접수된 신고 리스트
		List<ReportVO> list = reportService.selectReport(reportSubject);
		model.addAttribute("list", list);

		return "reportListAjax";
	}


}
