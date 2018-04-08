package com.swx.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.swx.po.Family;
import com.swx.po.User;

public interface LoginDao {
	 List<HashMap<String,Object>> loginCheck(Map<String,Object> map);
	 List<HashMap<String,Object>> regeditChek(String userName);
	 void createFamily(Family family);
	 void createUser(User user);
	 List<HashMap<String,Object>> getFamilyInfo(String familyId);

	 List getRecentIncome(HashMap map);
	 List getRecentExpand(HashMap map);
	 List getRecentCreditNum(HashMap map);
	 List getRecentDebtNum(HashMap map);
	 List getRecentNoteNum(HashMap map);

}
