package com.swx.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.swx.po.Family;
import com.swx.po.User;

public interface LoginDao {
	public List<HashMap<String,Object>> loginCheck(Map<String,Object> map);
	public List<HashMap<String,Object>> regeditChek(String userName);
	public void createFamily(Family family);
	public void createUser(User user);
	public List<HashMap<String,Object>> getFamilyInfo(String familyId);
}
