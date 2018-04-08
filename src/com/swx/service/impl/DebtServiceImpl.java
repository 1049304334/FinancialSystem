package com.swx.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.DebtDao;
import com.swx.factory.ObjectFactory;
import com.swx.service.DebtService;
import com.swx.util.DateUtil;
import com.swx.util.PrimaryKeyUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public class DebtServiceImpl implements DebtService{

    DebtDao debtDao = (DebtDao) ObjectFactory.getObject("debtDao");
    PrimaryKeyUtil keyUtil = PrimaryKeyUtil.getKeyUtil();

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

    @Override
    public void saveCredit(HashMap map) {
        map.put("lendId",keyUtil.getKey());
        debtDao.saveCredit(map);
    }

    @Override
    public void saveDebt(HashMap map) {
        map.put("borrowId",keyUtil.getKey());
        debtDao.saveDebt(map);
    }

    @Override
    public void editCredit(HashMap map) {
        debtDao.editCredit(map);
    }

    @Override
    public void editDebt(HashMap map) {
        debtDao.editDebt(map);
    }

    @Override
    public void deleteCredit(String lendId) {
        debtDao.deleteCredit(lendId);
    }

    @Override
    public void deleteDebt(String debtId) {
        debtDao.deleteDebt(debtId);
    }

    @Override
    public JSONObject getStatisticsData(HashMap map) {
        JSONObject json = new JSONObject();
        map.put("repayDate", DateUtil.computeAfterDate((String) map.get("cycle")));
        json.put("totalCredit",(HashMap) debtDao.getCreditSum(map).get(0));
        json.put("totalDebt",(HashMap) debtDao.getDebtSum(map).get(0));
        json.put("repayingCredit",debtDao.getRepayingCredit(map));
        json.put("repayingDebt",debtDao.getRepayingDebt(map));
        return json;
    }
}
