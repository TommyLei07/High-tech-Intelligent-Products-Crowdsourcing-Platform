package zcweb.servlet;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import zcweb.bean.Order;
import zcweb.bean.Review;
import zcweb.util.Page;

public class ReviewServlet extends BaseBackServlet {

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
		List<Review> rs = reviewDAO.webreviewlist(page.getStart(), page.getCount());
	/*	orderItemDAO.fill(os);*/
		int total = reviewDAO.getWebTotal();
		page.setTotal(total);
		
		request.setAttribute("rs", rs);
		request.setAttribute("page", page);
		
		return "admin/listReview.jsp";
		
	}

}
