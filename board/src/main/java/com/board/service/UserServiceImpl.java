package com.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.UserDAO;
import com.board.vo.UserInfoVO;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserDAO dao;

	// 아이디 중복 체크
	@Override
	public int idCheck(String userId) {
		return dao.idCheck(userId);
	}

	// 닉네임 중복 체크
	@Override
	public int nickCheck(String userNickname) {
		return dao.nickCheck(userNickname);
	}

	// 회원가입
	@Override
	public void insertUser(String userId, String userPw, String userNickname) {
		dao.insertUser(userId, userPw, userNickname);
		
	}

	// 로그인
	@Override
	public int checkIdPw(String userId, String userPw) {
		return dao.checkIdPw(userId, userPw);
	}

	// 유저 정보
	@Override
	public UserInfoVO selectUserInfo(int userIdx) {
		return dao.selectUserInfo(userIdx);
	}
	
	
	
	

}
