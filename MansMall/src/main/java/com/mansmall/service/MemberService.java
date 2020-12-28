package com.mansmall.service;

import com.mansmall.domain.MemberVO;
import com.mansmall.dto.LoginDTO;

public interface MemberService {
	
	// MemberVO 가져오기
	public MemberVO readUserInfo(String mb_id) throws Exception;
	
	//회원가입
	public void join(MemberVO vo) throws Exception;
	
	//아이디 중복체크
	public String checkId(String mb_id) throws Exception;
	
	//닉네임 중복체크
	public String checkNickName (String mb_nickname) throws Exception;
	
	//로그인
	public LoginDTO login(LoginDTO dto) throws Exception;
	
	//로그인 시간 업데이트
	public void loginTimeUpdate(String mb_id) throws Exception;
	
	//회원정보 수정
	public void modifyMemberInfo(MemberVO vo) throws Exception;
	
	//비밀번호 변경
	public void changePw(LoginDTO dto) throws Exception;
	
	/*회원탈퇴*/
	public void deleteMember(String mb_id) throws Exception;
	
}
