package com.swx.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.swx.dao.NoteDao;
import com.swx.factory.ObjectFactory;
import com.swx.service.NoteService;
import com.swx.util.PrimaryKeyUtil;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/30.
 */
public class NoteServiceImpl implements NoteService{

    NoteDao noteDao = (NoteDao) ObjectFactory.getObject("noteDao");
    PrimaryKeyUtil keyUtil = PrimaryKeyUtil.getKeyUtil();

    @Override
    public void saveNote(HashMap map) {
        map.put("noteId",keyUtil.getKey());
        noteDao.saveNote(map);
    }

    @Override
    public JSONObject getAllNotes(HashMap map) {
        List<HashMap> noteList = noteDao.getAllNotes(map);
        JSONObject json = new JSONObject();
        json.put("code","0");
        json.put("msg","");
        json.put("count",noteList.size());
        json.put("data",noteList);
        return json;
    }

    @Override
    public JSONObject getNoteTips(HashMap map) {
        JSONObject json = new JSONObject();
        List<HashMap> noteList = noteDao.getNoteTips(map);
        json.put("notes",noteList);
        return json;
    }

    @Override
    public void deleteNote(HashMap map) {
        noteDao.deleteNote(map);
    }

    @Override
    public void editNote(HashMap map) {
        noteDao.editNote(map);
    }
}
