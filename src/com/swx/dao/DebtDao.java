package com.swx.dao;

import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public interface DebtDao {
    List getDebts(String familyId);
    List getCreditors(String familyId);
}
