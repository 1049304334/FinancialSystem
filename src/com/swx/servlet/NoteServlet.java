package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.service.NoteService;
import com.swx.util.ReqParamToMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;

/**
 * Created by Administrator on 2018/3/30.
 */
@WebServlet("/noteServlet")
public class NoteServlet extends HttpServlet{

    NoteService noteService = (NoteService) ObjectFactory.getObject("noteService");

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

    public void saveNote(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HashMap userMap = (HashMap) req.getSession().getAttribute("userMap");
        HashMap familyMap = (HashMap) req.getSession().getAttribute("familyMap");
        HashMap noteMap = ReqParamToMap.param2Map(req);
        noteMap.put("userId",userMap.get("id"));
        noteMap.put("familyId",userMap.get("family_id"));
        noteService.saveNote(noteMap);
        resp.getWriter().write("1");
    }

    public void getAllNote(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding("utf-8");
        HashMap noteMap = ReqParamToMap.param2Map(req);
        JSONObject json = noteService.getAllNotes(noteMap);
        resp.getWriter().write(json.toString());
    }

    public void getNoteTip(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding("utf-8");
        HashMap noteMap = ReqParamToMap.param2Map(req);
        JSONObject json = noteService.getNoteTips(noteMap);
        resp.getWriter().write(json.toString());
    }

    public void deleteNote(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HashMap map = ReqParamToMap.param2Map(req);
        noteService.deleteNote(map);
        resp.getWriter().write("1");
    }

    public void editNote(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HashMap noteMap = ReqParamToMap.param2Map(req);
        noteService.editNote(noteMap);
        resp.getWriter().write("1");
    }
}
