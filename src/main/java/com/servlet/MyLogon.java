package com.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.toolsBean.Change;
import com.valueBean.UserSingle;

@SuppressWarnings("serial")
public class MyLogon extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    System.out.println("进入doPost方法，开始处理登录请求");
	    
	    String message="";	
	    HttpSession session=request.getSession();		
		UserSingle logoner=(UserSingle)session.getAttribute("logoner");	
	    request.setCharacterEncoding("utf-8");	
	    
	    System.out.println("正在获取请求参数...");
	    String name = request.getParameter("userName");
	    String pswd = request.getParameter("userPswd");
	    UserDao userDao = new UserDao();
	    
	    System.out.println("获取到的用户名: " + name);
	    System.out.println("获取到的密码: " + pswd);
	    
	    System.out.println("开始验证用户名和密码...");
	    try {
			logoner = userDao.getLogoner(new Object[] { name, pswd });
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (logoner == null) { 
			// 账户或密码登录不正确
			message="{'state':'session miss','result':'1'}"; 
			
			
		} else { 
			
			// 登录成功
			session.setAttribute("logoner", logoner);
			
			int masterId=Change.strToInt(request.getParameter("master"));
			if(masterId==(-1)){
				masterId=0;
			}
			
			String userFlag="0";
			if(masterId==logoner.getId()){
				userFlag="1";
			}
			
			message="{'state': '成功', 'result': '0'," +
					"'userId':'"+logoner.getId()+"'," +
					"'userBlogName':'"+logoner.getUserBlogName()+"'," +
					"'userFlag':'"+userFlag+"'," +
					"'userHitNum':'"+logoner.getUserHitNum()+"' }"; 
		}
	    
	    System.out.println("设置响应内容类型为: text/html;charset=utf-8");
	    response.setContentType("text/html;charset=utf-8");
	    
	    System.out.println("准备返回消息: " + message);
	    response.getWriter().write(message);
	    System.out.println("doPost方法处理完毕");
	}
	
}