package com.edu.springboot.smtp;

import java.io.UnsupportedEncodingException;

//import javax.mail.MessagingException;
//import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

//mail 서비스 interface
@Service
public interface IdFindService {
    
    // 메일 내용 작성 
	MimeMessage createMessage(String to, String user_id) throws MessagingException, UnsupportedEncodingException;
    
    // 메일 발송
    String sendSimpleMessage(String to, String user_id) throws Exception;



}