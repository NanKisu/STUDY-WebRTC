package com.study.webrtc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = {"/"})
public class HomeController {
  @GetMapping(path = {"", "/home"})
  public String home() {
    return "home";
  }
  
  @GetMapping(path = {"/outdoor"})
  public String outdoor() {
    return "outdoor";
  }
}
