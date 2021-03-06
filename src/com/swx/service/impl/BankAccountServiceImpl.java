package com.swx.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.BankAccountDao;
import com.swx.factory.ObjectFactory;
import com.swx.service.BankAccountService;
import com.swx.util.DateUtil;
import com.swx.util.PrimaryKeyUtil;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/2.
 */
public class BankAccountServiceImpl implements BankAccountService{

    BankAccountDao bankAccountDao = (BankAccountDao) ObjectFactory.getObject("bankAccountDao");
    PrimaryKeyUtil keyUtil = PrimaryKeyUtil.getKeyUtil();

    @Override
    public JSONObject getBankAccount(String userId) {
        JSONObject json = new JSONObject();
        List<HashMap> accountList = bankAccountDao.getBankAccount(userId);
        json.put("data",accountList);
        json.put("count",accountList.size());
        json.put("code","0");
        json.put("msg","");
        return json;
    }

    @Override
    public void saveBankAccount(HashMap map) {
        bankAccountDao.saveBankAccount(map);
    }

    @Override
    public boolean checkAccountNo(HashMap map) {
        List accList = bankAccountDao.checkAccountNo(map);
        if(accList.size()==0){
            return true;
        }
        return false;
    }

    @Override
    public void deleteAccount(String accountNo) {
        bankAccountDao.deleteAccount(accountNo);
    }

    @Override
    public JSONObject getDepositRecords(String userId) {
        JSONObject json = new JSONObject();
        List<HashMap> recordList = bankAccountDao.getDepositRecords(userId);
        json.put("data",recordList);
        json.put("count",recordList.size());
        json.put("code","0");
        json.put("msg","");
        return json;
    }

    @Override
    public JSONObject getWithdrawRecords(String userId) {
        JSONObject json = new JSONObject();
        List<HashMap> recordList = bankAccountDao.getWithdrawRecords(userId);
        json.put("data",recordList);
        json.put("count",recordList.size());
        json.put("code","0");
        json.put("msg","");
        return json;
    }

    @Override
    public void saveOperationRecords(HashMap map) {
        map.put("operationId",keyUtil.getKey());
        if("deposit".equals(map.get("operationType"))){
            bankAccountDao.saveDepositRecords(map);
        }else{
            bankAccountDao.saveWithdrawRecords(map);
        }
    }

    @Override
    public JSONObject getSavingStatistics(HashMap map) {
        JSONObject json = new JSONObject();
        List depositSum = bankAccountDao.getDepositSum(map);
        List withdrawSum = bankAccountDao.getWithdrawSum(map);
        System.out.println(depositSum);
        System.out.println(withdrawSum);
        json.put("depositSum",depositSum);
        json.put("withdrawSum",withdrawSum);
        return json;
    }

}
