package com.board.service;

import org.springframework.stereotype.Service;

@Service
public interface UserService {

	// 아이디 중복 검사
	public int idCheck(String userId);

	// 닉네임 중복 검사
	public int nickCheck(String userNickname);

	// 회원가입
	public void insertUser(String userId, String userPw, String userNickname);

	// 로그인
	public int checkIdPw(String userId, String userPw);
}
