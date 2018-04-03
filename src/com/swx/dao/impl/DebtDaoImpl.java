package com.swx.dao.impl;

import com.swx.dao.DebtDao;
import com.swx.factory.ObjectFactory;
import com.swx.util.JDBCTemplate;

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
}
