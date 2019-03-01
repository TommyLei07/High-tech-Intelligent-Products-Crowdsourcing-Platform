package zcweb.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.util.HtmlUtils;

import zcweb.bean.AdminUser;

import zcweb.util.Page;

public class LoginServlet extends BaseBackServlet {

	@Override
	public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
		// TODO Auto-generated method stub
		return null;
	}
	public String showlogin(HttpServletRequest request, HttpServletResponse response, Page page) {
		
		
		return "admin/adminLogin.jsp";
	}
	public String login(HttpServletRequest request, HttpServletResponse response, Page page) {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		name = HtmlUtils.htmlEscape(name);
		String password = request.getParameter("password");		
		
		AdminUser auser = adminuserDAO.get(name,password);
		 
		if(null==auser){
			request.setAttribute("msg", "账号密码错误");
		
			return "admin/adminLogin.jsp";	
		}
		request.getSession().setAttribute("auser", auser);
		return "@admin_category_list";	
	}

}
