package com.gdu.myapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MvcController {

  @GetMapping(value={"/", "/main.page"})  // 단순 페이지 이동
  public String welcome() {
    return "index";
  }

}