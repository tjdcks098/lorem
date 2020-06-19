package com.lorem.ipsum.LoremException;

public class _LoginException extends Exception {
	private static final long serialVersionUID = 1L;
	public static final int NO_ACCOUNT= 1000;
	public static final int UNKNOWN_ERROR=9999;
	
	private String errMsg;
	private int errCode;
	public _LoginException() {
		super();
	}
	public _LoginException(String msg) {
		super(msg);
		errMsg=msg;
	}
	public _LoginException(String msg, int errCode) {
		super(msg+" - ERROR_CODE:"+errCode);
		errMsg=msg;
		this.errCode=errCode;
	}
	public String toString() {
		return errMsg+" - ERROR_CODE:"+errCode;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public int getErrCode() {
		return errCode;
	}
}
