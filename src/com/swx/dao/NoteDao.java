package com.swx.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/30.
 */
public interface NoteDao {
    void saveNote(HashMap map);
    List getAllNotes(HashMap map);
    List getNoteTips(HashMap map);
    void deleteNote(HashMap map);
    void editNote(HashMap map);
}
