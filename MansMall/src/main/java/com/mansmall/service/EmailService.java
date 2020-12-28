package com.mansmall.service;

import com.mansmall.dto.EmailDTO;

public interface EmailService {
	
	public void sendEmail(EmailDTO dto, String authcode);
}
