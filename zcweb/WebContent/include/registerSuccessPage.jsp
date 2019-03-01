

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	
<script>
$("button").click(function(){
	alert("fdsa");
	$("#loginModal").modal('show');      
   /*  var page = "forecheckLogin";
    $.get(
            page,
            function(result){
                if("success"==result){
                    var num = $(".productNumberSetting").val();
                    location.href= $(".buyLink").attr("href")+"&num="+num;
                }
                else{
                    $("#loginModal").modal('show');                     
                }
            }
    );      
    return false; */
});
 
$("button.loginSubmitButton").click(function(){
    var name = $("#name").val();
    var password = $("#password").val();
     
    if(0==name.length||0==password.length){
        $("span.errorMessage").html("请输入账号密码");
        $("div.loginErrorMessageDiv").show();           
        return false;
    }
     
    var page = "foreloginAjax";
    $.get(
            page,
            {"name":name,"password":password},
            function(result){
                if("success"==result){
                    location.reload();
                }
                else{
                    $("span.errorMessage").html("账号密码错误");
                    $("div.loginErrorMessageDiv").show();                       
                }
            }
    );          
     
    return true;
});
</script>
	
<div class="registerSuccessDiv">
	
		<img src="img/site/registerSuccess.png">
			恭喜注册成功
		<button  type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2">
                            点我登陆
                        </button>
		
		
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