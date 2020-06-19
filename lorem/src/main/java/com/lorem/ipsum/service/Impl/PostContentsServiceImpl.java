package com.lorem.ipsum.service.Impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.dao.PostContentsDao;
import com.lorem.ipsum.model.post.PostContentsModel;
import com.lorem.ipsum.model.post.PostFileModel;
import com.lorem.ipsum.service.PostContentsService;

@Service
public class PostContentsServiceImpl implements PostContentsService {
	@Autowired
	PostContentsDao postContentsDao;
	@Override
	public String hasClip(int p_id, String b_name) {
		return postContentsDao.hasClip(p_id, b_name);
	}
	@Override
	public PostContentsModel getContents(int p_id, String b_name) {
		return postContentsDao.getContents(p_id, b_name);
	}

	@Override
	public ArrayList<PostFileModel> getFiles(String p_id, String b_name) {
		return postContentsDao.getFiles(Integer.valueOf(p_id), b_name);
	}

	@Override
	public void setContents(int p_id, String b_name, String p_contents) {
		postContentsDao.setContents(p_id, b_name, p_contents);
	}

	@Override
	public void addFile(int p_id, String b_name, String type, String f_name, String f_url) {
		postContentsDao.addFile(p_id, b_name, type, f_name, f_url);
		
	}

	@Override
	public String isLike(String u_id, int p_id, String b_name) {
		if(postContentsDao.isLike(u_id, p_id, b_name)>0) {
		return "true";
		}
		return "false";
	}

	@Override
	public PostFileModel getFile(String p_id, String b_name, String f_name, String f_type) {
		return postContentsDao.getFile(Integer.valueOf(p_id), b_name, f_name, f_type);
	}

	@Override
	public boolean editContents(String p_id, String b_name, String contents) {
		try {
		postContentsDao.editContents(Integer.valueOf(p_id), b_name, contents);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public void delFile(String p_id, String b_name, String f_url) {
		postContentsDao.delFile(Integer.valueOf(p_id), b_name, f_url);

	}
	@Override
	public String hasImg(int p_id, String b_name) {
		return postContentsDao.hasImg(p_id, b_name);
	}



}
