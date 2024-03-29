package com.gdu.myapp.service;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.myapp.dto.UserDto;
import com.gdu.myapp.mapper.UserMapper;
import com.gdu.myapp.utils.MysecurityUtils;


@Service
public class UserServiceImpl implements UserService {
  
  private final UserMapper userMapper;
  

  public UserServiceImpl(UserMapper userMapper) {
    super();
    this.userMapper = userMapper;
  }

  @Override
  public void signin(HttpServletRequest request, HttpServletResponse response) {
    
    try {
      String email = request.getParameter("email");
      // 사용자의 패스워드가 암호화되어 나오고 그걸 map에 담는다.
      String pw = MysecurityUtils.getSha256(request.getParameter("pw"));
      String ip = request.getRemoteAddr();
      
      Map<String, Object> params = Map.of("email", email
                                        , "pw", pw
                                        , "ip", ip);
      
      UserDto user = userMapper.getUserByMap(params);
      
      if(user != null) {
        userMapper.insertAccessHistory(params);
        // 로그인의 기본 원리 : 세션이라는 저장소 (데이터 바인딩 영역)에 회원 가입한 사람의 정보를 올려두는 것
        request.getSession().setAttribute("user", user);
        response.sendRedirect(request.getParameter("url"));  // url 로 이동한다
      } else {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('일치하는 회원 정보가 없습니다.')");
        out.println("location.href='"+ request.getContextPath()+ "/main.page'");
        out.println("</script>");
        out.flush();
        out.close();
      }
      
    } catch (Exception e) {
      e.printStackTrace();
    }
    
  }

  @Override
  public void signout(HttpServletRequest request, HttpServletResponse response) {
    // TODO Auto-generated method stub

  }

  @Override
  public void signup(HttpServletRequest request, HttpServletResponse response) {
    // TODO Auto-generated method stub

  }

  @Override
  public void leave(HttpServletRequest request, HttpServletResponse response) {
    // TODO Auto-generated method stub

  }

}
