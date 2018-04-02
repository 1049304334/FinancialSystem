package com.swx.dao;

import com.swx.po.Family;
import com.swx.po.IncomeRecord;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/27.
 */
public interface IncomeDao {

    List<HashMap<String,Object>> getIncomeRecord(String familyId);
    List<HashMap<String, Object>> getAllTypes(String familyId);
    void saveNewType(HashMap<String,String> typeMap);
    void deleteType(String typeId);
    List getTypes(String familyId);
    void saveIncomeRecord(HashMap map);
    List getExpandRecords(HashMap map);
    void saveExpandRecord(HashMap map);

}
