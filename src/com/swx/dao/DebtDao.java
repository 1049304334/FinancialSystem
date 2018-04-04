package com.swx.dao;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/4/3.
 */
public interface DebtDao {
    List getDebts(String familyId);
    List getCreditors(String familyId);
    void saveCredit(HashMap map);
    void saveDebt(HashMap map);
    void editCredit(HashMap map);
    void editDebt(HashMap map);
    void deleteCredit(String lendId);
    void deleteDebt(String debtId);
}
