package com.lorem.ipsum.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lorem.ipsum.commons;
import com.lorem.ipsum.model.logon.UserModel;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Interceptor extends HandlerInterceptorAdapter {


	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("Interceptor > preHandle");
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		if (user == null||user.getU_id()==null)
			request.setAttribute("Msg", "로그인 되어있지 않습니다.");
		else if(user.getU_session()==null){
			request.setAttribute("Msg", "옳바르지 않은 세션입니다.");
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		log.info("Interceptor > postHandle");
		
		commons.setAlwaysReload(response);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		log.info("Interceptor > afterCompletion");
	}
}
