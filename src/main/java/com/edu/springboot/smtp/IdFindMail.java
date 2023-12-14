package com.edu.springboot.smtp;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMessage.RecipientType;

@Service
public class IdFindMail implements IdFindService{

	@Autowired
	JavaMailSender emailSender; // MailConfig에서 등록해둔 Bean을 autowired하여 사용하기
	
	//메일 내용 작성
	@Override
	public MimeMessage createMessage(String to, String user_id) throws MessagingException, UnsupportedEncodingException {
		System.out.println("메일받을 사용자" + to);
		System.out.println("회원아이디" + user_id);
		
		MimeMessage message = emailSender.createMimeMessage();
		
		message.addRecipients(RecipientType.TO, to); // 메일 받을 사용자
        message.setSubject("[Artium] 회원님의 아이디 입니다."); // 이메일 제목
        
        String msgg = "";
        msgg += "<div style='margin:100px;'>";
        msgg += "<h1> 안녕하세요</h1>";
        msgg += "<h1>전시회 플랫폼 Artium 입니다.</h1>";
        msgg += "<br>";
        msgg += "<p>감사합니다!<p>";
        msgg += "<br>";
        msgg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
        msgg += "<h3 style='color:blue'>회원님의 아이디 입니다.</h3>";
        msgg += "<div style='font-size:130%'>";
        msgg += "ID : <strong>";
        msgg += "<strong>" + user_id + "</strong></div><br/>" ; // 메일에 회원아이디 user_id 넣기
        msgg += "</div>";
        message.setText(msgg, "utf-8", "html"); // 메일 내용, charset타입, subtype
        // 보내는 사람의 이메일 주소, 보내는 사람 이름
        message.setFrom(new InternetAddress("dmstjs2720@naver.com", "Artium_Admin"));
        System.out.println("********creatMessage 함수에서 생성된 msgg 메시지********" + msgg);
        
        System.out.println("********creatMessage 함수에서 생성된 리턴 메시지********" + message);


        return message;
    }

	@Override
	public String sendSimpleMessage(String to, String user_id) throws Exception {
		MimeMessage message = createMessage(to, user_id); // "to" 로 메일 발송
        try { // 예외처리
            emailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException();
        }
        
        return user_id;
	}
}

		
