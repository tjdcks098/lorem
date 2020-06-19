package com.lorem.ipsum.service.Impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.dao.PostSearchDao;
import com.lorem.ipsum.model.post.PostSearchModel;
import com.lorem.ipsum.service.PostSearchService;

@Service
public class PostSearchServiceImpl implements PostSearchService{

	@Autowired
	PostSearchDao postSearchDao;
	
	@Override
	public ArrayList<PostSearchModel> searchByTC(String keywords) {
		try {
			return postSearchDao.searchByTC(keywords);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public ArrayList<PostSearchModel> searchByT(String keywords) {
		try {
			return postSearchDao.searchByT(keywords);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public ArrayList<PostSearchModel> searchByC(String keywords) {
		try {
			return postSearchDao.searchByC(keywords);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public ArrayList<PostSearchModel> searchByN(String keywords) {
		try {
			return postSearchDao.searchByN(keywords);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
