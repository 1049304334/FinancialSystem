package com.swx.service;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/29.
 */
public interface HomeManageService {

    void createNewMember(HashMap map);
    JSONObject getAllMembers(String familyId);
    void editMember(HashMap map);
}
