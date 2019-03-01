package zcweb.bean;

public class User {
	private String password;
	private String name;
	private int id;
	private int userBuyNumber;
	private float userBuyTotal;
	private int publishNumber;
	private float publishTotal;
	
	
	public int getPublishNumber(){
		return publishNumber;
	}
	public void setPublishNumber(int publishNumber){
		this.publishNumber=publishNumber;
	}
	public float getPublishTotal(){
		return publishTotal;
	}
	public void setPublishTotal(float publishTotal){
		this.publishTotal=publishTotal;
	}
	public float getUserBuyTotal(){
		return userBuyTotal;
	}
	public void setUserBuyTotal(float userBuyTotal){
		this.userBuyTotal=userBuyTotal;
	}

	public int getUserBuyNumber(){
		return userBuyNumber;
	}
	public void setUserBuyNumber(int userBuyNumber){
		this.userBuyNumber=userBuyNumber;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAnonymousName(){
		if(null==name)
			return null;
		
		if(name.length()<=1)
			return "*";
		
		if(name.length()==2)
			return name.substring(0,1) +"*";
		
		char[] cs =name.toCharArray();
		for (int i = 1; i < cs.length-1; i++) {
			cs[i]='*';
		}
		return new String(cs);
		
		
	}
	
}

