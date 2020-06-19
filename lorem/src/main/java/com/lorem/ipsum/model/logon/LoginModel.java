package com.lorem.ipsum.model.logon;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class LoginModel extends UserCheckModel {
	String pw;
}
