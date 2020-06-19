package com.lorem.ipsum;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lorem.ipsum.exception.SessionFailException;
import com.lorem.ipsum.model.logon.UserModel;
import com.lorem.ipsum.service.LogonService;

public class commons {
	public static final String baseUrl="http://172.30.1.21:8085/";
	public static final int maxFileSize=1024*1024*1024;
	
	public static void setAlwaysReload(HttpServletResponse response) {
		response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
	}
	
	public static void logonCheck(HttpSession session, LogonService logonService) throws SessionFailException {
		if (session != null) {
			session.removeAttribute("referer");
			UserModel user = (UserModel) session.getAttribute("user");
			String msg = null;
			if (user != null) {
				msg = logonService.logonCheck(user.getU_id(), user.getU_session());
				if (msg!=null&&msg.split(":")[0].equals("INVALID")) {
					session.removeAttribute("user");
					throw new SessionFailException(SessionFailException.INVALID_SESSION);
				}
			}else {
				throw new SessionFailException(SessionFailException.NOT_LOGIN);
			}
		}else {
			throw new SessionFailException(SessionFailException.NOT_LOGIN);
		}
	}
	
	public enum USER_LEVEL{
		SYSTEM_ADMIN("시스템관리자",1),
		SITE_MANAGER("사이트관리자",2),
		BOARD_MANAGER("게시판관리자",3),
		LEVEL4("4등급", 4),
		LEVEL5("5등급", 5),
		ADVANCED_MEMBER("전문가",6),
		EDITER_MEMBER("편집가",7),
		NORMAL_MEMBER("일반회원",8),
		TEMP_MEMBER("임시회원", 9),
		VISITER("방문자", 10);
		
		private final int level;
		private final String label;
		private USER_LEVEL(String label, int level) {
			this.label=label;
			this.level=level;
		}
		public static USER_LEVEL valueOf(int val) {
			return USER_LEVEL.values()[val-1];
		}
		public String toString() {
			return label;
		}
		public int toInt() {
			return level;
		}
		public boolean com(int val) {
			return level<=val?true:false;
		}

		public boolean com(USER_LEVEL comp) {
			return (level<=comp.toInt()?true:false);
		}
		public boolean com(String val) {
			return level<=USER_LEVEL.valueOf(val).toInt()?true:false;
		}
		
	}
}
