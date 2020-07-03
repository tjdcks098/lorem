package com.lorem.ipsum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.dailyReply;
import com.lorem.ipsum.model.post.ReplyModel;

@Repository
@Mapper
public interface ReplyDao {
	ArrayList<ReplyModel> getRecentlyAdded(String tdate);
	ArrayList<ReplyModel> getMyReply(String u_id);
	void unlikeReply(String b_name, int p_id, int r_index, String u_id);
	void likeReply(String b_name, int p_id, int r_index, String u_id);
	ArrayList<Integer> getLikedReplies(String u_id, String b_name, int p_id);
	ReplyModel getReply(int p_id, int r_index, String b_name);
	ArrayList<ReplyModel> getPostReplies(int p_id, String b_name);
	void submit(int p_id, String u_id, String contents, String b_name);
	void del(int p_id, String b_name, int r_index);
}
