package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.service.DebtService;
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
 * Created by Administrator on 2018/4/3.
 */
@WebServlet("/debtServlet")
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
    public void getDebts(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        String familyId = (String) familyMap.get("family_id");
        JSONObject debtList = debtService.getDebts(familyId);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(debtList.toString());
    }

    /**
     * 获取债务信息
     * @param req
     * @param resp
     */
    public void getCreditors(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        String familyId = (String) familyMap.get("family_id");
        JSONObject credList = debtService.getCreditors(familyId);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(credList.toString());
    }

    public void saveCredit(HttpServletRequest req, HttpServletResponse resp){
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap credMap = ReqParamToMap.param2Map(req);
        credMap.put("userId",userMap.get("id"));
        credMap.put("familyId",userMap.get("family_id"));
        debtService.saveCredit(credMap);
    }

    public void editCredit(HttpServletRequest req, HttpServletResponse resp){

        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap credMap = ReqParamToMap.param2Map(req);
        debtService.editCredit(credMap);
    }

    public void saveDebt(HttpServletRequest req, HttpServletResponse resp){
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap debtMap = ReqParamToMap.param2Map(req);
        debtMap.put("userId",userMap.get("id"));
        debtMap.put("familyId",userMap.get("family_id"));
        debtService.saveDebt(debtMap);
    }

    public void editDebt(HttpServletRequest req, HttpServletResponse resp){

        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap debtMap = ReqParamToMap.param2Map(req);
        debtService.editDebt(debtMap);
    }

    public void deleteCredit(HttpServletRequest req, HttpServletResponse resp){
        String lendId = req.getParameter("lendId");
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        debtService.deleteCredit(lendId);
    }

    public void deleteDebt(HttpServletRequest req, HttpServletResponse resp){
        String borrowId = req.getParameter("borrowId");
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        debtService.deleteDebt(borrowId);
    }

    public void getStatisticData(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        DebtService debtService = (DebtService) ObjectFactory.getObject("debtService");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap map = ReqParamToMap.param2Map(req);
        map.put("familyId",userMap.get("family_id"));
        JSONObject json = debtService.getStatisticsData(map);
        resp.getWriter().write(json.toString());
    }
}
