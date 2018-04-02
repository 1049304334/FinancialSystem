package com.swx.service;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;

/**
 * Created by Administrator on 2018/3/30.
 */
public interface NoteService {
    void saveNote(HashMap map);
    JSONObject getAllNotes(HashMap map);
    JSONObject getNoteTips(HashMap map);
    void deleteNote(HashMap map);
    void editNote(HashMap map);
}
