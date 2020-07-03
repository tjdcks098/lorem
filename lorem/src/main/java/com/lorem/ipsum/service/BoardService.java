package com.lorem.ipsum.service;

import java.util.ArrayList;

import com.lorem.ipsum.model.BoardModel;
import com.lorem.ipsum.model.dailyReply;

public interface BoardService {
	boolean hasDailyPost(dailyReply reply, String u_id);
	void addDailyPost(dailyReply reply , String u_id);
	String getDailyPostId(String b_name, String d_key);
	String setDailyPostId(String b_name, String d_key);
	BoardModel getBoardInf(String name);
	ArrayList<BoardModel> getBoardList();
}
