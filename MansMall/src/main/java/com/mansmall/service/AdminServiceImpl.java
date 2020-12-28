package com.mansmall.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mansmall.domain.AdminVO;
import com.mansmall.dto.AdminDTO;
import com.mansmall.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO dao;
	
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	//관리자 로그인
	@Override
	public AdminVO login(AdminDTO dto) throws Exception {
		
		AdminVO vo = dao.login(dto);
		
		//로그인 정보와 일치하는 값이 존재하면,
		if(vo != null) {
			//
			
			dao.loginUpdate(dto.getAdmin_id());
		}
		
		return vo;
	}



	
}
