package zcweb.servlet;

import java.awt.image.BufferedImage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.web.util.HtmlUtils;

import zcweb.bean.Category;
import zcweb.bean.Order;
import zcweb.bean.OrderItem;
import zcweb.bean.Product;
import zcweb.bean.ProductImage;
import zcweb.bean.PropertyValue;
import zcweb.bean.Review;
import zcweb.bean.User;
import zcweb.comparator.ProductAllComparator;
import zcweb.comparator.ProductDateComparator;
import zcweb.comparator.ProductPriceComparator;
import zcweb.comparator.ProductReviewComparator;
import zcweb.comparator.ProductSaleCountComparator;
import zcweb.dao.CategoryDAO;
import zcweb.dao.OrderDAO;
import zcweb.dao.ProductDAO;
import zcweb.dao.ProductImageDAO;
import zcweb.util.ImageUtil;
import zcweb.util.Page;

public class ForeServlet extends BaseForeServlet {
	public String home(HttpServletRequest request, HttpServletResponse response, Page page) {
		List<Category> cs= new CategoryDAO().list();
		new ProductDAO().fill(cs);
		request.setAttribute("cs", cs);
		return "home.jsp";
	}

	public String register(HttpServletRequest request, HttpServletResponse response, Page page) {
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		name = HtmlUtils.htmlEscape(name);
		System.out.println(name);
		boolean exist = userDAO.isExist(name);
		
		if(exist){
			request.setAttribute("msg", "用户名已经被使用,不能使用");
			return "register.jsp";	
		}
		
		User user = new User();
		user.setName(name);
		user.setPassword(password);
		System.out.println(user.getName());
		System.out.println(user.getPassword());
		userDAO.add(user);
		
		return "@registerSuccess.jsp";	
	}	
	public String login(HttpServletRequest request, HttpServletResponse response, Page page) {
		String name = request.getParameter("name");
		name = HtmlUtils.htmlEscape(name);
		String password = request.getParameter("password");		
		
		User user = userDAO.get(name,password);
		 
		if(null==user){
			request.setAttribute("msg", "账号密码错误");
			return "register.jsp";	
		}
		request.getSession().setAttribute("user", user);
		return "@forehome";	
	}	
	
	public String product(HttpServletRequest request, HttpServletResponse response, Page page) {
		int pid = Integer.parseInt(request.getParameter("pid"));
		Product p = productDAO.get(pid);
		
		List<ProductImage> productSingleImages = productImageDAO.list(p, ProductImageDAO.type_single);
		List<ProductImage> productDetailImages = productImageDAO.list(p, ProductImageDAO.type_detail);
		p.setProductSingleImages(productSingleImages);
		p.setProductDetailImages(productDetailImages);
		List<Review> reviews = reviewDAO.list(p.getId());
		productDAO.setSaleAndReviewNumber(p);
		request.setAttribute("reviews", reviews);
		request.setAttribute("p", p);
		return "product.jsp";		
	}
	public String logout(HttpServletRequest request, HttpServletResponse response, Page page) {
		request.getSession().removeAttribute("user");
		return "@forehome";	
	}

	public String checkLogin(HttpServletRequest request, HttpServletResponse response, Page page) {
		User user =(User) request.getSession().getAttribute("user");
		if(null!=user)
			return "%success";
		return "%fail";
	}
	public String loginAjax(HttpServletRequest request, HttpServletResponse response, Page page) {
		String name = request.getParameter("name");
		String password = request.getParameter("password");		
		User user = userDAO.get(name,password);
		
		if(null==user){
			return "%fail";	
		}
		request.getSession().setAttribute("user", user);
		return "%success";	
	}
	public String category(HttpServletRequest request, HttpServletResponse response, Page page) {
		int cid = Integer.parseInt(request.getParameter("cid"));
		
		Category c = new CategoryDAO().get(cid);
		new ProductDAO().fill(c);
		new ProductDAO().setSaleAndReviewNumber(c.getProducts());		
		
		String sort = request.getParameter("sort");
		if(null!=sort){
		switch(sort){
			case "review":
				Collections.sort(c.getProducts(),new ProductReviewComparator());
				break;
			case "date" :
				Collections.sort(c.getProducts(),new ProductDateComparator());
				break;
				
			case "saleCount" :
				Collections.sort(c.getProducts(),new ProductSaleCountComparator());
				break;
				
			case "price":
				Collections.sort(c.getProducts(),new ProductPriceComparator());
				break;
				
			case "all":
				Collections.sort(c.getProducts(),new ProductAllComparator());
				break;
			}
		}
		
		request.setAttribute("c", c);
		return "category.jsp";		
	}
	
	public String search(HttpServletRequest request, HttpServletResponse response, Page page){
		String keyword = request.getParameter("keyword");
		List<Product> ps= new ProductDAO().search(keyword,0,20);
		productDAO.setSaleAndReviewNumber(ps);
		request.setAttribute("ps",ps);
		return "searchResult.jsp";
	}

	public String buyone(HttpServletRequest request, HttpServletResponse response, Page page) {
		int pid = Integer.parseInt(request.getParameter("pid"));
		int num = Integer.parseInt(request.getParameter("num"));
		Product p = productDAO.get(pid);
		int oiid = 0;
		
		User user =(User) request.getSession().getAttribute("user");
		boolean found = false;
		List<OrderItem> ois = orderItemDAO.listByUser(user.getId());
		for (OrderItem oi : ois) {
			if(oi.getProduct().getId()==p.getId()){
				oi.setNumber(oi.getNumber()+num);
				orderItemDAO.update(oi);
				found = true;
				oiid = oi.getId();
				break;
			}
		}		

		if(!found){
			OrderItem oi = new OrderItem();
			oi.setUser(user);
			oi.setNumber(num);
			oi.setProduct(p);
			orderItemDAO.add(oi);
			oiid = oi.getId();
		}
		return "@forebuy?oiid="+oiid;
	}

	
	public String buy(HttpServletRequest request, HttpServletResponse response, Page page){
		
		/*
		 * 到底要取哪一个？所以在这个时候，不能用 getParameter 来取，
		 * 而应该用 getParameterValues 来取，用这个方法，会将前端同名 input type 以阵列的方式取回
		 */
		String[] oiids=request.getParameterValues("oiid");
		List<OrderItem> ois = new ArrayList<>();
		float total = 0;

		for (String strid : oiids) {
			int oiid = Integer.parseInt(strid);
			OrderItem oi= orderItemDAO.get(oiid);
			total +=oi.getProduct().getPrice()*oi.getNumber();
			ois.add(oi);
		}
		
		request.getSession().setAttribute("ois", ois);
		request.setAttribute("total", total);
		return "buy.jsp";
	}	
	public String addCart(HttpServletRequest request, HttpServletResponse response, Page page) {
		int pid = Integer.parseInt(request.getParameter("pid"));
		Product p = productDAO.get(pid);
		
		System.out.println("加入购物车，商品ID"+p.getId());
		int num = Integer.parseInt(request.getParameter("num"));
		
		User user =(User) request.getSession().getAttribute("user");
		boolean found = false;

		List<OrderItem> ois = orderItemDAO.listByUser(user.getId());
		for (OrderItem oi : ois) {
			if(oi.getProduct().getId()==p.getId()){
				oi.setNumber(oi.getNumber()+num);
				orderItemDAO.update(oi);
				System.out.println("加入购物车："+p.getSaleCount());
				found = true;
				break;
			}
		}		
		

		if(!found){
			OrderItem oi = new OrderItem();
			oi.setUser(user);
			oi.setNumber(num);
			oi.setProduct(p);
			orderItemDAO.add(oi);
		}
		System.out.println("加入购物车："+p.getSaleCount());
		return "%success";
	}
	public String cart(HttpServletRequest request, HttpServletResponse response, Page page) {
		User user =(User) request.getSession().getAttribute("user");
		List<OrderItem> ois = orderItemDAO.listByUser(user.getId());
		request.setAttribute("ois", ois);
		return "cart.jsp";
	}

	public String changeOrderItem(HttpServletRequest request, HttpServletResponse response, Page page) {
		User user =(User) request.getSession().getAttribute("user");
		if(null==user)
			return "%fail";

		int pid = Integer.parseInt(request.getParameter("pid"));
		int number = Integer.parseInt(request.getParameter("number"));
		List<OrderItem> ois = orderItemDAO.listByUser(user.getId());
		for (OrderItem oi : ois) {
			if(oi.getProduct().getId()==pid){
				oi.setNumber(number);
				orderItemDAO.update(oi);
				break;
			}
			
		}		
		return "%success";
	}

	public String deleteOrderItem(HttpServletRequest request, HttpServletResponse response, Page page){
		User user =(User) request.getSession().getAttribute("user");
		if(null==user)
			return "%fail";
		int oiid = Integer.parseInt(request.getParameter("oiid"));
		orderItemDAO.delete(oiid);
		return "%success";
	}
	
	
	
	
	/**
	 * 
	
	 * 提交订单访问路径 /forecreateOrder, 导致ForeServlet.createOrder 方法被调用
		 从session中获取user对象
		获取地址，邮编，收货人，用户留言等信息
		根据当前时间加上一个4位随机数生成订单号
		根据上述参数，创建订单对象
		 把订单状态设置为等待支付
		加入到数据库
		从session中获取订单项集合 ( 在结算功能的ForeServlet.buy() 13行，订单项集合被放到了session中 )
		遍历订单项集合，设置每个订单项的order，并更新到数据库
		统计本次订单的总金额
		客户端跳转到确认支付页forealipay，并带上订单id和总金额
	 */

	public String createOrder(HttpServletRequest request, HttpServletResponse response, Page page){
		User user =(User) request.getSession().getAttribute("user");

	
		String address = request.getParameter("address");
		String post = request.getParameter("post");
		String receiver = request.getParameter("receiver");
		String mobile = request.getParameter("mobile");
		String userMessage = request.getParameter("userMessage");
		
		
		String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) +RandomUtils.nextInt(10000);
		Order order = new Order();
		order.setOrderCode(orderCode);
		order.setAddress(address);
		order.setPost(post);
		order.setReceiver(receiver);
		order.setMobile(mobile);
		order.setUserMessage(userMessage);
		order.setCreateDate(new Date());
		order.setUser(user);
		order.setStatus(OrderDAO.waitPay);

		orderDAO.add(order);
		/**
		 * 这里ois是通过之前forebuy提交到session中的
		 */
		List<OrderItem> ois= (List<OrderItem>) request.getSession().getAttribute("ois");		
		float total =0;
		for (OrderItem oi: ois) {
			oi.setOrder(order);
			orderItemDAO.update(oi);
			total+=oi.getProduct().getPrice()*oi.getNumber();
		}
		
		return "@forealipay?oid="+order.getId() +"&total="+total;
	}
	
	public String alipay(HttpServletRequest request, HttpServletResponse response, Page page){
		return "alipay.jsp";
	}

	
	public String payed(HttpServletRequest request, HttpServletResponse response, Page page) {
		int oid = Integer.parseInt(request.getParameter("oid"));
		User user=(User) request.getSession().getAttribute("user");
		float total=Float.parseFloat(request.getParameter("total"));
		int uid=user.getId();
		
		Order order = orderDAO.get(oid);
		order.setStatus(OrderDAO.waitDelivery);
		order.setPayDate(new Date());
		new OrderDAO().update(order);
		
		/*
		 * 用户购买的数量和总价写入表
		 * 先从数据库读，然后累和，再写入
		 */
		User buyuser=userDAO.getNumberAndTotal(uid);
		int boughtnumber=buyuser.getUserBuyNumber();
		float boughttotal=buyuser.getUserBuyTotal();
		
		
		//获取该订单下买家的购买数量总数
		int userBuyNumber=orderItemDAO.getUserBuyNumber(uid, oid);
		userBuyNumber+=boughtnumber;
		total+=boughttotal;
		
		user.setUserBuyNumber(userBuyNumber);
		user.setUserBuyTotal(total);
		
		userDAO.setBuyNumberAndTotal(user);
		
	
		
		
		/*
		 * 循环遍历ois,
		 * 根据orderitem的pid获取project，然后根据pid获取发布者
		 */
		int publishnumber=0;
		float publishtotal=0;
		orderItemDAO.fill(order);
		List<OrderItem> ois=order.getOrderItems();
		for(OrderItem oi:ois){
			//获取该订单项中的数量，即发布人被购买的数量,总金额
			publishnumber=oi.getNumber();
			publishtotal=oi.getProduct().getPrice()*publishnumber;
			
			//获取该众筹商品的发布者
			User publishuser=oi.getProduct().getUser();
			publishuser=userDAO.getNumberAndTotal(publishuser.getId());
			//先获取该发布者已经被购买的众筹项目数量
			int publishboughtnumber=publishuser.getPublishNumber();
			float publishboughttotal=publishuser.getPublishTotal();
			System.out.println("payed-publish:"+publishboughtnumber+"--"+publishboughttotal+"--"+publishuser.getId());
			
			//然后累和
			publishboughtnumber+=publishnumber;
			publishboughttotal+=publishtotal;
			
			//对该发布者设置属性
			publishuser.setPublishNumber(publishboughtnumber);
			publishuser.setPublishTotal(publishboughttotal);
			
			
			//写入数据库
			userDAO.setPublishNumberAndTotal(publishuser);
			
			
			
			
			
		}
		
		
		
		
		
		
		
		
		
		request.setAttribute("o", order);
		return "payed.jsp";		
	}	

	public String bought(HttpServletRequest request, HttpServletResponse response, Page page) {
		User user =(User) request.getSession().getAttribute("user");
		/*userDAO.setUserBuyCount(user);*/
		List<Order> os= orderDAO.list(user.getId(),OrderDAO.delete);
		List<Product> ps = productDAO.listu(user.getId(),page.getStart(), page.getCount());
		int uid=user.getId();
		user=userDAO.getNumberAndTotal(uid);
		
		for(Product p:ps){
			productDAO.setSaleAndReviewNumber(p);
			if(p.getSaleCount()>=p.getStock()){
				p.setStatus(ProductDAO.Finished);
			}
			 
		}
		
		orderItemDAO.fill(os);
		request.getSession().setAttribute("user", user);
		request.setAttribute("os", os);
		request.setAttribute("ps", ps);
		
		return "bought.jsp";		
	}
	public String confirmPay(HttpServletRequest request, HttpServletResponse response, Page page) {
		int oid = Integer.parseInt(request.getParameter("oid"));
		
		Order o = orderDAO.get(oid);
		orderItemDAO.fill(o);
		request.setAttribute("o", o);
		return "confirmPay.jsp";		
	}
	
	public String orderConfirmed(HttpServletRequest request, HttpServletResponse response, Page page) {
		int oid = Integer.parseInt(request.getParameter("oid"));
		
		Order o = orderDAO.get(oid);
		o.setStatus(OrderDAO.waitReview);
		o.setConfirmDate(new Date());
		orderDAO.update(o);
		
		
		
		return "orderConfirmed.jsp";
	}	
	
	
	public String deleteOrder(HttpServletRequest request, HttpServletResponse response, Page page){
		int oid = Integer.parseInt(request.getParameter("oid"));
		Order o = orderDAO.get(oid);
		o.setStatus(OrderDAO.delete);
		orderDAO.update(o);
		return "%success";		
	}
	public String review(HttpServletRequest request, HttpServletResponse response, Page page) {
		int oid = Integer.parseInt(request.getParameter("oid"));
		Order o = orderDAO.get(oid);
		orderItemDAO.fill(o);
		Product p = o.getOrderItems().get(0).getProduct();
		List<Review> reviews = reviewDAO.list(p.getId());
		productDAO.setSaleAndReviewNumber(p);
		request.setAttribute("p", p);
		request.setAttribute("o", o);
		request.setAttribute("reviews", reviews);
		return "review.jsp";		
	}
	public String doreview(HttpServletRequest request, HttpServletResponse response, Page page) {
		int oid = Integer.parseInt(request.getParameter("oid"));
		Order o = orderDAO.get(oid);
		o.setStatus(OrderDAO.finish);
		orderDAO.update(o);
		int pid = Integer.parseInt(request.getParameter("pid"));
		Product p = productDAO.get(pid);
		
		String content = request.getParameter("content");
		
		content = HtmlUtils.htmlEscape(content);

		User user =(User) request.getSession().getAttribute("user");
		Review review = new Review();
		review.setContent(content);
		review.setProduct(p);
		review.setCreateDate(new Date());
		review.setUser(user);
		System.out.println("评价："+review.getId());
		reviewDAO.add(review);
		
		return "@forereview?oid="+oid+"&showonly=true";		
	}
	public String intro(HttpServletRequest request, HttpServletResponse response, Page page) {
		
		
		return "introduction.jsp";		
	}
	public String webreview(HttpServletRequest request, HttpServletResponse response, Page page) {
;
		User user =(User) request.getSession().getAttribute("user");
		String content = request.getParameter("content");
		String name=request.getParameter("name");
		String contact=request.getParameter("contact");
		content = HtmlUtils.htmlEscape(content);
		
		Review review=new Review();
		review.setUser(user);
		review.setContent(content);
		review.setContact(contact);
		review.setName(name);
		
		reviewDAO.webreview(review);
		
		
		
		
		request.setAttribute("msg", "已经收到你的留言，十分感谢");
		
		return "introduction.jsp";	
	}
	
	public String Alter(HttpServletRequest request, HttpServletResponse response, Page page) {
		int pid=Integer.parseInt(request.getParameter("pid"));
		Product p=productDAO.get(pid);
		request.setAttribute("p", p);
		return "alter.jsp";		
	}
	
	
	
	public String doAlter(HttpServletRequest request, HttpServletResponse response, Page page){

		int cid = Integer.parseInt(request.getParameter("selectcid"));
		int uid=Integer.parseInt(request.getParameter("uid"));
		int pid=Integer.parseInt(request.getParameter("pid"));
		Product p=productDAO.get(pid);
		Category c = categoryDAO.get(cid);
		User u=userDAO.get(uid);
		String name= request.getParameter("name");
		String detail= request.getParameter("detail");
		float price = Float.parseFloat(request.getParameter("price"));

		int stock = Integer.parseInt(request.getParameter("stock"));
		String reward=request.getParameter("reward");
		String mobile=request.getParameter("mobile");
	
		

		p.setUser(u);
		p.setCategory(c);
		p.setName(name);
		
		p.setStock(stock);
		p.setReward(reward);
		p.setDetail(detail);
		p.setPrice(price);
		p.setMobile(mobile);

		p.setStatus(ProductDAO.waitCheck);
	
		productDAO.update(p);
		
		
		System.out.println("cid:"+c.getId());
		System.out.println(pid);
		
	
		return "@foreprojectimglist?pid="+pid;
	}

	public String deleteProject(HttpServletRequest request, HttpServletResponse response, Page page){
		int pid = Integer.parseInt(request.getParameter("pid"));
		System.out.println("删除"+pid);
		Product p=productDAO.get(pid);
		p.setStatus(ProductDAO.deleted);
		productDAO.update(p);
		return "%success";		
	}
	
	
	
	
	public String publish(HttpServletRequest request, HttpServletResponse response, Page page) {
		
		
			int cid = Integer.parseInt(request.getParameter("selectcid"));
			int uid=Integer.parseInt(request.getParameter("uid"));
/*		int cid=92;*/
			Category c = categoryDAO.get(cid);
			User u=userDAO.get(uid);
			String name= request.getParameter("name");
			String detail= request.getParameter("detail");
			float price = Float.parseFloat(request.getParameter("price"));

			int stock = Integer.parseInt(request.getParameter("stock"));
			String reward=request.getParameter("reward");
			String mobile=request.getParameter("mobile");
			String projectCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) +RandomUtils.nextInt(10000);
			String status="waitCheck";
			Product p = new Product();
			p.setProjectCode(projectCode);
			p.setUser(u);
			p.setCategory(c);
			p.setName(name);
			
			p.setStock(stock);
			p.setReward(reward);
			p.setDetail(detail);
			p.setPrice(price);
			p.setMobile(mobile);
			p.setPublishDate(new Date());
			p.setCheckDate(new Date());
			p.setStatus(status);
		
			productDAO.add(p);
			
			int pid=p.getId();
			System.out.println("cid:"+c.getId());
			System.out.println(pid);
			
			/*return "@forereview?oid="+oid+"&showonly=true";	*/
		/*	request.setAttribute("p", p);*/
			
			/*
			 * 是否考虑在这里通过传递一种状态给前台，然后前台判断，再通过ajax去访问下一步
			 */
			return "@foreprojectimglist?pid="+pid;
		
	}
	public String projectimgadd(HttpServletRequest request, HttpServletResponse response, Page page) {
		//上传文件的输入流
		InputStream is = null;
		//提交上传文件时的其他参数
		Map<String,String> params = new HashMap<>();

		//解析上传
        is = parseUpload(request, params);		
		
        //根据上传的参数生成productImage对象
		String type= params.get("type");
		int pid = Integer.parseInt(params.get("pid"));
		Product p =productDAO.get(pid);
		
		ProductImage pi = new ProductImage();		
		pi.setType(type);
		pi.setProduct(p);
		productImageDAO.add(pi);
		p.setFirstProductImage(pi);
		System.out.println("图片增加id"+p.getFirstProductImage().getId());
		
		
		//生成文件
    	String fileName = pi.getId()+ ".jpg";
        String imageFolder;
        String imageFolder_small=null;
        String imageFolder_middle=null;
        if(ProductImageDAO.type_single.equals(pi.getType())){
        	imageFolder= request.getSession().getServletContext().getRealPath("img/productSingle");
        	imageFolder_small= request.getSession().getServletContext().getRealPath("img/productSingle_small");
        	imageFolder_middle= request.getSession().getServletContext().getRealPath("img/productSingle_middle");
        }
        	
        
        else
        	imageFolder= request.getSession().getServletContext().getRealPath("img/productDetail");
        File f = new File(imageFolder, fileName);
        f.getParentFile().mkdirs();
        
        // 复制文件
		try {
			if(null!=is && 0!=is.available()){
			    try(FileOutputStream fos = new FileOutputStream(f)){
			        byte b[] = new byte[1024 * 1024];
			        int length = 0;
			        while (-1 != (length = is.read(b))) {
			            fos.write(b, 0, length);
			        }
			        fos.flush();
			        //通过如下代码，把文件保存为jpg格式
			        BufferedImage img = ImageUtil.change2jpg(f);
			        ImageIO.write(img, "jpg", f);		
			        
			        if(ProductImageDAO.type_single.equals(pi.getType())){
			        	File f_small = new File(imageFolder_small, fileName);
			        	File f_middle = new File(imageFolder_middle, fileName);

			        	ImageUtil.resizeImage(f, 56, 56, f_small);
			        	ImageUtil.resizeImage(f, 217, 190, f_middle);
			        }
			        	
			        
			    }
			    catch(Exception e){
			    	e.printStackTrace();
			    }
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        
		
		return "@foreprojectimglist?pid="+p.getId();
	}
	
	
	public String projectimgdelete(HttpServletRequest request, HttpServletResponse response, Page page) {
		int id = Integer.parseInt(request.getParameter("id"));
		ProductImage pi = productImageDAO.get(id);
		productImageDAO.delete(id);
		
        
        if(ProductImageDAO.type_single.equals(pi.getType())){
        	String imageFolder_single= request.getSession().getServletContext().getRealPath("img/productSingle");
        	String imageFolder_small= request.getSession().getServletContext().getRealPath("img/productSingle_small");
        	String imageFolder_middle= request.getSession().getServletContext().getRealPath("img/productSingle_middle");
        	
        	File f_single =new File(imageFolder_single,pi.getId()+".jpg");
    		f_single.delete();
    		File f_small =new File(imageFolder_small,pi.getId()+".jpg");
    		f_small.delete();
    		File f_middle =new File(imageFolder_middle,pi.getId()+".jpg");
    		f_middle.delete();
        	
        }

        else{
        	String imageFolder_detail= request.getSession().getServletContext().getRealPath("img/productDetail");
    		File f_detail =new File(imageFolder_detail,pi.getId()+".jpg");
    		f_detail.delete();        	
        }
		return "@foreprojectimglist?pid="+pi.getProduct().getId();
	}
	public String projectimglist(HttpServletRequest request, HttpServletResponse response, Page page) {
		int pid = Integer.parseInt(request.getParameter("pid"));
		Product p =productDAO.get(pid);
		List<ProductImage> pisSingle = productImageDAO.list(p, ProductImageDAO.type_single);
		List<ProductImage> pisDetail = productImageDAO.list(p, ProductImageDAO.type_detail);
		
		request.setAttribute("p", p);
		request.setAttribute("pisSingle", pisSingle);
		request.setAttribute("pisDetail", pisDetail);
		
		return "projectimg.jsp";
	}
}
