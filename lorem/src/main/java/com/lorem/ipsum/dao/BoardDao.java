package com.lorem.ipsum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.BoardModel;
import com.lorem.ipsum.model.dailyReply;

@Repository
@Mapper
public interface BoardDao {
	void addDailyPost(int p_id, String u_id, String b_name, String content);
	BoardModel getBoardInf(String name);
	ArrayList<BoardModel> getBoardList();
	String getDailyPostId(String b_name, String d_key);
	void setDailyPostId(String b_name, String d_key, String p_id);
}
