package com.lorem.ipsum.service.Impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.dao.BoardDao;
import com.lorem.ipsum.model.BoardModel;
import com.lorem.ipsum.model.dailyReply;
import com.lorem.ipsum.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao boardDao;
	
	
	@Override
	public BoardModel getBoardInf(String name) {
		return boardDao.getBoardInf(name);
	}

	@Override
	public ArrayList<BoardModel> getBoardList() {
		return boardDao.getBoardList();
	}

	@Override
	public String getDailyPostId(String b_name, String d_key) {
		return boardDao.getDailyPostId(b_name, d_key);
	}

	@Override
	public String setDailyPostId(String b_name, String d_key) {
		String p_id="";
		boardDao.setDailyPostId(b_name, d_key, p_id);
		return p_id;
	}

	@Override
	public void addDailyPost(dailyReply reply, String u_id) {
		boardDao.addDailyPost(Integer.valueOf(boardDao.getDailyPostId(reply.getBoard(), reply.getDailyKey())), u_id, reply.getBoard(), reply.getContent());
		
	}

	@Override
	public boolean hasDailyPost(dailyReply reply, String u_id) {
		if(boardDao.hasDailyPost(Integer.valueOf(boardDao.getDailyPostId(reply.getBoard(), reply.getDailyKey())), u_id, reply.getBoard())==0)
			return false;
		return true;
	}

}
