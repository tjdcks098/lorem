package com.lorem.ipsum.model.logon;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class UserCheckModel extends UserModel{
	String msg;
}
