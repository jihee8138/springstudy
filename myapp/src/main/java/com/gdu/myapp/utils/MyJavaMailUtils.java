package com.gdu.myapp.utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

@PropertySource(value = "classpath:email.properties")  // resources까지가 classpath이므로 파일명만 적어줘도 됨
public class MyJavaMailUtils {
  
  @Autowired
  // Environment : 애플리케이션 환경설정 파일(프로필, 프로퍼티 등)들 읽어서 처리해주는 인터페이스  
  private Environment env;  
  
  public void sendMail(String to, String subject, String content) {
    
    // 이메일을 보내는 호스트의 정보 : 구글
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", 587);
    props.put("mail.smtp.auth", true);
    props.put("mail.smtp.starttls.enable", true);
    
    // jajax.mail.Session 객체 생성 : 이메일을 보내는 사용자의 정보 (개인 정보)
    Session session = Session.getInstance(props, new Authenticator() {
      @Override
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(env.getProperty("spring.mail.username")
                                        , env.getProperty("spring.mail.password"));
      }
    });
    
    try {
      // 메일 만들기 (보내는 사람 + 받는 사람 + 제목 + 내용)
      MimeMessage mimeMessage = new MimeMessage(session);
      mimeMessage.setFrom(new InternetAddress(env.getProperty("spring.mail.username"), "myapp"));  // setFrom 등록 시 address 타입으로 등록
      mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));  // 받는 사람은 사용자가 이메일을 정보로 받아올꺼다
      mimeMessage.setSubject(subject);  // 제목도 service 에서 받아올꺼다 
      // 내용도 service 에서 받아올꺼다
      // 임시비번 메일로 발송하기 기능 비밀번호 찾기를 누르면 
      mimeMessage.setContent(content, "text.html; charset=UTF-8");
      
      // 메일 보내기
      Transport.send(mimeMessage);
      
    } catch (Exception e) {
      // 예외 발생했을 때 어디서 오류 났는지 확인하기 위해 비워두지 않기
      e.printStackTrace();
    }
    
    
    
    
  }

}
