package com.study.webrtc.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import com.study.webrtc.component.SocketHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{

  @Override
  public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    // TODO Auto-generated method stub
    registry.addHandler(new SocketHandler(), "/socket").setAllowedOrigins("*");
  }

  
  
}
