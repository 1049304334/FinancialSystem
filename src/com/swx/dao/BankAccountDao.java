package com.swx.dao;


import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/2.
 */
public interface BankAccountDao {
    List getBankAccount(String userId);
    void saveBankAccount(HashMap map);
    List checkAccountNo(HashMap map);
    void deleteAccount(String accountNo);
    List getDepositRecords(String userId);
    List getWithdrawRecords(String userId);
    void saveDepositRecords(HashMap map);
    void saveWithdrawRecords(HashMap map);
    List getDepositSum(HashMap map);
    List getWithdrawSum(HashMap map);
}
