package com.study.webrtc.init;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;
import com.study.webrtc.config.AppContextConfig;
import com.study.webrtc.config.WebContextConfig;

public class Init implements WebApplicationInitializer {

  @Override
  public void onStartup(ServletContext servletContext) throws ServletException {
    addContextListener(servletContext);
    addDispatcherServlet(servletContext);
    addEncodingFilter(servletContext);    
  }

  public void addContextListener(ServletContext servletContext) {
    AnnotationConfigWebApplicationContext webApplicationContext = new AnnotationConfigWebApplicationContext();
    webApplicationContext.register(AppContextConfig.class);
    ContextLoaderListener contextLoaderListener = new ContextLoaderListener(webApplicationContext);
    servletContext.addListener(contextLoaderListener);
  }

  public void addDispatcherServlet(ServletContext servletContext) {
    AnnotationConfigWebApplicationContext webApplicationContext = new AnnotationConfigWebApplicationContext();
    webApplicationContext.register(WebContextConfig.class);
    DispatcherServlet dispatcherServlet = new DispatcherServlet(webApplicationContext);
    ServletRegistration.Dynamic webServlet = servletContext.addServlet("webServlet", dispatcherServlet);
    webServlet.setLoadOnStartup(1);
    webServlet.addMapping("/");
  }

  public void addEncodingFilter(ServletContext servletContext) {
    CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter("UTF-8", true);
    FilterRegistration.Dynamic webFilter = servletContext.addFilter("webFilter", characterEncodingFilter);
    webFilter.addMappingForUrlPatterns(null, true, "/*");
  }

}
