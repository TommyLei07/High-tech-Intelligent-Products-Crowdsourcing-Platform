<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	

<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html >
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>智能高科技产品众筹展销平台后台管理</title>

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="${basePath}admin/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${basePath}admin/assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="${basePath}admin/assets/css/form-elements.css">
        <link rel="stylesheet" href="${basePath}admin/assets/css/backlogin.css">
<script src="js/jquery/2.0.0/jquery.min.js"></script>
	
	<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>

   
    </head>
    <script>
 $(function(){
	
	<c:if test="${!empty msg}">
	alert("${msg}");
	</c:if>

}) ;
$(function(){
     $("#b1").click(function(){
        alert("点击了按钮");
     });
     $("button#login").click(function(){
   	 
           var name = $("#name").val();
           var password = $("#password").val();
            
           if(0==name.length||0==password.length){
            	alert("请输入完整信息");
               return false;
           }
                     
            
           return true;
       });
});
 


function check(form){
	if(form.name.value==""){
		alert("input name");
		form.name.focus();
		return false;
	}
	if(form.password.value==""){
		alert("input password");
		form.password.focus();
		return false;
	}
	if(form.repeatpassword.value==""){
		alert("input password");
		form.repeatpassword.focus();
	}
	return true;
	
} 

</script>
    

    <body style="background-color: skyblue">

		<!-- Top menu -->


        <!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-7 text">
                         
                            <h1>智能高科技产品众筹展销平台</h1>
                            <div class="description">
                            	<p style="text-align:center; text-indent: 38px;font-size: 26px;">
									后台管理入口
	                            	
                            	</p>
                            </div>

                        </div>
                        
                        <div class="col-sm-5 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>管理员账号</h3>
                            		<p>Adminstration Account</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-pencil"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="admin_login_login" method="post" class="registration-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-first-name">Name</label>
			                        	<input type="text" name="name" placeholder="Name" class="form-first-name form-control" id="name">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-last-name">Password</label>
			                        	<input type="password" name="password" placeholder="Password" class="form-last-name form-control" id="password">
			                        </div>
			                       
			                        <button type="submit" class="btn" id="login">登陆</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
           
        </div>


      
       


    </body>

</html>