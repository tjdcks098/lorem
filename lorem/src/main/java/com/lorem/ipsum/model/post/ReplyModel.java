package com.lorem.ipsum.model.post;

import lombok.Data;

@Data
public class ReplyModel {
	String contents;
	String u_id;
	String r_date;
	String r_lock;
	int r_like;
	String u_nick;
	int r_index;
	String b_name;
	String p_id;
}
