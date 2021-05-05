package com.board.service;

import org.springframework.stereotype.Service;

import com.board.vo.UserInfoVO;

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

	// 유저 정보
	public UserInfoVO selectUserInfo(int userIdx);
	
	// 회원 탈퇴
	public void deleteUser(int userIdx);

}
