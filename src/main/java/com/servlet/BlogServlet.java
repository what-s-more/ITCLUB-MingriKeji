package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.ArticleDao;
import com.dao.UserDao;
import com.toolsBean.Change;
import com.valueBean.UserSingle;

@SuppressWarnings("serial")
public class BlogServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		doPost(request,response);
	}

	@SuppressWarnings("unchecked")
	// 接收前台通过 POST 方式传递过来的数据
	protected void doPost(HttpServletRequest request,
	                      HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("mainPage",getInitParameter("defaultPage"));
		String forward = ""; 
	    // 创建字符串 forward
	    HttpSession session = request.getSession(); 
	    // 设置 session
	    int userid = Change.strToInt(request.getParameter("master")); 
	    // 获取 master 的值
	    UserSingle logoner=(UserSingle)session.getAttribute("logoner");	
		if(null!=logoner){
			session.setAttribute("logoner",logoner);
			if(userid==logoner.getId()){
				request.setAttribute("isSelf","1");
			}else{
				request.setAttribute("isSelf","0");
			}
		}
	    try {
	        UserDao userDao = new UserDao(); 
	        // 创建 UserDao 实例
	        userDao.setHitNum(userid);		
	        UserSingle master = userDao.getMasterSingle(userid); 
	        // 获取用户信息
	        if (master != null) { 
	            // 如果用户信息不为空
	            session.setAttribute("callBlogMaster", master); 
	            // 将 master 赋值到 session 中
	            
	            List articlelist=new ArrayList();
				ArticleDao articleDao=new ArticleDao();
				String showPage=request.getParameter("showPage");
				articlelist=articleDao.getListArticle(userid,showPage,"goBlogIndex?master="+userid);
				request.setAttribute("articlelist",articlelist);
				request.setAttribute("createPage",articleDao.getPage());
				/* 获取显示在个人主页中侧栏位置上的点击率排行前20名的博客 */				
				List toplist=userDao.getTopList();
				request.setAttribute("toplist",toplist);		
				/* 获取该博客文章总数 */
				int countActicle=articleDao.getActicleCount(userid);
				session.setAttribute("countActicle",countActicle);
				/* 获取该博客评论总数 */
				int countRev=articleDao.getRevCount(userid);
				session.setAttribute("countRev",countRev);
	            
	            forward = getInitParameter("indexUser"); 
	            // 将 forward 赋值 indexUser
	            System.out.println("第一次检测转发路径: " + forward);
	        }else{							//如果访问的用户不存在		
				forward=this.getServletContext().getInitParameter("messagePage");
				String message="<li>对不起，访问的用户不存在！</li>";
				request.setAttribute("message",message);
			}
	    } catch (Exception e) {
	    	forward=this.getServletContext().getInitParameter("messagePage");
			System.out.println("'获取博文信息错误！");
			e.printStackTrace();
	        // 提示错误信息
	    }
	    System.out.println("第二次检测转发路径: " + forward);
	    RequestDispatcher rd = request.getRequestDispatcher(forward); 
	    // 创建请求对象实例 rd
	    System.out.println("RequestDispatcher 是否为空: " + (rd == null));
	    rd.forward(request, response); 
	    // 将响应信息返回给页面使用
	}
}