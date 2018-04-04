package com.swx.service;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public interface DebtService {
    JSONObject getDebts(String familyId);
    JSONObject getCreditors(String familyId);
    void saveCredit(HashMap map);
    void saveDebt(HashMap map);
    void editCredit(HashMap map);
    void editDebt(HashMap map);
    void deleteCredit(String lendId);
    void deleteDebt(String debtId);
}
