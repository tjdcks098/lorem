package com.lorem.ipsum.exception;

public class SessionFailException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int UNKNOWN_EXCEPTION = 0;
	public static final int NO_SESSION_EXIST = 1;
	public static final int INVALID_SESSION = 2;
	public static final int LOGIN_OTHER_PLACE = 3;
	public static final int NOT_LOGIN = 4;
	
	private final String msg;
	private final int code;
	
	public SessionFailException(int code) {
		switch(code) {
		case 1:
			msg="세션이 없습니다.";
			this.code=code;
			break;
		case 2:
			msg="유효하지 않은 세션입니다.";
			this.code=code;
			break;
		case 3:
			msg="다른곳에서 접속했습니다";
			this.code=code;
			break;
		case 4:
			msg=null;
			this.code=code;
			break;
			
			default:
				msg="알 수 없는 예외가 발생했습니다.";
				this.code=code;
		}
	}
	public String getMsg() {
		return msg;
	}
	public int getCode() {
		return code;
	}
}
