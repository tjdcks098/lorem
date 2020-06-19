package com.lorem.ipsum.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.lorem.ipsum.controller.Interceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new Interceptor()).addPathPatterns("/*").excludePathPatterns("/login");
	}
}
