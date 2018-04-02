package com.swx.dao;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/29.
 */
public interface HomeManageDao {
    void saveNewMember(HashMap map);
    List getAllMembers(String familyId);
    void editMember(HashMap map);
}
