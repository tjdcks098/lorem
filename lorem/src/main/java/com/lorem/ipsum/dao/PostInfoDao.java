package com.lorem.ipsum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.post.PostInfoModel;

@Repository
@Mapper
public interface PostInfoDao {
	ArrayList<PostInfoModel> getMyPost(String u_id);
	void editPost(String b_name, int p_id, String title);
	String getPostCount(String b_name);
	void getPostInfo(PostInfoModel model);
	ArrayList<PostInfoModel> getPostList(String b_name, int pageNum);
	void addView(String p_id, String b_name);
	void addLike(String u_id, String p_id, String b_name);
	void subLike(String u_id, String p_id, String b_name);
	PostInfoModel newPost(PostInfoModel newPost);
	void delPost(String u_id, String p_id, String b_name);
}
