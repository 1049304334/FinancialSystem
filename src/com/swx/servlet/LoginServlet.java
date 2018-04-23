package com.swx.servlet;

import com.alibaba.fastjson.JSONObject;
import com.swx.factory.ObjectFactory;
import com.swx.po.Family;
import com.swx.po.User;
import com.swx.service.LoginService;
import com.swx.util.VerificationCodeImgUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
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
		JSONObject jsonObject = new JSONObject();
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String veriCode = req.getParameter("veriCode");
		String code = (String) req.getSession().getAttribute("code");
		if(!code.equals(veriCode)){
			jsonObject.put("res","1");
			resp.getWriter().write(jsonObject.toString());
			return;
		}
		HashMap<String,Object> userMap = loginService.loginCheck(userName,password);
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
	
	public void regedit(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		String familyName = req.getParameter("familyName");
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String realName = req.getParameter("realName");
		User user  = new User("",realName,"",userName,password);
		Family family = new Family("",familyName,"");
		System.out.println(user+"\n"+family);
		loginService.regedit(user,family);
		HashMap userMap = loginService.loginCheck(user.getUserName(),user.getPassword());
		HashMap familyMap = loginService.getFamilyInfo(userMap.get("family_id").toString());
		req.getSession().setAttribute("userMap",userMap);
		req.getSession().setAttribute("familyMap",familyMap);
		JSONObject json = new JSONObject();
		json.put("res","0");
		resp.getWriter().write(json.toString());
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

	public void getHomePageInfo(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		HashMap map = (HashMap) req.getSession().getAttribute("userMap");
		HashMap paramMap = new HashMap();
		paramMap.put("familyId",map.get("family_id"));
		LoginService loginService = (LoginService) ObjectFactory.getObject("loginService");
		resp.getWriter().write(loginService.getHomePageInfo(paramMap).toString());
	}
	
	public void exitLogin(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		req.getSession().invalidate();
		resp.sendRedirect(req.getContextPath()+"/login.jsp");
	}

	public void getUserInfo(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		HashMap map = (HashMap) req.getSession().getAttribute("userMap");
		LoginService loginService = (LoginService) ObjectFactory.getObject("loginService");
		JSONObject json = loginService.getUserInfo((String) map.get("id"));
		resp.setCharacterEncoding("utf-8");
		resp.getWriter().write(json.toString());
	}

	/**
	 * 生成图片验证码，并将验证码内容放入session,将图片显示到页面
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	public void generateVerificationCode(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		OutputStream outputStream = resp.getOutputStream();
		String code = VerificationCodeImgUtil.create(120,48,"jpeg",outputStream);
		System.out.println(code);
		session.setAttribute("code",code);
	}

}
