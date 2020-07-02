package com.lorem.ipsum.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

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
import com.lorem.ipsum.model.BoardModel;
import com.lorem.ipsum.model.dailyReply;
import com.lorem.ipsum.model.logon.UserModel;
import com.lorem.ipsum.service.BoardService;
import com.lorem.ipsum.service.LogonService;
import com.lorem.ipsum.service.PostInfoService;
import com.lorem.ipsum.service.PostSearchService;
import com.lorem.ipsum.service.ReplyService;

@CrossOrigin
@RestController
public class BoardController {

	@Autowired
	LogonService logonService;

	@Autowired
	BoardService boardService;

	@Autowired
	PostInfoService postInfoService;

	@Autowired
	PostSearchService postSearchService;
	
	@Autowired
	ReplyService replyService;

	ModelAndView mv = new ModelAndView();

	@RequestMapping("/board/search")
	public ModelAndView search(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		String keywords[] = request.getParameter("keyword").split(" ");
		String param = keywords[0];
		for (int i = 1; i < keywords.length; i++) {
			param += "|" + keywords[i];
		}

		String target = request.getParameter("target");
		mv.addObject("boardList", boardService.getBoardList());
		mv.addObject("keyword", request.getParameter("keyword"));
		mv.addObject("target", target);
		switch (target) {
		case "0":
			mv.addObject("result", postSearchService.searchByTC(param));
			break;
		case "1":
			mv.addObject("result", postSearchService.searchByT(param));
			break;
		case "2":
			mv.addObject("result", postSearchService.searchByC(param));
			break;
		case "3":
			mv.addObject("result", postSearchService.searchByN(param));
			break;
		}
		mv.setViewName("page/board/search");
		return mv;
	}

	@RequestMapping("/board")
	public ModelAndView board(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		String pageNum = (String) request.getParameter("pageNum");
		String b_name = (String) request.getParameter("name");
		if (pageNum == null)
			pageNum = "1";
		BoardModel board = boardService.getBoardInf(b_name);
		String boardType = board.getB_type();
		mv.addObject("pageNum", pageNum);
		mv.addObject("postType", boardType);
		mv.addObject("errMsg", null);
		mv.addObject("name", b_name);
		mv.addObject("boardList", boardService.getBoardList());
		switch (boardType) {
		case "Daily":
			String dailyKey=request.getParameter("dailyKey");
			if(dailyKey==null) {
				dailyKey=String.valueOf(new Date(new Date().getYear(), new Date().getMonth(), new Date().getDate()).getTime());
			}
			mv.addObject("dailyKey", dailyKey);
			mv.setViewName("page/board/boardDaily");
			break;
		default:
			mv.addObject("postCount", postInfoService.getPostCount(b_name));
			mv.addObject("postList", postInfoService.getPostList(b_name, Integer.valueOf(pageNum)));
			
			mv.setViewName("page/board/boardNormal");
			break;
		}
		commons.setAlwaysReload(response);
		return mv;
	}

	
	@RequestMapping("/dailyWrite.do")
	public String dailyWrite(HttpServletRequest request, dailyReply reply) {
		try {
			commons.logonCheck(request.getSession(), logonService);
		} catch (SessionFailException e) {
			String html="";
			if(e.getCode()==SessionFailException.INVALID_SESSION)
				html+="alert('유효한 세션이 아닙니다.');";
			html+="if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')){";
			html+="location.href='../login';}";
			
		}
		System.out.println(reply.getBoard()+"  "+reply.getContent()+"  "+reply.getDailyKey());
		if(reply==null)return "alert('전송중 오류가 발생했습니다.')";
		if(boardService.getDailyPostId(reply.getBoard(), reply.getDailyKey())==null) {
			boardService.setDailyPostId(reply.getBoard(), reply.getDailyKey());
		}
		UserModel user=(UserModel)request.getSession().getAttribute("user");
		boardService.addDailyPost(reply, user.getU_id());
		return "";
	}
}
