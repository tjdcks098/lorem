package com.lorem.ipsum.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.BoardModel;

@Repository
@Mapper
public interface BoardDao {
	BoardModel getBoardInf(String name);
	ArrayList<BoardModel> getBoardList();
}
