package com.lorem.ipsum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.post.PostContentsModel;
import com.lorem.ipsum.model.post.PostFileModel;

@Repository
@Mapper
public interface PostContentsDao {
	String hasImg(int p_id, String b_name);
	String hasClip(int p_id, String b_name);
	void delFile(int p_id, String b_name, String f_url);
	void editContents(int p_id, String b_name, String p_contents);
	PostContentsModel getContents(int p_id, String b_name);
	ArrayList<PostFileModel> getFiles(int p_id, String b_name);
	PostFileModel getFile(int p_id, String b_name, String f_name, String f_type);
	void setContents(int p_id, String b_name, String p_contents);
	void addFile(int p_id, String b_name, String type, String f_name, String f_url);
	int isLike(String u_id, int p_id, String b_name);
}
