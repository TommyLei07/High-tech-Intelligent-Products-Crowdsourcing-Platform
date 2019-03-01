package zcweb.servlet;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import zcweb.bean.Product;

import zcweb.dao.ProductDAO;
import zcweb.util.Page;

public class ProjectServlet extends BaseBackServlet{

	public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
		return null;
	}

	
	public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
		return null;
	}
	public String check(HttpServletRequest request, HttpServletResponse response, Page page) {
		int id = Integer.parseInt(request.getParameter("id"));
		Product p=productDAO.get(id);
		p.setCheckDate(new Date());
		p.setStatus(ProductDAO.Checked);
		productDAO.update(p);
		return "@admin_project_list";
	}
	public String alter(HttpServletRequest request, HttpServletResponse response, Page page) {
		int id = Integer.parseInt(request.getParameter("id"));
		Product p=productDAO.get(id);
		/*p.setCheckDate(new Date());*/
		p.setStatus(ProductDAO.waitAlter);
		productDAO.update(p);
		return "@admin_project_list";
	}
	
	public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
		return null;	
	}

	
	public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
		return null;
	}

	
	public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
		List<Product> ps = productDAO.list(page.getStart(), page.getCount());
		
		int total = productDAO.getTotal();
		page.setTotal(total);
		
		request.setAttribute("ps", ps);
		request.setAttribute("page", page);
		
		return "admin/checkProject.jsp";
	}
}
