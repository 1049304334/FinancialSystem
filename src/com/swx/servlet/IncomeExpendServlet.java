package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.service.IncomeService;
import com.swx.util.ReqParamToMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2018/3/27.
 */
@WebServlet("/incomeExpendServlet")
public class IncomeExpendServlet extends HttpServlet {



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

    public void getIncomeRecord(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        String familyId = req.getParameter("familyId");
        resp.setCharacterEncoding("utf-8");
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        List<HashMap<String,Object>> recordList = incomeService.getIncomeRecord(familyId);
        JSONObject json = new JSONObject();
        json.put("code","0");
        json.put("msg","");
        json.put("count",recordList.size());
        json.put("data",recordList);
        System.out.println(json.toString());
        resp.getWriter().write(json.toString());
    }

    public void getAllIncomeOutcomeType(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding("utf-8");
        String familyId = req.getParameter("familyId");
        System.out.println(familyId);
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        List<HashMap<String,Object>> typeList = incomeService.getAllTypes(familyId);
        JSONObject json = new JSONObject();
        json.put("msg","");
        json.put("data",typeList);
        json.put("code","0");
        json.put("count",typeList.size());
        System.out.println(typeList);
        resp.getWriter().write(json.toString());
    }

    /**
     * 获得当前家庭所有收支类型
     */
    public void getTypes(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        String familyId = (String) familyMap.get("family_id");
        JSONObject json = incomeService.getTypes(familyId);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(json.toString());
    }

    public void saveIncomeRecord(HttpServletRequest req,HttpServletResponse resp){
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap map = ReqParamToMap.param2Map(req);
        map.put("familyId",familyMap.get("family_id"));
        map.put("userId",userMap.get("id"));
        incomeService.saveIncomeRecord(map);
    }

    public void getExpandRecord(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        HashMap map = ReqParamToMap.param2Map(req);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(incomeService.getExpandRecord(map).toString());
    }

    public void saveExpandRecord(HttpServletRequest req,HttpServletResponse resp){
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap map = ReqParamToMap.param2Map(req);
        map.put("familyId",familyMap.get("family_id"));
        map.put("userId",userMap.get("id"));
        incomeService.saveExpandRecord(map);
    }

    public void getStatisticData(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
        HashMap cycle = ReqParamToMap.param2Map(req);
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        cycle.put("familyId",userMap.get("family_id"));
        JSONObject json = incomeService.getStatisticData(cycle);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().write(json.toString());

    }
}
