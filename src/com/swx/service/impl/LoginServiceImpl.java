package com.swx.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.LoginDao;
import com.swx.factory.ObjectFactory;
import com.swx.po.Family;
import com.swx.po.User;
import com.swx.service.LoginService;
import com.swx.util.DateUtil;
import com.swx.util.PrimaryKeyUtil;

public class LoginServiceImpl implements LoginService{

	PrimaryKeyUtil keyUtil = PrimaryKeyUtil.getKeyUtil();

	LoginDao loginDao = (LoginDao) ObjectFactory.getObject("loginDao");
	
	public HashMap<String,Object> loginCheck(String userName, String password) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userName",userName);
		map.put("password",password);
		List<HashMap<String,Object>> userList = loginDao.loginCheck(map);
		return userList.get(0);
	}

	@Override
	public boolean regeditCheck(String userName) {
		List<HashMap<String,Object>> userList = loginDao.regeditChek(userName);
		if(userList.size()==0){
			return true;
		}else{
			return false;
		}
	}

	public boolean regedit(User user, Family family){
		user.setId(keyUtil.getKey());
		family.setFamilyId(keyUtil.getKey());
		family.setAdminId(user.getId());
		user.setFamilyId(family.getFamilyId());
		loginDao.createFamily(family);
		loginDao.createUser(user);
		return true;
	}

	@Override
	public HashMap<String,Object> getFamilyInfo(String familyId) {
		return loginDao.getFamilyInfo(familyId).get(0);
	}

	@Override
	public JSONObject getHomePageInfo(HashMap map) {
		map.put("limitDate", DateUtil.computeDate("30"));
		JSONObject json = new JSONObject();
		json.put("recentIncome",loginDao.getRecentIncome(map).get(0));
		json.put("recentExpand",loginDao.getRecentExpand(map).get(0));
		json.put("recentCreditNum",loginDao.getRecentCreditNum(map).get(0));
		json.put("recentDebtNum",loginDao.getRecentDebtNum(map).get(0));
		json.put("recentNoteNum",loginDao.getRecentNoteNum(map).get(0));
		return json;
	}


}
