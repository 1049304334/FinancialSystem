package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.po.Family;
import com.swx.po.User;
import com.swx.service.LoginService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;


@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet{

	private static final long serialVersionUID = -4655965510508181084L;
	private LoginService loginService = (LoginService)ObjectFactory.getObject("loginService");
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
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
	
	public void loginCheck(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		HashMap<String,Object> userMap = loginService.loginCheck(userName,password);
		JSONObject jsonObject = new JSONObject();
		if(userMap==null){
			jsonObject.put("res","fail");
		}else{
			jsonObject.put("res","success");
			HashMap<String,Object> familyMap = loginService.getFamilyInfo(userMap.get("family_id").toString());
			HttpSession session = req.getSession();
			session.setAttribute("userMap",userMap);
			session.setAttribute("familyMap",familyMap);
		}
		resp.getWriter().write(jsonObject.toString());
	}
	
	public void regedit(HttpServletRequest req,HttpServletResponse resp){
		String familyName = req.getParameter("familyName");
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String realName = req.getParameter("realName");
		User user  = new User("",realName,"",userName,password);
		Family family = new Family("",familyName,"");
		loginService.regedit(user,family);
	}
		
	public void regeditCheck(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		String userName = req.getParameter("userName");
		JSONObject jsonObject = new JSONObject();
		if(loginService.regeditCheck(userName)){
			jsonObject.put("status","0");
		}else{
			jsonObject.put("status","1");
		}
		resp.getWriter().write(jsonObject.toString());
	}

	public void index(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		resp.sendRedirect(req.getContextPath()+"/index.jsp");
	}
}
