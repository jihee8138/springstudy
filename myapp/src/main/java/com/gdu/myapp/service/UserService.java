package com.gdu.myapp.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

public interface UserService {
  void signin(HttpServletRequest request, HttpServletResponse response);   // 로그인
  // 자바측에선 맵을 넘길껀데 화면으로 넘어갈 때는 json으로 넘어가므로 비동기 처리 
  ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
  ResponseEntity<Map<String, Object>> sendCode(Map<String, Object> params);
  void signup(HttpServletRequest request, HttpServletResponse response);   // 가입
  void leave(HttpServletRequest request, HttpServletResponse response);    // 탈퇴
  
  void signout(HttpServletRequest request, HttpServletResponse response);  // 로그아웃
  
}
