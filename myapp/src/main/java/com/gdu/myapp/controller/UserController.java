package com.gdu.myapp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.myapp.service.UserService;

@RequestMapping("/user")
@Controller
public class UserController {
  
  private final UserService userService;

  public UserController(UserService userService) {
    super();
    this.userService = userService;
  }
   // a 태그 요청했으니
  @GetMapping("/user/signin.page")
  // request에서 필요한 정보를 빼서 model에 저장한 뒤 signIn 페이지로 이동한다
  // signIn (로그인)을 하고 나서 필요한 URL을 request로부터 꺼내려고 한다
  public String signinPage(HttpServletRequest request
                         , Model model) {
    
    // Sign In 페이지 이전의 주소가 저장되어 있는 Request Header 의 referer 
    String referer = request.getHeader("referer");
    
    // referer 로 돌아가면 안 되는 예외 상황 (아이디/비밀번호 찾기 화면, 가입 화면 등)
    String[] excludeUrls = {};
    
    // Sign In 이후 이동할 url
    String url = referer;  // 쓰면 안 되면 덮어쓰기 당하고 referer가 없으면 main으로 덮어쓰기 당하고     
    if(referer != null) {  // referer 가 null 이면 사이트 오자마자 로그인 한다는 뜻
       // referer 가 존재하면 exclude 값이 존재하는 지 체크
      for(String excludeUrl : excludeUrls) {
        if(referer.contains(excludeUrl)) {
          url = request.getContextPath() + "/main.page";
          break;  // 더 비교할 것 없이 포함돼서 찾았으면 바로 브레이크 처리
        }
      }
    } else {
      url = request.getContextPath() + "/main.page";
    }
    
    // Sign In 페이지로 url 또는 referer 넘겨 주기
    model.addAttribute("url", url);
    
    return "user/signin";
  }
  
  @PostMapping("/signin.do")
  public void signin(HttpServletRequest request, HttpServletResponse response) {
    userService.signin(request, response);
  }
  
}
