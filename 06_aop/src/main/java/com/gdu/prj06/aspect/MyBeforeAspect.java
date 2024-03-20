package com.gdu.prj06.aspect;

import java.util.Arrays;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
public class MyBeforeAspect {
  
  //PointCut
  @Pointcut("execution(* com.gdu.prj06.controller.*Controller.*(..))")
  public void setPointCut() {}
  
  //Advice
  /*
   * Before Advice 메소드 작성 방법
   * 1. 반환타입 : void
   * 2. 메소드명 : 마음대로
   * 3. 매개변수 : JoinPoint 타입 객체
   */
  @Before("setPointCut()")
  public void myBeforeAdvice(JoinPoint joinPoint) {
    
    // 요청 메소드 / 주소 / 파라미터 로그 남기기
    
    ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
    //요청에 관련된 attribute 중에 request의 attribute가 필요하다
    HttpServletRequest request = servletRequestAttributes.getRequest();
    
    // 요청마다 파라미터의 수가 다르기 때문에 getparameter 못 함 
    // 파라미터를 전부 빼서 맵으로 반환 시켜주는 parameterMap 사용해야함
    Map<String, String[]> params = request.getParameterMap();
    
    // 파라미터가 없을 때도 있으니까 빈 문자열 
    String str = "";
    // params에 null 적으면 안됨 오긴 하는데 비어있을 수 있기 때문에 null이 오는 경우는 없다.
    if(params.isEmpty()) {
      str += "No paramater";
    } else {
      // parameter map 이므로 entry로 뺀다
      for(Entry<String, String[]> entry : params.entrySet()) {
        str += entry.getKey() + ":" + Arrays.toString(entry.getValue()) + " ";
      }
    }
    
    log.info("{} | {}", request.getMethod(), request.getRequestURI());
    log.info("{}", str);
  }

}
