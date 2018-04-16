package com.swx.service;

import com.alibaba.fastjson.JSONObject;
import com.swx.po.Family;
import com.swx.po.User;

import java.util.HashMap;

public interface LoginService {
	 HashMap<String,Object> loginCheck(String userName, String password);
	 boolean regeditCheck(String userName);
	 boolean regedit(User user, Family family);
	 HashMap<String,Object> getFamilyInfo(String familyId);
	 JSONObject getHomePageInfo(HashMap map);
	 JSONObject getUserInfo(String userId);
}
