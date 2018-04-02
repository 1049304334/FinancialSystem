package com.swx.service;

import com.swx.po.Family;
import com.swx.po.User;

import java.util.HashMap;

public interface LoginService {
	public HashMap<String,Object> loginCheck(String userName, String password);
	public boolean regeditCheck(String userName);
	public boolean regedit(User user,Family family);
	public HashMap<String,Object> getFamilyInfo(String familyId);
}
