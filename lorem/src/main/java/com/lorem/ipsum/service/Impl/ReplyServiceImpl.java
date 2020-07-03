package com.lorem.ipsum.service.Impl;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.dao.ReplyDao;
import com.lorem.ipsum.model.post.ReplyModel;
import com.lorem.ipsum.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public ArrayList<ReplyModel> getMyReply(String u_id){
		return replyDao.getMyReply(u_id);
	}
	
	@Override
	public ReplyModel getReply(int post, int index, String b_name) {
		ReplyModel reply=replyDao.getReply(post, index,  b_name);
		return reply;
	}
	


	@Override
	public ArrayList<ReplyModel> getPostReplies(int post, String b_name) {
		ArrayList<ReplyModel> replies=replyDao.getPostReplies(post,  b_name);
		return replies;
	}

	@Override
	public void submit(int p_id, String u_id, String contents, String b_name) {
		replyDao.submit(p_id, u_id, contents, b_name);
		
	}



	@Override
	public void del(String p_id, String b_name, String r_index) {
		replyDao.del(Integer.valueOf(p_id), b_name, Integer.valueOf(r_index));
	}



	@Override
	public ArrayList<Integer> getLikedReplies(String u_id, String b_name, String p_id) {
		return replyDao.getLikedReplies(u_id, b_name, Integer.valueOf(p_id));
	}

	@Override
	public boolean likeReply(String b_name, String p_id, String r_index, String u_id) {
		try {
			replyDao.likeReply(b_name, Integer.valueOf(p_id), Integer.valueOf(r_index), u_id);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	@Override
	public boolean unlikeReply(String b_name, String p_id, String r_index, String u_id) {
		try {
			replyDao.unlikeReply(b_name, Integer.valueOf(p_id), Integer.valueOf(r_index), u_id);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public ArrayList<ReplyModel> getRecentlyAdded() {
		Date td= new Date();
		td.setHours(td.getHours() - 6);
		String tdate = (td.getYear() - 100) + "/"
				+ (td.getMonth() >= 9 ? (td.getMonth() + 1) : "0" + (td.getMonth() + 1)) + "/"
				+ (td.getDate() >= 9 ? td.getDate() : "0" + td.getDate()) + " "
				+ (td.getHours() < 10 ? "0" + td.getHours() : td.getHours()) + ":"
				+ (td.getMinutes() < 10 ? "0" + td.getMinutes() : td.getMinutes()) + ":"
				+ (td.getSeconds() < 10 ? "0" + td.getSeconds() : td.getSeconds());
		return replyDao.getRecentlyAdded(tdate);
	}
}