package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.dao.ReplyDAO;
import com.board.dao.UserDAO;
import com.board.vo.BoardVO;
import com.board.vo.ReplyVO;
import com.board.vo.UserInfoVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO udao;
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private ReplyDAO rdao;

	// 아이디 중복 체크
	@Override
	public int idCheck(String userId) {
		return udao.idCheck(userId);
	}

	// 닉네임 중복 체크
	@Override
	public int nickCheck(String userNickname) {
		return udao.nickCheck(userNickname);
	}

	// 회원가입
	@Override
	public void insertUser(String userId, String userPw, String userNickname) {
		udao.insertUser(userId, userPw, userNickname);

	}

	// 로그인
	@Override
	public int checkIdPw(String userId, String userPw) {
		return udao.checkIdPw(userId, userPw);
	}

	// 유저 정보
	@Override
	public UserInfoVO selectUserInfo(int userIdx) {
		return udao.selectUserInfo(userIdx);
	}

	// 회원 탈퇴
	@Override
	public void deleteUser(int userIdx) {
		// 작성한 게시물 삭제 + 그 게시물에 달린 댓글들도 삭제
		List<BoardVO> blist =  bdao.selectBoardByUser(userIdx);
		for(BoardVO tmp : blist) {
			bdao.deleteBoard(tmp.getBoardIdx()); // 게시물 삭제
			rdao.deleteBoardReply(tmp.getBoardIdx()); // 게시물에 달린 댓글 삭제
		}
		// 작성한 댓글 삭제
		List<ReplyVO> rlist =  rdao.selectReplyByUser(userIdx);
		for(ReplyVO tmp : rlist) {
			rdao.deleteReply(tmp.getReplyIdx()); // 유저가 작성한 댓글들 삭제
			rdao.updateReplyMinus(tmp.getBoardIdx());// 게시물 댓글 카운트 업데이트
		}
		// 회원 삭제
		udao.deleteUser(userIdx);
	}

	// 닉네임 변경
	@Override
	public void updateNickname(String userNickname, int userIdx) {
		udao.updateNickname(userNickname, userIdx);
		
	}
	
	

}
