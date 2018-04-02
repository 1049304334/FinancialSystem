package com.swx.service;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/27.
 */
public interface IncomeService {

    List<HashMap<String,Object>> getIncomeRecord(String familyId);
    List<HashMap<String,Object>> getAllTypes(String familyId);
    void saveNewType(HashMap<String,String> typeMap);
    void deleteType(String typeId);
    JSONObject getTypes(String familyId);
    void saveIncomeRecord(HashMap map);
    JSONObject getExpandRecord(HashMap map);
    void saveExpandRecord(HashMap map);
}