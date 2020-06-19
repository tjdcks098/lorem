package com.lorem.ipsum.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.lorem.ipsum.model.logon.JoinModel;
import com.lorem.ipsum.model.logon.LoginModel;
import com.lorem.ipsum.model.logon.UserCheckModel;
import com.lorem.ipsum.model.logon.UserFindModel;
import com.lorem.ipsum.model.logon.UserInfoModel;


@Repository
@Mapper
public interface LogonDao {
	void changePw(String u_id, String new_pw);
	void editInfo(String u_id, String u_nick, String u_email, String u_phnum, String u_intro);
	UserInfoModel getUserInfo(String u_id);
	void findId(UserFindModel user);
	void findPw(UserFindModel user);
	void join(JoinModel joinInfo);
	String isNickDuple(String u_id);
	String isIdDuple(String u_id);
	UserCheckModel checkLogon(UserCheckModel userCheckModel);
	LoginModel login(LoginModel loginModel);
	void logout(UserCheckModel userCheckModel);
}
