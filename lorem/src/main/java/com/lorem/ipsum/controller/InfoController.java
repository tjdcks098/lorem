package com.lorem.ipsum.controller;


import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.lorem.ipsum.commons;
import com.lorem.ipsum.exception.SessionFailException;
import com.lorem.ipsum.model.logon.UserInfoModel;
import com.lorem.ipsum.model.logon.UserModel;
import com.lorem.ipsum.service.LogonService;
import com.lorem.ipsum.service.PostInfoService;
import com.lorem.ipsum.service.ReplyService;


@CrossOrigin
@RestController
public class InfoController {
	
	@Autowired
	LogonService logonService;
	
	@Autowired
	PostInfoService postInfoService;
	
	@Autowired
	ReplyService replyService;
	
	
	ModelAndView mv=new ModelAndView();
	
	@RequestMapping("/info/edit.do")
	public String editInfoDo(HttpSession session, HttpServletResponse response, String u_nick, String prv_pw, String new_pw, String u_email, String u_phnum, String u_intro) {
		String str="";
		try {
			commons.logonCheck(session, logonService);
			UserModel user=(UserModel)session.getAttribute("user");
			if(new_pw!=null&&!new_pw.equals("")) {
				logonService.changePw(user.getU_id(), new_pw);
			}
			logonService.editInfo(user.getU_id(),u_nick, u_email, u_phnum, u_intro);
			str="alert('수정되었습니다.');"
					+ "location.href='../info'";
		}catch (SessionFailException e) {
			str="alert('세션이 만료되었습니다.');";
		}catch (Exception e) {
			e.printStackTrace();
			str="alert('알 수 없는 오류가 발생했습니다.');";
		}
		commons.setAlwaysReload(response);
		return str;
	}
	
	@RequestMapping("/info/edit")
	public ModelAndView editInfo(HttpSession session, HttpServletResponse response) {
		try {
			commons.logonCheck(session, logonService);
			UserInfoModel user=logonService.getUserInfo(((UserModel) session.getAttribute("user")).getU_id());
			mv.addObject("u_email", user.getU_email());
			mv.addObject("u_intro", user.getU_intro());
			mv.addObject("u_nick", user.getU_nick());
			mv.addObject("u_phnum", user.getU_phnum());
			mv.setViewName("page/editInfo");
		}catch (SessionFailException e) {
			if(e.getCode()==SessionFailException.UNKNOWN_EXCEPTION
					||e.getCode()==SessionFailException.INVALID_SESSION) {
				mv.addObject("redirect", "../welcome");
			}
			else {
				mv.addObject("redirect", "../login");
			}
			mv.addObject("msg", e.getMsg());
			mv.setViewName("logic/result");
		}
		commons.setAlwaysReload(response);
		return mv;
	}
	@RequestMapping("/info")
	public ModelAndView info(HttpSession session, HttpServletResponse response) {
		try {
			commons.logonCheck(session, logonService);
			UserInfoModel user=logonService.getUserInfo(((UserModel) session.getAttribute("user")).getU_id());
			mv.addObject("u_id", user.getU_id());
			mv.addObject("u_birth", user.getU_birth());
			mv.addObject("u_email", user.getU_email());
			mv.addObject("u_intro", user.getU_intro());
			mv.addObject("u_joindate", user.getU_joindate());
			mv.addObject("u_level", user.getU_level());
			mv.addObject("u_name", user.getU_name());
			mv.addObject("u_nick", user.getU_nick());
			mv.addObject("u_phnum", user.getU_phnum());
			mv.setViewName("page/info");
		}catch (SessionFailException e) {
			if(e.getCode()==SessionFailException.UNKNOWN_EXCEPTION
					||e.getCode()==SessionFailException.INVALID_SESSION) {
				mv.addObject("redirect", "../welcome");
			}
			else {
				mv.addObject("redirect", "../login");
			}
			mv.addObject("msg", e.getMsg());
			mv.setViewName("logic/result");
		}
		commons.setAlwaysReload(response);
		return mv;
	}
	
	@RequestMapping("/info/getMy{type}")
	public ResponseEntity<?> getInfo(@PathVariable String type, HttpSession session){
		try {
		commons.logonCheck(session, logonService);
		}catch (SessionFailException e) {
			return ResponseEntity.badRequest().body(e);
		}
		UserModel user=(UserModel)session.getAttribute("user");
		if(type.equals("Post")) {
			return ResponseEntity.ok(postInfoService.getMyPost(user.getU_id()));
		}else {
			return ResponseEntity.ok(replyService.getMyReply(user.getU_id()));
		}
	}
}
