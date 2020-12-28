package com.mansmall.service;

import com.mansmall.domain.AdminVO;
import com.mansmall.dto.AdminDTO;

public interface AdminService {
	
	//로그인
	public AdminVO login(AdminDTO dto) throws Exception;
	
	
}
