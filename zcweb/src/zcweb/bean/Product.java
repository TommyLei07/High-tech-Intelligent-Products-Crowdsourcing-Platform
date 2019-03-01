package zcweb.bean;

import java.util.Date;
import java.util.List;

import zcweb.dao.ProductDAO;



public class Product {
	

	
	

	private int stock;
	private Date createDate;
	
	private ProductImage firstProductImage;
	private List<ProductImage> productImages;
	private List<ProductImage> productSingleImages;
	private List<ProductImage> productDetailImages;
	private int reviewCount;
	private int saleCount;
	
	private Category category;
	private String name;
	private User user;
	private int id;
	private String projectCode;
	private String detail;
	private String reward;
	private float price;
	private String mobile;
	private Date publishDate;
	private Date checkDate;
	private String status;
	
	
	public String getStatusDesc(){
		String desc ="未知";
		switch(status){
			case ProductDAO.waitCheck:
				desc="待审核";
				break;
			case ProductDAO.waitAlter:
				desc="待修改";
				break;
			case ProductDAO.Checked:
				desc="已通过";
				break;
			
			case ProductDAO.Finished:
				desc="众筹已完成";
				break;
			case ProductDAO.deleted:
				desc="已删除";
				break;
			
			default:
				desc="未知";
		}
		return desc;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	public float getPrice(){
		return price;
	}
	public void setPrice(float price){
		this.price=price;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReward(){
		return reward;
	}
	public void setReward(String reward){
		this.reward=reward;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public Date getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
	
	public String getDetail(){
		return detail;
	}
	public void setDetail(String detail){
		this.detail=detail;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock=stock;
	}
	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	

	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String toString(){
		return name;
	}
	public ProductImage getFirstProductImage() {
		return firstProductImage;
	}
	public void setFirstProductImage(ProductImage firstProductImage) {
		this.firstProductImage = firstProductImage;
	}
	public List<ProductImage> getProductImages() {
		return productImages;
	}
	public void setProductImages(List<ProductImage> productImages) {
		this.productImages = productImages;
	}
	public List<ProductImage> getProductSingleImages() {
		return productSingleImages;
	}
	public void setProductSingleImages(List<ProductImage> productSingleImages) {
		this.productSingleImages = productSingleImages;
	}
	public List<ProductImage> getProductDetailImages() {
		return productDetailImages;
	}
	public void setProductDetailImages(List<ProductImage> productDetailImages) {
		this.productDetailImages = productDetailImages;
	}
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public int getSaleCount() {
		return saleCount;
	}
	public void setSaleCount(int saleCount) {
		this.saleCount = saleCount;
	}
	
	
	
}


