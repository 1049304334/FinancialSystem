package com.swx.dao.impl;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.NoteDao;
import com.swx.factory.ObjectFactory;
import com.swx.util.JDBCTemplate;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/30.
 */
public class NoteDaoImpl implements NoteDao{

    JDBCTemplate jt = null;
    @Override
    public void saveNote(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "insert into t_notes values (?,?,?,?,?)";
        jt.save(sql,map.get("noteId"),map.get("tipTime"),map.get("noteContent"),map.get("userId"),map.get("familyId"));
    }

    @Override
    public List getAllNotes(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        StringBuilder sql = new StringBuilder("select n.note_id,n.tip_time,n.note_content,u.true_name from t_notes n,t_user u ");
        sql.append("where n.user_id = u.id and n.family_id = u.family_id and n.family_id = ?");

        return jt.query(sql.toString(),map.get("familyId"));
    }

    @Override
    public List getNoteTips(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "select note_id,note_content from t_notes where tip_time < ? and tip_time > (select now()) and family_id = ?";
        return jt.query(sql,map.get("tipTime"),map.get("familyId"));
    }

    @Override
    public void deleteNote(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "delete from t_notes where note_id = ?";
        jt.delete(sql,map.get("note_id"));
    }

    @Override
    public void editNote(HashMap map) {
        jt = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
        String sql = "update t_notes set note_content = ? ,tip_time = ? where note_id = ?";
        jt.update(sql,map.get("noteContent"),map.get("tipTime"),map.get("noteId"));
    }
}
