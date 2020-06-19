package com.lorem.ipsum.model.post;

import lombok.Data;

@Data
public class PostInfoModel {
	String p_title;
	int p_view;
	String p_lock;
	String u_id;
	String u_nick;
	String p_date;
	int p_id;
	String p_update;
	int p_like;
	String b_name;
	String hasPrev;
	String hasNext;
	String hasClip;
	String hasImg;
}
