package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.service.HomeManageService;
import com.swx.service.IncomeService;
import com.swx.service.LoginService;
import com.swx.util.ReqParamToMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;

@WebServlet("/homeManageServlet")
public class HomeManageServlet extends HttpServlet{

    private IncomeService incomeService = (IncomeService) ObjectFactory.getObject("incomeService");
    private HomeManageService homeManageService = (HomeManageService) ObjectFactory.getObject("homeManageService");
    private LoginService loginService = (LoginService) ObjectFactory.getObject("loginService");

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

    public void saveNewType(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        HashMap<String,String> typeMap = new HashMap<String,String>();
        HashMap<String,String> familyMap = (HashMap<String, String>) req.getSession().getAttribute("familyMap");
        typeMap.put("typeName",req.getParameter("typeName"));
        typeMap.put("typeDirection",req.getParameter("typeDirection"));
        typeMap.put("familyId",familyMap.get("family_id"));
        incomeService.saveNewType(typeMap);
        resp.getWriter().write("1");
    }

    public void deleteType(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        String typeId = req.getParameter("typeId");
        incomeService.deleteType(typeId);
        resp.getWriter().write("1");
    }

    public void getAllMembers(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding("utf-8");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        String familyId = (String) familyMap.get("family_id");
        JSONObject json = homeManageService.getAllMembers(familyId);
        resp.getWriter().write(json.toString());
    }

    public void createNewMember(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        JSONObject json = new JSONObject();
        HashMap famliyMap = (HashMap) req.getSession().getAttribute("familyMap");
        HashMap map = ReqParamToMap.param2Map(req);
        map.put("familyId",famliyMap.get("family_id"));
        boolean flag = loginService.regeditCheck((String) map.get("userName"));
        if(!flag){
            json.put("res","0");
        }else{
            homeManageService.createNewMember(map);
            json.put("res","1");
        }
        resp.getWriter().write(json.toString());
    }

    public void editMember(HttpServletRequest req,HttpServletResponse resp){
        HashMap memberMap = ReqParamToMap.param2Map(req);
        homeManageService.editMember(memberMap);
    }
}
