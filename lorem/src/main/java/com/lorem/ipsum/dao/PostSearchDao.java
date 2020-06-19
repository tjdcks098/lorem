package com.lorem.ipsum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.post.PostSearchModel;

@Repository
@Mapper
public interface PostSearchDao {
	ArrayList<PostSearchModel> searchByTC(String keywords);
	ArrayList<PostSearchModel> searchByT(String keywords);
	ArrayList<PostSearchModel> searchByC(String keywords);
	ArrayList<PostSearchModel> searchByN(String keywords);
}
