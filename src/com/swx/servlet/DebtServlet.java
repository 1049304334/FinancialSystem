package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.service.DebtService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;

/**
 * Created by Administrator on 2018/4/3.
 */
public class DebtServlet extends HttpServlet{

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

    /**
     * 获取债务信息
     * @param req
     * @param resp
     */
    public void getDebts(HttpServletRequest req, HttpServletResponse resp){
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        String familyId = (String) familyMap.get("family_id");
        JSONObject debtList = debtService.getDebts(familyId);
    }

    /**
     * 获取债务信息
     * @param req
     * @param resp
     */
    public void getCreditors(HttpServletRequest req, HttpServletResponse resp){
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        String familyId = (String) familyMap.get("family_id");
        JSONObject credList = debtService.getCreditors(familyId);
    }
}
