package com.lorem.ipsum.service.Impl;

import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lorem.ipsum.LoremException._LoginException;
import com.lorem.ipsum.dao.LogonDao;
import com.lorem.ipsum.model.logon.JoinModel;
import com.lorem.ipsum.model.logon.LoginModel;
import com.lorem.ipsum.model.logon.UserCheckModel;
import com.lorem.ipsum.model.logon.UserFindModel;
import com.lorem.ipsum.model.logon.UserInfoModel;
import com.lorem.ipsum.model.logon.UserModel;
import com.lorem.ipsum.service.LogonService;

@Service
public class LogonServiceImpl implements LogonService {
	@Autowired
	private LogonDao logonDao;

	@Override
	public UserModel login(String u_id, String pw) throws _LoginException {
		LoginModel loginModel = new LoginModel();
		loginModel.setU_id(u_id);
		loginModel.setPw(pw);
		try {
			logonDao.login(loginModel);
			UserModel userModel = new UserModel();
			userModel.setU_id(loginModel.getU_id());
			userModel.setU_level(loginModel.getU_level());
			userModel.setU_nick(loginModel.getU_nick());
			userModel.setU_session(loginModel.getU_session());
			return userModel;
		} catch (MyBatisSystemException e) {
			throw new _LoginException("회원 정보를 찾을 수 없습니다.");
		} catch (Exception e) {
			throw new _LoginException("알 수 없는 오류가 발생했습니다.");
		}
	}

	@Override
	public void logout(String u_id, String u_session) {
		UserCheckModel userCheckModel = new UserCheckModel();
		userCheckModel.setU_id(u_id);
		userCheckModel.setU_session(u_session);
		logonDao.logout(userCheckModel);
	}

	@Override
	public String logonCheck(String u_id, String u_session) {
		try {
			UserCheckModel userCheckModel = new UserCheckModel();
			userCheckModel.setU_id(u_id);
			userCheckModel.setU_session(u_session);
			logonDao.checkLogon(userCheckModel);
			return userCheckModel.getMsg();
		} catch (Exception e) {
			return "유효하지 않으 접속입니다.";
		}
	}

	@Override
	public String isIdDuple(String u_id) {
		String[] banList = { "admin" };

		for (String ban : banList)
			if (u_id.matches(".*(?i)" + ban + ".*"))
				return ban;
		return logonDao.isIdDuple(u_id);
	}

	@Override
	public String isNickDuple(String u_nick) {
		String[] banList = { "admin", "관리자" };

		for (String ban : banList)
			if (u_nick.matches(".*(?i)" + ban + ".*"))
				return ban;
		return logonDao.isNickDuple(u_nick);
	}

	@Override
	public JoinModel join(JoinModel joinInfo) {
		logonDao.join(joinInfo);
		return joinInfo;
	}

	@Override
	public String findId(String u_name, String u_email) {
		UserFindModel user = new UserFindModel();
		user.setU_name(u_name);
		user.setU_email(u_email);
		logonDao.findId(user);
		if (user.getU_id() != null)
			return user.getU_id();
		return "0";
	}

	@Override
	public String findPw(String u_name, String u_id, String u_email) {
		UserFindModel user = new UserFindModel();
		user.setU_name(u_name);
		user.setU_email(u_email);
		user.setU_id(u_id);
		logonDao.findPw(user);
		if (user.getU_pw() != null) {
			String u_pw=user.getU_pw();
			String rstr=u_pw.substring(0, 3);
			for(int i=0; i<u_pw.length()-3; i++)rstr+="*";
			rstr+=":"+user.getFind_hint();
			return rstr;
		}
		return "0";
	}

	@Override
	public UserInfoModel getUserInfo(String u_id) {
		return logonDao.getUserInfo(u_id);
	}

	@Override
	public void changePw(String u_id,String new_pw) {
		logonDao.changePw(u_id,new_pw);

	}

	@Override
	public void editInfo(String u_id, String u_nick, String u_email, String u_phnum, String u_intro) {
		logonDao.editInfoPri( u_id, u_email, u_phnum);
		logonDao.editInfoPub( u_id,u_nick, u_intro);
	}
}
