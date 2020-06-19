package com.lorem.ipsum.service;


import com.lorem.ipsum.LoremException._LoginException;
import com.lorem.ipsum.model.logon.JoinModel;
import com.lorem.ipsum.model.logon.UserInfoModel;
import com.lorem.ipsum.model.logon.UserModel;

public interface LogonService {
	void changePw(String u_id, String new_pw);
	void editInfo(String u_id, String u_nick, String u_email, String u_phnum, String u_intro);
	UserInfoModel getUserInfo(String u_id);
	String findId(String u_name, String u_email);
	String findPw(String u_name, String u_id, String u_email);
	String isNickDuple(String u_nick);
	String isIdDuple(String u_id);
	UserModel login(String u_id,String pw) throws _LoginException;
	void logout(String u_id, String u_session);
	String logonCheck(String u_id, String u_session);
	JoinModel join(JoinModel joinInfo);
}
