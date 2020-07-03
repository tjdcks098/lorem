package com.lorem.ipsum.service;

import java.util.ArrayList;

import com.lorem.ipsum.model.post.ReplyModel;

public interface ReplyService{
	ArrayList<ReplyModel> getRecentlyAdded();
	ArrayList<ReplyModel> getMyReply(String u_id);
	boolean unlikeReply(String b_name, String p_id, String r_index, String u_id);
	boolean likeReply(String b_name, String p_id, String r_index, String u_id);
	ArrayList<Integer> getLikedReplies(String u_id, String b_name, String p_id);
	ReplyModel getReply(int post, int index, String b_name);
	ArrayList<ReplyModel> getPostReplies(int post, String b_name);
	void submit(int p_id, String u_id, String contents, String b_name);
	void del(String p_id, String b_name, String r_index);
}
