package com.board.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.board.vo.UserInfoVO;

public class UserDAOImpl implements UserDAO {

	@Autowired
	private SqlSession sqlSession;

	// 아이디 중복 검사
	@Override
	public int idCheck(String userId) {
		return sqlSession.selectOne("com.board.mappers.UserMapper.idCheck", userId);
	}

	// 닉네임 중복 검사
	@Override
	public int nickCheck(String userNickname) {
		return sqlSession.selectOne("com.board.mappers.UserMapper.nickCheck", userNickname);
	}

	// 회원가입
	@Override
	public void insertUser(String userId, String userPw, String userNickname) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userPw", userPw);
		map.put("userNickname", userNickname);
		sqlSession.insert("com.board.mappers.UserMapper.insertUser", map);

	}

	// 로그인
	@Override
	public int checkIdPw(String userId, String userPw) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userPw", userPw);
		return sqlSession.selectOne("com.board.mappers.UserMapper.checkIdPw", map);
	}

	// 유저 정보
	@Override
	public UserInfoVO selectUserInfo(int userIdx) {
		return sqlSession.selectOne("com.board.mappers.UserMapper.selectUserInfo", userIdx);
	}

	// 회원 탈퇴
	@Override
	public void deleteUser(int userIdx) {
		sqlSession.delete("com.board.mappers.UserMapper.deleteUser",userIdx);
	}

	// 닉네임 변경
	@Override
	public void updateNickname(String userNickname, int userIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNickname", userNickname);
		map.put("userIdx", userIdx);
		sqlSession.update("com.board.mappers.UserMapper.updateNickname",map);
		
	}
	
	
	
	

}
