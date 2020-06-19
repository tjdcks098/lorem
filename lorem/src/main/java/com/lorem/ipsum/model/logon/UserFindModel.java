package com.lorem.ipsum.model.logon;

import lombok.Data;

@Data
public class UserFindModel{
	String u_id;
	String u_email;
	String u_name;
	String u_pw;
	String find_hint;
	String msg;
}
