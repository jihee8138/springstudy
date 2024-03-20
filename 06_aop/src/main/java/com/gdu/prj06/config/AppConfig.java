package com.gdu.prj06.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

import com.gdu.prj06.aspect.MyAfterAspect;
import com.gdu.prj06.aspect.MyAroundAspect;
import com.gdu.prj06.aspect.MyBeforeAspect;

@EnableAspectJAutoProxy // aspect 허용하는 annotation
@Configuration  // 나는 bean annotation을 이용해 bean을 만들겠다
public class AppConfig {
  
  @Bean  // Componnent 를 대체하는 코드
  public MyAroundAspect myAroundAspect() {
    return new MyAroundAspect();
  }
  
  @Bean
  public MyBeforeAspect myBeforeAspect() {
    return new MyBeforeAspect();
  }
  
  @Bean
  public MyAfterAspect myAfterAspect() {
    return new MyAfterAspect();
  }

}
