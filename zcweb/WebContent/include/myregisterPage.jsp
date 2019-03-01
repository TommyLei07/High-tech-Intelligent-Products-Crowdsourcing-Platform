

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

	
<script>
$(function(){
	
	<c:if test="${!empty msg}">
	alert("${msg}");
	</c:if>
	
/* $(".registerForm").submit(function(){
		if(0==$("#name").val().length){
			$("span.errorMessage").html("请输入用户名");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		
		if(0==$("#password").val().length){
			$("span.errorMessage").html("请输入密码");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		
		if(0==$("#repeatpassword").val().length){
			$("span.errorMessage").html("请输入重复密码");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		
		if($("#password").val() !=$("#repeatpassword").val()){
			$("span.errorMessage").html("重复密码不一致");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		

		return true;
	}); */
})
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

  <div class="bg" style="height:100%;">
        <div class="container">
            <div class="row1">
                <div class="col-xs-12" id="title">
                    智能高科技产品众筹展销平台
                </div>
                <div class="col-xs-12" id="ad">
                    每个梦想家背后都有千万个你我
                </div>

                
                    <div class="col-xs-3"> </div>
                      <div class="col-xs-3" id="register">
                     <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                            新用户注册
                        </button>
                    </div>
                      <div class="col-xs-3" id="register">
                    <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal2">
                            会员登陆
                        </button>
                    </div>
                      <div class="col-xs-3" >
                    
                    </div>
                    
       
                       
                         
                        
                        
    <div class="modal fade" id="myModal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
                <div class="modal-dialog"> 
                    <div class="modal-content">
                        <div class="btn-info modal-header">
                            <button type="button" class="close" data-dismiss="modal"></button>
                            <h4>您好，欢迎注册</h4>
                        </div>
                        <div class="modal-body">
                           
                            <form method="post" action="foreregister" class="registerForm" role="form" id="myForm" onsubmit="return check(this) ">
                            
                                <div class="form-group">
                                    <label for="uname" class="col-sm-2 control-label">输入您的用户名</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="name" name="name" class="form-control well" placeholder="请输入用户名"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="upwd" class="col-sm-2 control-label">输入您的密码</label>
                                    <div class="col-sm-9">
                                      
                                    <input id="password" name="password" type="password" class="form-control well" placeholder="请输入密码"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                        <label for="upwd" class="col-sm-2 control-label">再次确认您的密码</label>
                                        <div class="col-sm-9">
                                            <input id="repeatpassword" type="password" class="form-control well" placeholder="请输入密码"/>
                                        </div>
                                    </div>
                            
                        </div>
    
                        <div class="modal-footer">
                 
                          <button  type="submit" class="btn btn-info">确定</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        </div>
                        </form>
   						
                    </div>
                </div>
        </div> <!-- class="modal fade" -->
                <div class="modal fade" id="myModal2"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
                <div class="modal-dialog"> 
                    <div class="modal-content">
                        <div class="btn-info modal-header">
                            <button type="button" class="close" data-dismiss="modal"></button>
                            <h4>您好，欢迎登陆</h4>
                        </div>
                        <div class="modal-body">
                            
                            <form class="loginForm" action="forelogin" method="post" role="form" id="myForm" onsubmit="return check(this) ">
                            
                                <div class="form-group">
                                    <label for="uname" class="col-sm-2 control-label">输入您的用户名</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="name" name="name" class="form-control well" placeholder="请输入用户名"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="upwd" class="col-sm-2 control-label">请输入您的密码</label>
                                    <div class="col-sm-9">
                                        <input id="password" name="password" type="password" class="form-control well" placeholder="请输入密码"/>
                                    </div>
                                </div>
                 
                            
                        </div>
    
                        <div class="modal-footer">
           
                          <button  type="submit" class="btn btn-info">确定</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        </div>
   						</form>
                    </div>
                </div>
            </div> 

                </div>

            </div>

        </div>