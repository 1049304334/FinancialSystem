package com.swx.mapper;

import com.swx.po.Family;

import java.sql.ResultSet;

/**
 * Created by Administrator on 2018/3/22.
 */
public class FamilyMapper implements RowMapper<Family>{
    @Override
    public Family mapRow(ResultSet rs) throws Exception {

        String familyId = rs.getString(1);
        String familyName = rs.getString(2);
        String adminId = rs.getString(3);

        return new Family(familyId,familyName,adminId);
    }
}
