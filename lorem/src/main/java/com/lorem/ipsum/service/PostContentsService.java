package com.lorem.ipsum.service;

import java.util.ArrayList;

import com.lorem.ipsum.model.post.PostContentsModel;
import com.lorem.ipsum.model.post.PostFileModel;

public interface PostContentsService {
	void delFile(String p_id, String b_name,String f_url);
	boolean editContents(String p_id, String b_name, String contents);
	PostContentsModel getContents(int p_id, String b_name);
	ArrayList<PostFileModel> getFiles(String p_id, String b_name);
	PostFileModel getFile(String p_id, String b_name, String f_name, String f_type);
	void setContents(int p_id, String b_name, String p_contents);
	void addFile(int p_id, String b_name, String type, String f_name, String f_url);
	String isLike(String u_id, int p_id, String b_name);
	String hasClip(int p_id, String b_name);
	String hasImg(int p_id, String b_name);
}
