package com.swx.dao.impl;

import com.swx.dao.IncomeDao;
import com.swx.factory.ObjectFactory;
import com.swx.po.Family;
import com.swx.po.IncomeRecord;
import com.swx.util.JDBCTemplate;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/27.
 */
public class IncomeDaoImpl implements IncomeDao{

    JDBCTemplate jt = null;

    @Override
    public List<HashMap<String,Object>> getIncomeRecord(String familyId) {

        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        StringBuilder sql = new StringBuilder("SELECT ");
        sql.append("i.amount,i.income_date,i.remark,")
           .append("t.type_name,u.true_name")
           .append(" FROM ")
           .append("t_income i,t_inout_type t,t_user u  ")
           .append("WHERE")
           .append(" i.user_id = u.id ")
           .append("AND")
           .append(" t.family_id = i.family_id ")
           .append("AND")
           .append(" t.family_id = u.family_id ")
           .append("AND")
           .append(" i.family_id = u.family_id ")
           .append("AND")
           .append(" i.income_type = t.type_id ")
           .append("AND")
           .append(" t.type_direction = '收入' ")
           .append("AND")
           .append(" t.family_id = ? ");
        return jt.query(sql.toString(),familyId);
    }

    @Override
    public List<HashMap<String, Object>> getAllTypes(String familyId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_inout_type where family_id = ? and is_deleted = '0'";
        return jt.query(sql,familyId);
    }

    @Override
    public void saveNewType(HashMap<String, String> typeMap) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_inout_type values(?,?,?,?,?)";
        jt.save(sql,typeMap.get("typeId"),typeMap.get("typeName"),typeMap.get("familyId"),typeMap.get("typeDirection"),typeMap.get("isDeleted"));
    }

    @Override
    public void deleteType(String typeId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "update t_inout_type set is_deleted = '1' where type_id = ?";
        jt.update(sql,typeId);
    }

    @Override
    public List getTypes(String familyId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_inout_type where family_id = ? and is_deleted = '0'";
        return jt.query(sql,familyId);
    }

    @Override
    public void saveIncomeRecord(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_income values (?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("incomeId"),map.get("incomeType"),map.get("familyId"),map.get("incomeDate"),map.get("incomeAmount"),map.get("bankAccount"),map.get("userId"),map.get("incomeRemark"));
    }

    @Override
    public List getExpandRecords(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        StringBuilder sql = new StringBuilder("SELECT ");
        sql.append("o.amount,o.outcome_date,o.remark,")
                .append("t.type_name,u.true_name")
                .append(" FROM ")
                .append("t_outcome o,t_inout_type t,t_user u  ")
                .append("WHERE")
                .append(" o.user_id = u.id ")
                .append("AND")
                .append(" t.family_id = o.family_id ")
                .append("AND")
                .append(" t.family_id = u.family_id ")
                .append("AND")
                .append(" o.family_id = u.family_id ")
                .append("AND")
                .append(" o.outcome_type = t.type_id ")
                .append("AND")
                .append(" t.type_direction = '支出' ")
                .append("AND")
                .append(" t.family_id = ? ");
        return jt.query(sql.toString(),map.get("familyId"));
    }

    @Override
    public void saveExpandRecord(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_outcome values (?,?,?,?,?,?,?,?)";
        jt.save(sql,map.get("expandId"),map.get("expandType"),map.get("familyId"),map.get("expandDate"),map.get("expandAmount"),map.get("bankAccount"),map.get("userId"),map.get("expandRemark"));
    }
}
