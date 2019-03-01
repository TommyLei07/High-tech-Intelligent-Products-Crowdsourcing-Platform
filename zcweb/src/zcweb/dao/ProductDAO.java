package zcweb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import zcweb.bean.Category;
import zcweb.bean.Product;
import zcweb.bean.ProductImage;
import zcweb.bean.User;
import zcweb.util.DBUtil;
import zcweb.util.DateUtil;

  
public class ProductDAO {
	
	public static final String waitCheck = "waitCheck";
	public static final String waitAlter = "waitAlter";
	
	//审核通过，等待众筹,在前台加判断，只显示该状态的项目
	public static final String Checked = "Checked";

	
	public static final String deleted = "deleted";
	//众筹完成，finished状态
	public static final String Finished = "Finished";

  
    public int getTotal() {
        int total = 0;
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "select count(*) from Project  ";
  
            ResultSet rs = s.executeQuery(sql);
            while (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
        return total;
    }
	
    public int getTotal(int cid) {
        int total = 0;
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "select count(*) from Project where cid = " + cid;
  
            ResultSet rs = s.executeQuery(sql);
            while (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
        return total;
    }
  
  
    
    public void add(Product bean) {
 
    	String sql = "insert into Project values(null,?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
        	
        	ps.setInt(1, bean.getCategory().getId());
            ps.setString(2, bean.getProjectCode());
            ps.setString(3, bean.getName());
            ps.setString(4, bean.getDetail());
            ps.setString(5, bean.getReward());
            ps.setFloat(6, bean.getPrice());
            ps.setInt(7, bean.getStock());
            ps.setInt(8, bean.getUser().getId());
            ps.setString(9,bean.getMobile());
            ps.setTimestamp(10, DateUtil.d2t(bean.getPublishDate()));
         
            ps.setTimestamp(11,DateUtil.d2t(bean.getCheckDate()));
            ps.setString(12, bean.getStatus());
       
            ps.execute();
  
  
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                bean.setId(id);
            }
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
    }
  
    public void update(Product bean) {
 
    	String sql =
    			"update Project set cid=?,projectCode=?,name=?,detail=?,reward=?, price=?,stock=?,uid=?,mobile=?,publishDate=?,checkDate=?,status=? where id = ?";
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
        	ps.setInt(1, bean.getCategory().getId());
            ps.setString(2, bean.getProjectCode());
            ps.setString(3, bean.getName());
            ps.setString(4, bean.getDetail());
            ps.setString(5, bean.getReward());
            ps.setFloat(6, bean.getPrice());
            ps.setInt(7, bean.getStock());
            ps.setInt(8, bean.getUser().getId());
            ps.setString(9,bean.getMobile());
            ps.setTimestamp(10, DateUtil.d2t(bean.getPublishDate()));
         
            ps.setTimestamp(11,DateUtil.d2t(bean.getCheckDate()));
            ps.setString(12, bean.getStatus());
            ps.setInt(13, bean.getId());
            ps.execute();
  
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
  
    }
    
    
  
    public void delete(int id) {
  
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "delete from Project where id = " + id;
  
            s.execute(sql);
  
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
    }
  
    public Product get(int id) {
        Product bean = new Product();
  
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "select * from Project where id = " + id;
  
            ResultSet rs = s.executeQuery(sql);
  
            if (rs.next()) {
 
            	 int cid = rs.getInt("cid");
            	 String projectCode=rs.getString("projectCode");
                String name = rs.getString("name");
                String detail = rs.getString("detail");
                String reward=rs.getString("reward");
                float price = rs.getFloat("price");
             
                int stock = rs.getInt("stock");
                int uid=rs.getInt("uid");
                String mobile=rs.getString("mobile");
                Date publishDate=DateUtil.t2d(rs.getTimestamp("publishDate"));
                
                Date checkDate = DateUtil.t2d( rs.getTimestamp("checkDate"));
             /*   String status=rs.getString("status");*/
                
                Category category = new CategoryDAO().get(cid);
                bean.setProjectCode(projectCode);
                bean.setName(name);
                bean.setDetail(detail);
                bean.setReward(reward);
                bean.setPrice(price);
                bean.setStock(stock);
               User user=new UserDAO().get(uid);
               bean.setUser(user);
               bean.setMobile(mobile);
                bean.setCategory(category);
                bean.setPublishDate(publishDate);
                bean.setCheckDate(checkDate);
               /* bean.setStatus(status);*/
                bean.setId(id);
                setFirstProductImage(bean);
            }
  
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
        return bean;
    }
  
    public List<Product> list(int cid) {
        return list(cid,0, Short.MAX_VALUE);
    }
  
    public List<Product> list(int cid, int start, int count) {
        List<Product> beans = new ArrayList<Product>();
        Category category = new CategoryDAO().get(cid);
        String sql = "select * from Project where cid = ? order by id desc limit ?,? ";
  
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
            ps.setInt(1, cid);
            ps.setInt(2, start);
            ps.setInt(3, count);
  
            ResultSet rs = ps.executeQuery();
  
            while (rs.next()) {
                Product bean = new Product();
               int id=rs.getInt("id");
           	 String projectCode=rs.getString("projectCode");
               String name = rs.getString("name");
               String detail = rs.getString("detail");
               String reward=rs.getString("reward");
               float price = rs.getFloat("price");
            
               int stock = rs.getInt("stock");
               int uid=rs.getInt("uid");
               String mobile=rs.getString("mobile");
               Date publishDate=DateUtil.t2d(rs.getTimestamp("publishDate"));
               
               Date checkDate = DateUtil.t2d( rs.getTimestamp("checkDate"));
               String status=rs.getString("status");
               
               
              bean.setId(id);
               bean.setProjectCode(projectCode);
               bean.setName(name);
               bean.setDetail(detail);
               bean.setReward(reward);
               bean.setPrice(price);
               bean.setStock(stock);
              User user=new UserDAO().get(uid);
              bean.setUser(user);
              bean.setMobile(mobile);
               bean.setCategory(category);
               bean.setPublishDate(publishDate);
               bean.setCheckDate(checkDate);
               bean.setStatus(status);
         
               setFirstProductImage(bean);
                beans.add(bean);
            }
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
        return beans;
    }
   
    public List<Product> list() {
        return list(0,Short.MAX_VALUE);
    }
    
    public List<Product> listu(int uid) {
        return list(uid,0, Short.MAX_VALUE);
    }
     
    public List<Product> listu(int uid, int start, int count) {
        List<Product> beans = new ArrayList<Product>();
        User user=new UserDAO().get(uid);
        String sql = "select * from Project where uid=? order by id desc limit ?,? ";
  
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
        	ps.setInt(1,uid);
            ps.setInt(2, start);
            ps.setInt(3, count);
  
            ResultSet rs = ps.executeQuery();
  
            while (rs.next()) {         	           	        
                Product bean = new Product();
                int id = rs.getInt(1);
                int cid = rs.getInt("cid");
                String name = rs.getString("name");          
                int stock = rs.getInt("stock");
                String projectCode=rs.getString("projectCode");          
                String detail = rs.getString("detail");
                String reward=rs.getString("reward");
                float price = rs.getFloat("price");
          
                String mobile=rs.getString("mobile");
                Date publishDate=DateUtil.t2d(rs.getTimestamp("publishDate"));        
                Date checkDate = DateUtil.t2d( rs.getTimestamp("checkDate"));
                String status=rs.getString("status");
                
                bean.setId(id);
                bean.setProjectCode(projectCode);
                bean.setName(name);
                bean.setDetail(detail);
                bean.setReward(reward);
                bean.setPrice(price);
                bean.setStock(stock);
               
               bean.setUser(user);
               bean.setMobile(mobile);
               Category category = new CategoryDAO().get(cid);
                bean.setCategory(category);
                bean.setPublishDate(publishDate);
                bean.setCheckDate(checkDate);
                bean.setStatus(status);
          
                setFirstProductImage(bean);
 
                beans.add(bean);
            }
    	} 
            catch (SQLException e) {
    		
    		e.printStackTrace();
    	}
    	return beans;
    }
    
 
    
    
    public List<Product> list(int start, int count) {
        List<Product> beans = new ArrayList<Product>();
 
        String sql = "select * from Project limit ?,? ";
  
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
 
            ps.setInt(1, start);
            ps.setInt(2, count);
  
            ResultSet rs = ps.executeQuery();
  
            while (rs.next()) {         	           	        
                Product bean = new Product();
                int id = rs.getInt(1);
                int cid = rs.getInt("cid");
                String name = rs.getString("name");          
                int stock = rs.getInt("stock");
                String projectCode=rs.getString("projectCode");          
                String detail = rs.getString("detail");
                String reward=rs.getString("reward");
                float price = rs.getFloat("price");
                int uid=rs.getInt("uid");
                String mobile=rs.getString("mobile");
                Date publishDate=DateUtil.t2d(rs.getTimestamp("publishDate"));        
                Date checkDate = DateUtil.t2d( rs.getTimestamp("checkDate"));
                String status=rs.getString("status");
                
                bean.setId(id);
                bean.setProjectCode(projectCode);
                bean.setName(name);
                bean.setDetail(detail);
                bean.setReward(reward);
                bean.setPrice(price);
                bean.setStock(stock);
               User user=new UserDAO().get(uid);
               bean.setUser(user);
               bean.setMobile(mobile);
               Category category = new CategoryDAO().get(cid);
                bean.setCategory(category);
                bean.setPublishDate(publishDate);
                bean.setCheckDate(checkDate);
                bean.setStatus(status);
          
                setFirstProductImage(bean);
 
                beans.add(bean);
            }
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
        return beans;
    }    
 
    public void fill(List<Category> cs) {
        for (Category c : cs) 
            fill(c);
    }
    public void fill(Category c) {
            List<Product> ps = this.list(c.getId());
            c.setProducts(ps);
    }
 
    public void fillByRow(List<Category> cs) {
        int productNumberEachRow = 8;
        for (Category c : cs) {
            List<Product> products =  c.getProducts();
            List<List<Product>> productsByRow =  new ArrayList<>();
            for (int i = 0; i < products.size(); i+=productNumberEachRow) {
                int size = i+productNumberEachRow;
                size= size>products.size()?products.size():size;
                List<Product> productsOfEachRow =products.subList(i, size);
                productsByRow.add(productsOfEachRow);
            }
            c.setProductsByRow(productsByRow);
        }
    }
     
    public void setFirstProductImage(Product p) {
        List<ProductImage> pis= new ProductImageDAO().list(p, ProductImageDAO.type_single);
        if(!pis.isEmpty())
            p.setFirstProductImage(pis.get(0));     
    }
     
    public void setSaleAndReviewNumber(Product p) {
        int saleCount = new OrderItemDAO().getSaleCount(p.getId());
        p.setSaleCount(saleCount);          
 
        int reviewCount = new ReviewDAO().getCount(p.getId());
        p.setReviewCount(reviewCount);
         
    }

 
    public void setSaleAndReviewNumber(List<Product> products) {
        for (Product p : products) {
            setSaleAndReviewNumber(p);
        }
    }
 
    public List<Product> search(String keyword, int start, int count) {
         List<Product> beans = new ArrayList<Product>();
          
         if(null==keyword||0==keyword.trim().length())
             return beans;
            String sql = "select * from Project where name like ? limit ?,? ";
      
            try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
                ps.setString(1, "%"+keyword.trim()+"%");
                ps.setInt(2, start);
                ps.setInt(3, count);
      
                ResultSet rs = ps.executeQuery();
      
                while (rs.next()) {
                    Product bean = new Product();
                    int id = rs.getInt(1);
                    int cid = rs.getInt("cid");
                    String name = rs.getString("name");          
                    int stock = rs.getInt("stock");
                    String projectCode=rs.getString("projectCode");          
                    String detail = rs.getString("detail");
                    String reward=rs.getString("reward");
                    float price = rs.getFloat("price");
                    int uid=rs.getInt("uid");
                    String mobile=rs.getString("mobile");
                    Date publishDate=DateUtil.t2d(rs.getTimestamp("publishDate"));        
                    Date checkDate = DateUtil.t2d( rs.getTimestamp("checkDate"));
                    String status=rs.getString("status");
                    
                    bean.setId(id);
                    bean.setProjectCode(projectCode);
                    bean.setName(name);
                    bean.setDetail(detail);
                    bean.setReward(reward);
                    bean.setPrice(price);
                    bean.setStock(stock);
                   User user=new UserDAO().get(uid);
                   bean.setUser(user);
                   bean.setMobile(mobile);
                   Category category = new CategoryDAO().get(cid);
                    bean.setCategory(category);
                    bean.setPublishDate(publishDate);
                    bean.setCheckDate(checkDate);
                    bean.setStatus(status);
              
                    setFirstProductImage(bean);
     
                    beans.add(bean);
                }
            } catch (SQLException e) {
      
                e.printStackTrace();
            }
            return beans;
    }
}

