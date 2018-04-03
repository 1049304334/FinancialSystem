package com.swx.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.DebtDao;
import com.swx.factory.ObjectFactory;
import com.swx.service.DebtService;

import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public class DebtServiceImpl implements DebtService{

    DebtDao debtDao = (DebtDao) ObjectFactory.getObject("debtDao");

    @Override
    public JSONObject getDebts(String familyId) {

        List debtList = debtDao.getDebts(familyId);
        JSONObject json = new JSONObject();
        json.put("code","0");
        json.put("msg","");
        json.put("data",debtList);
        json.put("count",debtList.size());
        return json;
    }

    @Override
    public JSONObject getCreditors(String familyId) {

        List credList = debtDao.getCreditors(familyId);
        JSONObject json = new JSONObject();
        json.put("code","0");
        json.put("msg","");
        json.put("data",credList);
        json.put("count",credList.size());
        return json;
    }
}
