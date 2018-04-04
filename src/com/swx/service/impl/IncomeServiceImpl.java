package com.swx.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.swx.dao.IncomeDao;
import com.swx.factory.ObjectFactory;
import com.swx.service.IncomeService;
import com.swx.util.DateUtil;
import com.swx.util.PrimaryKeyUtil;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/27.
 */
public class IncomeServiceImpl implements IncomeService{

    IncomeDao incomeDao = (IncomeDao) ObjectFactory.getObject("incomeDao");
    PrimaryKeyUtil keyUtil = PrimaryKeyUtil.getKeyUtil();

    @Override
    public List<HashMap<String, Object>> getIncomeRecord(String familyId) {
        return incomeDao.getIncomeRecord(familyId);
    }

    @Override
    public List<HashMap<String, Object>> getAllTypes(String familyId) {
        return incomeDao.getAllTypes(familyId);
    }

    @Override
    public void saveNewType(HashMap<String, String> typeMap) {
        typeMap.put("isDeleted","0");
        if("1".equals(typeMap.get("typeDirection"))){
            typeMap.put("typeDirection","收入");
        }else{
            typeMap.put("typeDirection","支出");
        }
        typeMap.put("typeId",keyUtil.getKey());
        incomeDao.saveNewType(typeMap);
    }

    @Override
    public void deleteType(String typeId) {
        incomeDao.deleteType(typeId);
    }

    @Override
    public JSONObject getTypes(String familyId) {
        List<HashMap> typeMap = incomeDao.getTypes(familyId);
        JSONObject json = new JSONObject();
        json.put("types",typeMap);
        return json;
    }

    @Override
    public void saveIncomeRecord(HashMap map) {
        map.put("incomeId",keyUtil.getKey());
        incomeDao.saveIncomeRecord(map);
    }

    @Override
    public JSONObject getExpandRecord(HashMap map) {
        JSONObject json = new JSONObject();
        List recordList = incomeDao.getExpandRecords(map);
        json.put("data",recordList);
        json.put("count",recordList.size());
        json.put("code","0");
        json.put("msg","");
        return json;
    }

    @Override
    public void saveExpandRecord(HashMap map) {
        map.put("expandId",keyUtil.getKey());
        incomeDao.saveExpandRecord(map);
    }

    @Override
    public JSONObject getStatisticData(HashMap map) {

        map.put("startDate", DateUtil.computeDate((String) map.get("cycle")));

        JSONObject json = new JSONObject();
        HashMap totalIncome = (HashMap) incomeDao.getTotalIncome(map).get(0);
        HashMap totalExpand = (HashMap) incomeDao.getTotalExpand(map).get(0);
        List countIncomeByType = incomeDao.getIncomeTypeTotal(map);
        List countOutcomeByType = incomeDao.getExpandTypeTotal(map);
        json.put("income",totalIncome);
        json.put("expand",totalExpand);
        json.put("countIncomeByType",countIncomeByType);
        json.put("countOutcomeByType",countOutcomeByType);
        return json;
    }


}
