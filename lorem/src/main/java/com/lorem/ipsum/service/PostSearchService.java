package com.lorem.ipsum.service;

import java.util.ArrayList;

import com.lorem.ipsum.model.post.PostSearchModel;

public interface PostSearchService {
	ArrayList<PostSearchModel> searchByTC(String keywords);
	ArrayList<PostSearchModel> searchByT(String keywords);
	ArrayList<PostSearchModel> searchByC(String keywords);
	ArrayList<PostSearchModel> searchByN(String keywords);
}
