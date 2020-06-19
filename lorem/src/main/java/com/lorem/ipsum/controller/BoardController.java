package com.lorem.ipsum.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.lorem.ipsum.commons;
import com.lorem.ipsum.service.BoardService;
import com.lorem.ipsum.service.LogonService;
import com.lorem.ipsum.service.PostInfoService;
import com.lorem.ipsum.service.PostSearchService;

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
	
	ModelAndView mv=new ModelAndView();
	
	@RequestMapping("/board/search")
	public ModelAndView search(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		String keywords[]=request.getParameter("keyword").split(" ");
		String param= keywords[0];
		for(int i=1; i<keywords.length; i++) {
			param+="|"+keywords[i];
		}

		String target=request.getParameter("target");
		mv.addObject("boardList", boardService.getBoardList());
		mv.addObject("keyword", request.getParameter("keyword"));
		mv.addObject("target", target);
		switch(target) {
		case"0":
			mv.addObject("result",postSearchService.searchByTC(param));
			break;
		case"1":
			mv.addObject("result",postSearchService.searchByT(param));
			break;
		case"2":
			mv.addObject("result",postSearchService.searchByC(param));
			break;
		case"3":
			mv.addObject("result",postSearchService.searchByN(param));
			break;
		}
		mv.setViewName("page/search");
		return mv;
	}
	
	
	@RequestMapping("/board")
	public ModelAndView board(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		String pageNum=(String) request.getParameter("pageNum");
		String b_name = (String) request.getParameter("name");
		if (pageNum == null)
			pageNum = "1";
		mv.addObject("pageNum", pageNum);
		mv.addObject("postType", boardService.getBoardInf(b_name).getB_postType());
		mv.addObject("postCount", postInfoService.getPostCount(b_name));
		mv.addObject("postList", postInfoService.getPostList(b_name, Integer.valueOf(pageNum)));
		mv.addObject("errMsg", null);
		mv.addObject("name", b_name);
		mv.addObject("boardList", boardService.getBoardList());
		mv.setViewName("page/board");
		commons.setAlwaysReload(response);
		return mv;
	}

}
