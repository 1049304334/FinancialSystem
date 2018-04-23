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
        StringBuilder sql = new StringBuilder("select");
        sql.append(" o.bank_operation_id,o.account_no,o.operation_date,o.amount,o.remark")
            .append(" from")
            .append(" t_bank_operation o,t_bank_account a")
            .append(" where")
            .append(" o.account_no = a.account_no")
            .append(" and")
            .append(" o.user_id = a.user_id")
            .append(" and")
            .append(" o.family_id = a.family_id")
            .append(" and")
            .append(" o.user_id = ?")
            .append(" and ")
            .append(" o.operation_type = '存款'")
            .append(" order by operation_date desc");
        return jt.query(sql.toString(),userId);
    }

    @Override
    public List getWithdrawRecords(String userId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        StringBuilder sql = new StringBuilder("select");
        sql.append(" o.bank_operation_id,o.account_no,o.operation_date,o.amount,o.remark")
                .append(" from")
                .append(" t_bank_operation o,t_bank_account a")
                .append(" where")
                .append(" o.account_no = a.account_no")
                .append(" and")
                .append(" o.user_id = a.user_id")
                .append(" and")
                .append(" o.family_id = a.family_id")
                .append(" and")
                .append(" o.user_id = ?")
                .append(" and ")
                .append(" o.operation_type = '取款'")
                .append(" order by operation_date desc");
        return jt.query(sql.toString(),userId);
    }

    @Override
    public void saveDepositRecords(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_bank_operation values(?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("operationId"),map.get("bankAccount"),"存款",map.get("operationDate"),map.get("operationAmount"),map.get("userId"),map.get("familyId"),map.get("operationRemark"));
    }

    @Override
    public void saveWithdrawRecords(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_bank_operation values(?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("operationId"),map.get("bankAccount"),"取款",map.get("operationDate"),map.get("operationAmount"),map.get("userId"),map.get("familyId"),map.get("operationRemark"));
    }

    @Override
    public List getDepositSum(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql1 = "select bank_name,t_bank_operation.account_no,sum(amount) as depositSum from t_bank_operation,t_bank_account where t_bank_operation.family_id = ? and t_bank_operation.family_id = t_bank_account.family_id and t_bank_operation.user_id = t_bank_account.user_id and operation_type = '存款' and operation_date > ? group by t_bank_operation.account_no";
        StringBuilder sql = new StringBuilder("select ");
        sql.append("a.bank_name,o.account_no,sum(amount) as depositSum ")
           .append("from ")
           .append("t_bank_account a,t_bank_operation o ")
           .append("where ")
           .append("a.account_no= o.account_no ")
           .append("and ")
           .append("a.user_id = o.user_id ")
           .append("and ")
           .append("a.family_id = o.family_id ")
           .append("and ")
           .append("o.family_id = ? ")
           .append("and ")
           .append("operation_type = '存款' ")
           .append("and ")
           .append("operation_date >= ? ")
           .append("and ")
           .append("operation_date <= ? ")
           .append("group by ")
           .append("o.account_no");

        return jt.query(sql.toString(),map.get("familyId"),map.get("startDate"),map.get("endDate"));
    }

    @Override
    public List getWithdrawSum(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        StringBuilder sql = new StringBuilder("select ");
        sql.append("a.bank_name,o.account_no,sum(amount) as withdrawSum ")
                .append("from ")
                .append("t_bank_account a,t_bank_operation o ")
                .append("where ")
                .append("a.account_no= o.account_no ")
                .append("and ")
                .append("a.user_id = o.user_id ")
                .append("and ")
                .append("a.family_id = o.family_id ")
                .append("and ")
                .append("o.family_id = ? ")
                .append("and ")
                .append("operation_type = '取款' ")
                .append("and ")
                .append("operation_date >= ? ")
                .append("and ")
                .append("operation_date <= ? ")
                .append("group by ")
                .append("o.account_no");
        return jt.query(sql.toString(),map.get("familyId"),map.get("startDate"),map.get("endDate"));
    }
}
