package zcweb.servlet;

import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import zcweb.dao.CategoryDAO;
import zcweb.dao.OrderDAO;
import zcweb.dao.OrderItemDAO;
import zcweb.dao.ProductDAO;
import zcweb.dao.ProductImageDAO;
import zcweb.dao.PropertyDAO;
import zcweb.dao.PropertyValueDAO;
import zcweb.dao.ReviewDAO;
import zcweb.dao.UserDAO;
import zcweb.util.Page;

public class BaseForeServlet extends HttpServlet{

	protected CategoryDAO categoryDAO = new CategoryDAO();
	protected OrderDAO orderDAO = new OrderDAO();
	protected OrderItemDAO orderItemDAO = new OrderItemDAO();
	protected ProductDAO productDAO = new ProductDAO();
	protected ProductImageDAO productImageDAO = new ProductImageDAO();
	protected PropertyDAO propertyDAO = new PropertyDAO();
	protected PropertyValueDAO propertyValueDAO = new PropertyValueDAO();
	protected ReviewDAO reviewDAO = new ReviewDAO();
	protected UserDAO userDAO = new UserDAO();
	
	public void service(HttpServletRequest request, HttpServletResponse response) {
		try {
			
			int start= 0;
			int count = 10;
			try {
				start = Integer.parseInt(request.getParameter("page.start"));
			} catch (Exception e) {
				
			}
			
			try {
				count = Integer.parseInt(request.getParameter("page.count"));
			} catch (Exception e) {
			}
			
			Page page = new Page(start,count);
			
			String method = (String) request.getAttribute("method");

			Method m = this.getClass().getMethod(method, javax.servlet.http.HttpServletRequest.class,
					javax.servlet.http.HttpServletResponse.class,Page.class);
			
			String redirect = m.invoke(this,request, response,page).toString();
			
			
			/**
			 *  判断根据 home 的返回值 "home.jsp"，即没有 "%" 开头，也没有 "@", 
			 *  那么就调用 request.getRequestDispatcher(redirect).forward(request, response); 
			 *  进行服务端跳转到 "home.jsp" 页面
			 */
			if(redirect.startsWith("@"))
				
				/**
				 * return "@forealipay?oid="+order.getId() +"&total="+total;
				 * 客户端跳转（重定向（sendRedirect）客户发送一个请求到服务器，服务器匹配 servlet
				 * 客户端发送一个请求给服务器端资源 servlet，当这个 servlet 处理完之后，当看到看到 resp.senRedirect() 方法时，
这个时候服务器资源会先给客户端一个响应，客户端再根据这个响应当中所包含的地址（"getInfo.jsp"），
再次向服务器端发送一个请求，也就是说客户端跳转是两次请求，两次响应。这里两个请求互不干扰，相互独立。
客户端跳转后的地址栏是会改变的。但是现在只能接受 session 域属性的内容，而 request 域属性的内容无法接收到
				 */
				response.sendRedirect(redirect.substring(1));
			
			
			else if(redirect.startsWith("%"))
				response.getWriter().print(redirect.substring(1));
			else
				/**
				 * 服务端跳转
				 */
				request.getRequestDispatcher(redirect).forward(request, response);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	
	public InputStream parseUpload(HttpServletRequest request, Map<String, String> params) {
		InputStream is =null;
		try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            // 设置上传文件的大小限制为10M
            factory.setSizeThreshold(1024 * 10240);
             
            List items = upload.parseRequest(request);
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (!item.isFormField()) {
                    // item.getInputStream() 获取上传文件的输入流
                    is = item.getInputStream();
                } else {
                	String paramName = item.getFieldName();
                	String paramValue = item.getString();
                	paramValue = new String(paramValue.getBytes("ISO-8859-1"), "UTF-8");
                	params.put(paramName, paramValue);
                }
            }
             

             
        } catch (Exception e) {
            e.printStackTrace();
        }
		return is;
	}
}
