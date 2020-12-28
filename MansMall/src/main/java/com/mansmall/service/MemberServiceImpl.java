package com.mansmall.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mansmall.domain.MemberVO;
import com.mansmall.dto.LoginDTO;
import com.mansmall.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	// MemberVO 가져오기
	@Override
	public MemberVO readUserInfo(String mb_id) throws Exception {
		return dao.readUserInfo(mb_id);
	}
	
	//회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		dao.join(vo);
	}
	
	//아이디중복 체크
	@Override
	public String checkId(String mb_id) throws Exception {
		return dao.checkId(mb_id);
	}
	
	//닉네임 중복체크
	@Override
	public String checkNickName(String mb_nickname) throws Exception {
		return dao.checkNickName(mb_nickname);
	}
	
	//로그인
	@Transactional
	@Override
	public LoginDTO login(LoginDTO dto) throws Exception {
		LoginDTO logDTO =  dao.login(dto); // 아이디 파라미터만 사용함.(비밀번호 파라미터사용안함)
		
		//회원가입시 비밀번호를 암호화하여 저장됨.
		if(logDTO != null) {
			//비밀번호가 암호화 된 비밀번호와 일치하는지 확인. crptPassEnc.matches(일반비밀번호, 암호화된 비밀번호)
			if(crptPassEnc.matches(dto.getMb_pw(), logDTO.getMb_pw())) { // true 면, 로그인 정보 존재한다.
				dao.loginTimeUpdate(logDTO.getMb_id()); //로그인 시간저장.
			} else {
				//비밀번호가 일치하지 않으면, null 반환
				logDTO = null;
			}
		}
		return logDTO;
	}
	
	//로그인시간 업데이트
	@Override
	public void loginTimeUpdate(String mb_id) throws Exception {
		dao.loginTimeUpdate(mb_id);	
	}
	
	//회원정보 수정
	@Override
	public void modifyMemberInfo(MemberVO vo) throws Exception {			
		dao.modifyMemberInfo(vo);
	}
	
	//비밀번호 변경
	@Override
	public void changePw(LoginDTO dto) throws Exception {
		dao.changePw(dto);	
	}
	
	/*회원탈퇴	*/
	@Override
	public void deleteMember(String mb_id) throws Exception {
		dao.deleteMember(mb_id);	
	}


	
}
