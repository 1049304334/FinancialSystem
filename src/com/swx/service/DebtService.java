package com.swx.service;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public interface DebtService {
    JSONObject getDebts(String familyId);
    JSONObject getCreditors(String familyId);
}
