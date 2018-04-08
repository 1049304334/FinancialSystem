package com.swx.dao.impl;

import com.swx.dao.DebtDao;
import com.swx.factory.ObjectFactory;
import com.swx.util.JDBCTemplate;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public class DebtDaoImpl implements DebtDao{

    JDBCTemplate jt = null;

    @Override
    public List getDebts(String familyId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_debt d,t_user u where d.family_id = ? and d.family_id = u.family_id and d.user_id = u.id";
        return jt.query(sql,familyId);
    }

    @Override
    public List getCreditors(String familyId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_creditor d,t_user u where d.family_id = ? and d.family_id = u.family_id and d.user_id = u.id";
        return jt.query(sql,familyId);
    }

    @Override
    public void saveCredit(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_creditor values(?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("lendId"),map.get("lenderName"),map.get("lendDate"),map.get("balance"),map.get("repayDate"),map.get("familyId"),map.get("userId"),map.get("remark"));
    }

    @Override
    public void saveDebt(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_debt values(?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("borrowId"),map.get("borrowerName"),map.get("borrowDate"),map.get("balance"),map.get("repayDate"),map.get("familyId"),map.get("userId"),map.get("remark"));
    }

    @Override
    public void editCredit(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "update t_creditor set balance = ?,repay_date = ?,remark = ? where lend_id = ?";
        jt.save(sql,map.get("balance"),map.get("repayDate"),map.get("remark"),map.get("lendId"));
    }

    @Override
    public void editDebt(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "update t_debt set balance = ?,repay_date = ?,remark = ? where borrow_id = ?";
        jt.save(sql,map.get("balance"),map.get("repayDate"),map.get("remark"),map.get("borrowId"));
    }

    @Override
    public void deleteCredit(String lendId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "delete from t_creditor where lend_id = ?";
        jt.delete(sql,lendId);
    }

    @Override
    public void deleteDebt(String debtId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "delete from t_debt where borrow_id = ?";
        jt.delete(sql,debtId);
    }

    @Override
    public List getCreditSum(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select sum(balance) as totalCredit from t_creditor where family_id = ? ";
        return jt.query(sql,map.get("familyId"));
    }

    @Override
    public List getDebtSum(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select sum(balance) as totalDebt from t_debt where family_id = ? ";
        return jt.query(sql,map.get("familyId"));
    }

    @Override
    public List getRepayingCredit(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_creditor where repay_date > (select now()) and repay_date < ? and family_id = ? order by repay_date asc";
        return jt.query(sql,map.get("repayDate"),map.get("familyId"));
    }

    @Override
    public List getRepayingDebt(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_debt where repay_date > (select now()) and repay_date < ? and family_id = ? order by repay_date asc";
        return jt.query(sql,map.get("repayDate"),map.get("familyId"));
    }
}
