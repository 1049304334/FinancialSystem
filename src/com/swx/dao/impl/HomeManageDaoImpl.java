package com.swx.dao.impl;

import com.swx.dao.HomeManageDao;
import com.swx.factory.ObjectFactory;
import com.swx.util.JDBCTemplate;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/29.
 */
public class HomeManageDaoImpl implements HomeManageDao{

    JDBCTemplate jt = null;

    @Override
    public void saveNewMember(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_user values(?,?,?,?,?)";
        jt.save(sql,map.get("id"),map.get("trueName"),map.get("familyId"),map.get("userName"),map.get("password"));
    }

    @Override
    public List getAllMembers(String familyId) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select * from t_user where family_id = ?";
        return jt.query(sql,familyId);
    }

    @Override
    public void editMember(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "update t_user set true_name = ? ,password = ? where id = ?";
        jt.update(sql,map.get("trueName"),map.get("password"),map.get("userId"));
    }
}
