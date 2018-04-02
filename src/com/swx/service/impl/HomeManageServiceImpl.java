package com.swx.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.HomeManageDao;
import com.swx.factory.ObjectFactory;
import com.swx.service.HomeManageService;
import com.swx.util.PrimaryKeyUtil;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/29.
 */
public class HomeManageServiceImpl implements HomeManageService{

    HomeManageDao homeManageDao = (HomeManageDao) ObjectFactory.getObject("homeManageDao");
    PrimaryKeyUtil keyUtil = PrimaryKeyUtil.getKeyUtil();

    @Override
    public void createNewMember(HashMap map) {
        map.put("id",keyUtil.getKey());
        homeManageDao.saveNewMember(map);
    }

    @Override
    public JSONObject getAllMembers(String familyId) {
        JSONObject json = new JSONObject();
        List memberList = homeManageDao.getAllMembers(familyId);
        json.put("code","0");
        json.put("msg","");
        json.put("count",memberList.size());
        json.put("data",memberList);
        return json;
    }

    @Override
    public void editMember(HashMap map) {
        homeManageDao.editMember(map);
    }
}
