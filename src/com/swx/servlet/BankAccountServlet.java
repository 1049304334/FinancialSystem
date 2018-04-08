package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.service.BankAccountService;
import com.swx.util.ReqParamToMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;

/**
 * Created by Administrator on 2018/4/2.
 */
@WebServlet("/bankAccountServlet")
public class BankAccountServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String methodName = req.getParameter("method");
        try {
            Method method = getClass().getDeclaredMethod(methodName,
                    HttpServletRequest.class, HttpServletResponse.class);
            method.setAccessible(true);
            method.invoke(this, req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void getBankAccount(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        String userId = (String) userMap.get("id");
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(bankAccountService.getBankAccount(userId).toString());
    }

    public void saveBankAccount(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap accountMap = ReqParamToMap.param2Map(req);
        JSONObject json = new JSONObject();
        if(bankAccountService.checkAccountNo(accountMap)){
            accountMap.put("userId",userMap.get("id"));
            accountMap.put("familyId",userMap.get("family_id"));
            bankAccountService.saveBankAccount(accountMap);
            json.put("res","0");
        }else{
            json.put("res","1");
        }
        resp.getWriter().write(json.toString());
    }

    public void deleteAccount(HttpServletRequest req, HttpServletResponse resp){
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        bankAccountService.deleteAccount(req.getParameter("accountNo"));
    }

    /**
     * 获取所有存款记录
     * @param req
     * @param resp
     */
    public void getDepositRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        resp.setCharacterEncoding("utf-8");
        HttpSession  session = req.getSession();
        HashMap userMap = (HashMap) session.getAttribute("userMap");
        String userId = (String) userMap.get("id");
        JSONObject json = bankAccountService.getDepositRecords(userId);
        resp.getWriter().write(json.toString());
    }

    public void getWithdrawRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        resp.setCharacterEncoding("utf-8");
        HttpSession  session = req.getSession();
        HashMap userMap = (HashMap) session.getAttribute("userMap");
        String userId = (String) userMap.get("id");
        JSONObject json = bankAccountService.getWithdrawRecords(userId);
        resp.getWriter().write(json.toString());
    }

    /**
     * 保存存取款记录,需要在页面设置是存款操作还是取款操作
     * @param req
     * @param resp
     */
    public void saveOperationRecord(HttpServletRequest req, HttpServletResponse resp){
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap operationRecordMap = ReqParamToMap.param2Map(req);
        operationRecordMap.put("userId",userMap.get("id"));
        operationRecordMap.put("familyId",userMap.get("family_id"));
        bankAccountService.saveOperationRecords(operationRecordMap);
    }

    public void getStatisticData(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BankAccountService bankAccountService = (BankAccountService) ObjectFactory.getObject("bankAccountService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap operationRecordMap = ReqParamToMap.param2Map(req);
        operationRecordMap.put("familyId",userMap.get("family_id"));
        resp.getWriter().write( bankAccountService.getSavingStatistics(operationRecordMap).toString());
    }
}
