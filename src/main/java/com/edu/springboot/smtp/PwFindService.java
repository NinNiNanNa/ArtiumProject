package com.edu.springboot.smtp;

import java.io.UnsupportedEncodingException;

import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

//mail 서비스 interface
@Service
public interface PwFindService {

	// 메일 내용 작성 
	MimeMessage createMessage(String to, String user_pass) throws MessagingException, UnsupportedEncodingException;
    
    // 메일 발송
    String sendSimpleMessage(String to, String user_pass) throws Exception;
}
