package com.lorem.ipsum.service.Impl;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.dao.PostContentsDao;
import com.lorem.ipsum.dao.PostInfoDao;
import com.lorem.ipsum.model.post.PostInfoModel;
import com.lorem.ipsum.service.PostInfoService;

@Service
public class PostInfoServiceImpl implements PostInfoService {
	@Autowired
	PostInfoDao postInfoDao;

	@Autowired
	PostContentsDao postContentsDao;

	@Override
	public String getPostCount(String b_name) {
		return postInfoDao.getPostCount(b_name);
	}

	@Override
	public PostInfoModel getPostInfo(String b_name, String p_id) {
		PostInfoModel temp = new PostInfoModel();
		temp.setB_name(b_name);
		temp.setP_id(Integer.valueOf(p_id));
		try {
			postInfoDao.getPostInfo(temp);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return temp;
	}

	@Override
	public ArrayList<PostInfoModel> getPostList(String b_name, int pageNum) {
		ArrayList<PostInfoModel> plist = postInfoDao.getPostList(b_name, pageNum);
		System.out.println(plist.size());
		for (PostInfoModel p : plist) {
			p.setHasClip(postContentsDao.hasClip(p.getP_id(), p.getB_name()));
			p.setHasImg(postContentsDao.hasImg(p.getP_id(), p.getB_name()));
		}
		return plist;
	}

	@Override
	public void addView(String p_id, String b_name) {
		postInfoDao.addView(p_id, b_name);
	}

	@Override
	public void addLike(String u_id, String p_id, String b_name) {
		postInfoDao.addLike(u_id, p_id, b_name);
	}

	@Override
	public void subLike(String u_id, String p_id, String b_name) {
		postInfoDao.subLike(u_id, p_id, b_name);

	}

	@Override
	public PostInfoModel newPost(String p_title, String u_id, String b_name) {
		PostInfoModel np = new PostInfoModel();
		np.setP_title(p_title);
		np.setU_id(u_id);
		np.setB_name(b_name);
		postInfoDao.newPost(np);
		return np;
	}

	@Override
	public boolean delPost(String u_id, String p_id, String b_name) {
		try {
			postInfoDao.delPost(u_id, p_id, b_name);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean editPost(String b_name, String p_id, String title) {
		boolean re = true;
		try {
			postInfoDao.editPost(b_name, Integer.valueOf(p_id), title);
		} catch (Exception e) {
			e.printStackTrace();
			re = false;
		}

		return re;
	}

	@Override
	public ArrayList<PostInfoModel> getMyPost(String u_id) {
		return postInfoDao.getMyPost(u_id);
	}

	@Override
	public ArrayList<PostInfoModel> getRecentlyAdded() {
		Date td = new Date();
		td.setHours(td.getHours() - 6);
		String tdate = (td.getYear() - 100) + "/"
				+ (td.getMonth() >= 9 ? (td.getMonth() + 1) : "0" + (td.getMonth() + 1)) + "/"
				+ (td.getDate() >= 9 ? td.getDate() : "0" + td.getDate()) + " "
				+ (td.getHours() < 10 ? "0" + td.getHours() : td.getHours()) + ":"
				+ (td.getMinutes() < 10 ? "0" + td.getMinutes() : td.getMinutes()) + ":"
				+ (td.getSeconds() < 10 ? "0" + td.getSeconds() : td.getSeconds());
		return postInfoDao.getRecentlyAdded(tdate);
	}

}
