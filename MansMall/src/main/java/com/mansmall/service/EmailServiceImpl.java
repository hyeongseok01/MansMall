package com.mansmall.service;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.mansmall.dto.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService {
	
	//DB와 관련된 작업이 없습니다.
	
	//DI(의존성 주입구문) : Bean객체가 무엇인지 체크바람.
	@Inject
	JavaMailSender mailSender;    // root-context.xml에 설정 참고(JavaMailSenderImpl 클래스 bean개체). 
	
	/*
	 * 
	 * 이메일 인증 코드를 전송 
	 * MimeMessage 클래스는 Message 클래스를 상속받았으며, 
	 * Message 메시지는(즉, MimeMessage 클래스는) 보내는 사람, 받는 사람, 제목, 내용과 같이 메일과 관련된 내용을 지정할 수 있도록 해 준다.
	 */
	
	@Override
	public void sendEmail(EmailDTO dto, String authcode) {
		MimeMessage msg =  mailSender.createMimeMessage();
		
		try {
		// 받는 사람 설정(이메일)
		msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
		//보내는 사람 설정(이메일, 이름) 2가지를 설정하려고  리스트로 작성
		msg.addFrom(new InternetAddress[]{new InternetAddress(dto.getSenderMail(),dto.getSenderName())});
		//이메일 제목	
		msg.setSubject(dto.getSubject(),"utf-8");
		//이메일 본문(인증코드 추가)
		msg.setText(dto.getMessage()+ authcode,"utf-8");
		//메일 보내기
		mailSender.send(msg); //gmail 보안설정 낮게 해야 함.
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
