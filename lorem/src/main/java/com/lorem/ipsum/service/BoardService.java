package com.lorem.ipsum.service;

import java.util.ArrayList;

import com.lorem.ipsum.model.BoardModel;

public interface BoardService {
	BoardModel getBoardInf(String name);
	ArrayList<BoardModel> getBoardList();
}
