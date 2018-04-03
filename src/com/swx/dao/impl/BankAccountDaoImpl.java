package com.swx.dao.impl;

import com.swx.dao.BankAccountDao;
import com.swx.factory.ObjectFactory;
import com.swx.util.JDBCTemplate;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/2.
 */
public class BankAccountDaoImpl implements BankAccountDao{

    JDBCTemplate jt = null;

    @Override
    public List getBankAccount(String userId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_bank_account where user_id = ?";
        return jt.query(sql,userId);
    }

    @Override
    public void saveBankAccount(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_bank_account values(?,?,?,?,?)";
        jt.save(sql,map.get("accountNo"),map.get("bankName"),map.get("bankAddress"),map.get("userId"),map.get("familyId"));
    }

    @Override
    public List checkAccountNo(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_bank_account where account_no = ?";
        return jt.query(sql,map.get("accountNo"));
    }

    @Override
    public void deleteAccount(String accountNo) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "delete from t_bank_account where account_no = ?";
        jt.delete(sql,accountNo);
    }

    @Override
    public List getDepositRecords(String userId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_bank_operation where user_id = ? and operation_type = '存款'";
        return jt.query(sql,userId);
    }

    @Override
    public List getWithdrawRecords(String userId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_bank_operation where user_id = ? and operation_type = '取款'";
        return jt.query(sql,userId);
    }

    @Override
    public void saveDepositRecords(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_bank_operation values(?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("operationId"),map.get("bankAccount"),"存款",map.get("operationDate"),map.get("operationAmount"),map.get("userId"),map.get("familyId"),map.get("operationRemark"));
    }

    @Override
    public void saveWithdrawRecords(HashMap map) {
        System.out.println(map);
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_bank_operation values(?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("operationId"),map.get("bankAccount"),"取款",map.get("operationDate"),map.get("operationAmount"),map.get("userId"),map.get("familyId"),map.get("operationRemark"));
    }
}
