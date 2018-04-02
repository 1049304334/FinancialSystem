package com.swx.util;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用于将查询结果ResultSet转换成集合。
 */
public class ResultSetToMap {

    public static List<Map<String ,Object>> resultSetToMap(ResultSet rs) throws SQLException {

        List<Map<String,Object>> infoList = new ArrayList<Map<String,Object>>();
        ResultSetMetaData metaData = rs.getMetaData();
        int cols = metaData.getColumnCount();
        List<String> colNames = new ArrayList<String>();
        for(int i=0;i<cols;i++){
            colNames.add(metaData.getColumnName(i+1));
        }
        while(rs.next()){
            Map map=new HashMap<String, Object>();
            for(int i=0;i<cols;i++){
                String key=colNames.get(i);
                Object value=rs.getString(colNames.get(i));
                map.put(key, value);
            }
            infoList.add(map);
        }
        return infoList;
    }
}
