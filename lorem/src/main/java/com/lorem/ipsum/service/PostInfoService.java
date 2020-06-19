package com.lorem.ipsum.service;

import java.util.ArrayList;

import com.lorem.ipsum.model.post.PostInfoModel;

public interface PostInfoService {
	ArrayList<PostInfoModel> getMyPost(String u_id);
	boolean editPost(String b_name, String p_id, String title);
	String getPostCount(String b_name);
	PostInfoModel getPostInfo(String b_name, String p_id);
	ArrayList<PostInfoModel> getPostList(String b_name, int pageNum);
	void addView(String p_id, String b_name);
	void addLike(String u_id, String p_id, String b_name);
	void subLike(String u_id, String p_id, String b_name);
	PostInfoModel newPost(String p_title, String u_id, String b_name);
	boolean delPost(String u_id, String p_id, String b_name);
}
