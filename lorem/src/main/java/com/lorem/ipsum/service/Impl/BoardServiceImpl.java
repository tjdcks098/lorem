package com.lorem.ipsum.service.Impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.dao.BoardDao;
import com.lorem.ipsum.model.BoardModel;
import com.lorem.ipsum.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public BoardModel getBoardInf(String name) {
		return boardDao.getBoardInf(name);
	}

	@Override
	public ArrayList<BoardModel> getBoardList() {
		return boardDao.getBoardList();
	}

}
