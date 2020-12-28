package com.mansmall.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mansmall.domain.MemberVO;
import com.mansmall.dto.LoginDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;
	public final static String NS = "com.mansmall.mappers.MemberMapper";
	
	//회원가입 
	@Override
	public void join(MemberVO vo) throws Exception {
		session.insert(NS+".join", vo); //(NS+".mapper파일 id명" 그래서 메소드명을 id명과 같이 한 것)
	}
	
	//아이디 중복 확인
	@Override
	public String checkId(String mb_id) throws Exception {
		return session.selectOne(NS+".checkId", mb_id);
	}
	
	//닉네임 중복체크
	@Override
	public String checkNickName(String mb_nickname) throws Exception {	
		return session.selectOne(NS+".checkNickName", mb_nickname);
	}
	
	//로그인
	@Override
	public LoginDTO login(LoginDTO dto) throws Exception {
		return session.selectOne(NS+".login", dto);
	}
	
	// 로그인 시간 업데이트
	@Override
	public void loginTimeUpdate(String mb_id) throws Exception {
		session.update(NS+".loginTimeUpdate", mb_id);
		
	}
	
	//MemberVO 가져오기
	@Override
	public MemberVO readUserInfo(String mb_id) throws Exception {	
		return session.selectOne(NS+".readUserInfo", mb_id);
	}

	// 회원정보 수정
	@Override
	public void modifyMemberInfo(MemberVO vo) throws Exception {
		session.update(NS+".modifyMemberInfo", vo);	
		}
	
	//비밀번호 변경
	@Override
	public void changePw(LoginDTO dto) throws Exception {
		session.update(NS+".changePw",dto);
		
	}
	
	/*회원탈퇴*/
	@Override
	public void deleteMember(String mb_id) throws Exception {
		session.delete(NS+".deleteMember", mb_id);
		
	}
	

}
