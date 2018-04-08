package com.swx.service;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/2.
 */
public interface BankAccountService {
    JSONObject getBankAccount(String userId);
    void saveBankAccount(HashMap map);
    boolean checkAccountNo(HashMap map);
    void deleteAccount(String accountNo);
    JSONObject getDepositRecords(String userId);
    JSONObject getWithdrawRecords(String userId);
    void saveOperationRecords(HashMap map);
    JSONObject getSavingStatistics(HashMap map);
}
