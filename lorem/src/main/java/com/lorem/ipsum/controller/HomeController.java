package com.lorem.ipsum.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.lorem.ipsum.commons;
import com.lorem.ipsum.exception.SessionFailException;
import com.lorem.ipsum.model.post.PostInfoModel;
import com.lorem.ipsum.model.post.ReplyModel;
import com.lorem.ipsum.service.BoardService;
import com.lorem.ipsum.service.LogonService;
import com.lorem.ipsum.service.PostContentsService;
import com.lorem.ipsum.service.PostInfoService;
import com.lorem.ipsum.service.ReplyService;

@CrossOrigin
@RestController
public class HomeController {
	@Autowired
	BoardService boardService;

	@Autowired
	LogonService logonService;

	@Autowired
	PostInfoService postInfoService;

	@Autowired
	PostContentsService postContentsService;

	@Autowired
	ReplyService replyService;

	ModelAndView mv = new ModelAndView();

	@RequestMapping("/carousel")
	public ModelAndView carousel() {
		ArrayList<String> urls=new ArrayList<String>();
		urls.add("../source/Here_comes_rain_again.jpg");
		urls.add("../source/rain_floor_water_wet_drops-1351257.jpg");
		urls.add("../source/wallpapers-desktop-animated-nightwater-27313.jpg");
		urls.add("../source/blue-universe-956981.jpg");
		urls.add("../source/23115-sunset-above-the-clouds-1920x1080-nature-wallpaper.jpg");
		mv.addObject("imgUrls", urls);
		mv.setViewName("page/Carousel");
		return mv;
	}
	
	
	@RequestMapping(value = { "/", "/home", "/welcome" })
	public ModelAndView home(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		mv.addObject("logonMsg", null);
		try {
		commons.logonCheck(session, logonService);
		}catch (SessionFailException e) {
			mv.addObject("logonMsg", e.getMsg());
		}
		mv.addObject("recentPost", postInfoService.getRecentlyAdded());
		mv.addObject("recentReply", replyService.getRecentlyAdded());
		mv.addObject("boardList", boardService.getBoardList());
		mv.setViewName("page/welcome");
		commons.setAlwaysReload(response);
		return mv;
	}
	

}
