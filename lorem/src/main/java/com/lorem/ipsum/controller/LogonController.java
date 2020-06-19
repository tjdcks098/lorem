package com.lorem.ipsum.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.lorem.ipsum.commons;
import com.lorem.ipsum.LoremException._LoginException;
import com.lorem.ipsum.model.logon.JoinModel;
import com.lorem.ipsum.model.logon.UserModel;
import com.lorem.ipsum.service.LogonService;

@CrossOrigin
@RestController
public class LogonController {

	@Autowired
	LogonService logonService;

	ModelAndView mv = new ModelAndView();

	

	@RequestMapping("/find")
	public ModelAndView find() {
		mv.addObject("fid", null);
		mv.addObject("fpw", null);
		mv.addObject("fhint", null);
		mv.setViewName("page/find");
		return mv;
	}

	@RequestMapping("/find/id.do")
	public ModelAndView findId(HttpServletRequest request) {
		String u_name = request.getParameter("u_name");
		String u_email = request.getParameter("emid") + "@" + request.getParameter("emadd");
		String fid = logonService.findId(u_name, u_email);
		mv.addObject("fid", fid);
		mv.setViewName("page/find");
		return mv;
	}

	@RequestMapping("/find/pw.do")
	public ModelAndView findPw(HttpServletRequest request) {
		String u_name = request.getParameter("u_name");
		String u_id = request.getParameter("u_id");
		String u_email = request.getParameter("emid") + "@" + request.getParameter("emadd");
		String fpw = logonService.findPw(u_name, u_id, u_email);
		System.out.println(fpw);
		if (!fpw.equals("0")) {
			mv.addObject("fpw", fpw.split(":")[0]);
			mv.addObject("fhint", fpw.split(":")[1]);
		} else {
			mv.addObject("fpw", "0");
		}
		mv.setViewName("page/find");
		return mv;
	}

	@RequestMapping("/support")
	public ModelAndView supprot() {
		mv.setViewName("page/support");
		return mv;
	}

	@RequestMapping("/join/idduple.do")
	public String join_iddupleck(String value) {
		return logonService.isIdDuple(value);
	}

	@RequestMapping("/join/nkduple.do")
	public String join_nkdupleck(String value) {
		return logonService.isNickDuple(value);
	}

	@RequestMapping("/join.do")
	public ModelAndView join_do(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		mv.setViewName("logic/result");
		JoinModel joinInfo = new JoinModel();
		joinInfo.setU_id(request.getParameter("u_id"));
		joinInfo.setU_pw(request.getParameter("u_pw"));
		joinInfo.setU_nick(request.getParameter("u_nick"));
		joinInfo.setU_name(request.getParameter("u_name"));
		joinInfo.setFind_hint(request.getParameter("find_hint"));
		joinInfo.setU_email(request.getParameter("emid") + "@" + request.getParameter("emadd"));
		joinInfo.setU_phnum(
				request.getParameter("phhead") + request.getParameter("phmid") + request.getParameter("phlast"));
		joinInfo.setU_birth(request.getParameter("u_birth"));
		try {
			logonService.join(joinInfo);
			mv.addObject("msg", "성공적으로 가입되었습니다.");
			mv.addObject("redirect", "../login");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "가입중 오류가 발생했습니다.");
			mv.addObject("redirect", "../join/policy");
		}

		return mv;
	}

	@RequestMapping("/join/policy")
	public ModelAndView join_policy(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		if (session.getAttribute("user") == null) {
			mv.addObject("referer", commons.baseUrl + "login");
			mv.setViewName("page/join_policy");
		} else {
			mv.addObject("msg", "잘못된 접근입니다.");
			mv.addObject("redirect", commons.baseUrl + "welcome");
			mv.setViewName("logic/result");
		}

		commons.setAlwaysReload(response);
		return mv;
	}

	@RequestMapping("/join/info")
	public ModelAndView join_info(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		if (session.getAttribute("user") == null) {
			String uck = (String) request.getParameter("user_ck");
			String ick = (String) request.getParameter("info_ck");
			if (uck != null && ick != null && uck.equals("true") && ick.equals("true")) {
				mv.setViewName("page/join_info");
			} else {
				mv.addObject("msg", "먼저 이용약관에 동의하셔야 합니다.");
				mv.addObject("redirect", commons.baseUrl + "join/policy");
				mv.setViewName("logic/result");
			}
		} else {
			mv.addObject("msg", "잘못된 접근입니다.");
			mv.addObject("redirect", commons.baseUrl + "welcome");
			mv.setViewName("logic/result");
		}
		commons.setAlwaysReload(response);
		return mv;
	}

	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		if (session.getAttribute("user") == null) {
			mv.addObject("msg", null);
			String referer = request.getHeader("Referer");
			session.setAttribute("referer", referer);
			mv.setViewName("page/login");
			commons.setAlwaysReload(response);
		} else {
			mv.setView(new RedirectView(request.getHeader("Referer")));
		}
		return mv;
	}

	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		UserModel user = (UserModel) session.getAttribute("user");
		if (user != null) {
			logonService.logout(user.getU_id(), user.getU_session());
			session.setAttribute("user", null);
		}
		String referer=request.getHeader("Referer");
		if(referer.matches(".*(?i)info.*")
			||referer.matches(".*(?i)write.*")
			||referer.matches(".*(?i)edit.*")
			) {
			referer=commons.baseUrl+"welcome";
		}
		mv.setView(new RedirectView(referer));
		commons.setAlwaysReload(response);
		return mv;
	}

	@RequestMapping("/login.do")
	public ModelAndView loginSubmit(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {
		mv.addObject("msg", null);
		String u_id = (String) request.getParameter("id");
		String pw = (String) request.getParameter("pw");
		try {
			UserModel user = logonService.login(u_id, pw);
			request.getSession().setAttribute("user", user);
			String referer = (String) session.getAttribute("referer");
			if (referer == null || referer.matches(".*join.*") || referer.matches(".*login.*")) {
				referer = commons.baseUrl + "welcome";
			}
			mv.setView(new RedirectView(referer));
			session.removeAttribute("referer");
		} catch (_LoginException e) {
			session.removeAttribute("user");
			mv.addObject("msg", e.getMessage());
			mv.setViewName("page/login");
		}
		return mv;
	}
}
