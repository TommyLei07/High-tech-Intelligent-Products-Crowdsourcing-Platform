

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 
<script>
 
$(function(){
    var stock = ${p.stock};
    var price = ${p.price};
    var totle=stock*price;
    
    $(".productNumberSetting").keyup(function(){
        var num= $(".productNumberSetting").val();
        num = parseInt(num);
        if(isNaN(num))
            num= 1;
        if(num<=0)
            num = 1;
        if(num>stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
     
    $(".increaseNumber").click(function(){
        var num= $(".productNumberSetting").val();
        num++;
        if(num>stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
    $(".decreaseNumber").click(function(){
        var num= $(".productNumberSetting").val();
        --num;
        if(num<=0)
            num=1;
        $(".productNumberSetting").val(num);
    });
     
    $(".addCartButton").removeAttr("disabled");
    $(".addCartLink").click(function(){
        var page = "forecheckLogin";
        $.get(
                page,
                function(result){
                    if("success"==result){
                        var pid = ${p.id};
                        var num= $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";
                        $.get(
                                addCartpage,
                                {"pid":pid,"num":num},
                                function(result){
                                    if("success"==result){
                                       /*  $(".addCartButton").html("已加入购物车");
                                        $(".addCartButton").attr("disabled","disabled");
                                        $(".addCartButton").css("background-color","lightgray")
                                        $(".addCartButton").css("border-color","lightgray")
                                        $(".addCartButton").css("color","black") */
                                    	location.reload();
                                         
                                    }
                                    else{
                                         
                                    }
                                }
                        );                          
                    }
                    else{
                        $("#loginModal").modal('show');                     
                    }
                }
        );      
        return false;
    });
    $(".buyLink").click(function(){
        var page = "forecheckLogin";
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
        return false;
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
     
    $("img.smallImage").mouseenter(function(){
        var bigImageURL = $(this).attr("bigImageURL");
        $("img.bigImg").attr("src",bigImageURL);
    });
     
    $("img.bigImg").load(
        function(){
            $("img.smallImage").each(function(){
                var bigImageURL = $(this).attr("bigImageURL");
                img = new Image();
                img.src = bigImageURL;
                 
                img.onload = function(){
                    $("div.img4load").append($(img));
                };
            });     
        }
    );
});
 
</script>
    <div class="imgAndInfo">
            <div class="imgInimgAndInfo">
              <img src="img/productSingle/${p.firstProductImage.id}.jpg" class="bigImg">
              <div class="smallImageDiv">
                    <c:forEach items="${p.productSingleImages}" var="pi">
                        <img src="img/productSingle_small/${pi.id}.jpg" bigImageURL="img/productSingle/${pi.id}.jpg" class="smallImage">
                    </c:forEach>
                </div>
                <div class="img4load hidden"></div>
            </div>
            <div class="infoInimgAndInfo">
                <div class="productTitle">
                        ${p.name}
                </div>
                <div class="productSubTitle">
                        ${p.detail}
                </div>
                <div class="productPrice">
                    <div class="juhuasuan">
                        <div class="progress" id="progress">
                            <div class="progress" style="height:50px;">
  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;height:50px;width:${(p.saleCount/p.stock)*100}%">
   <span><fmt:formatNumber type="percent" value="${(p.saleCount/p.stock)}" minFractionDigits="2" /></span>
  </div>
</div>
                        </div>
                    </div>
                    <div class="productPriceDiv">
                        <div class="gouwujuanDiv">

                            <span>已筹到</span>
                        </div>

                        <div class="promotionDiv">

                            <span class="promotionPriceYuan">¥</span>
                            <span class="promotionPrice">
                                    <fmt:formatNumber type="number" value="${p.price*p.saleCount}" minFractionDigits="2" />
                            </span>
                        </div>
                    </div>
                </div>
                <div class="productSaleAndReviewNumber">
                    <div>支持者
                        <span class="redColor boldWord">${p.saleCount }</span>
                    </div>
                    <div>累计评价
                        <span class="redColor boldWord">  ${p.reviewCount}</span>
                    </div>
                </div>
                <div class="productNumber">
                    <span>数量</span>
                    <span>
                        <span class="productNumberSettingSpan">
                            <input type="text" value="1" class="productNumberSetting">
                        </span>
                        <span class="arrow">
                            <a class="increaseNumber" href="#nowhere">
                            
                                <span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
                            </a>
                            <span class="updownMiddle"> </span>
                            <a class="decreaseNumber" href="#nowhere">
                             
                                <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
                            </a>
                        </span>
                        件</span>
                    <span>&nbsp 剩余${p.stock-p.saleCount}件</span>
                </div>
                <div class="serviceCommitment">
                    <span class="serviceCommitmentDesc">服务承诺</span>
                    <span class="serviceCommitmentLink">
                        <a href="#nowhere">正品保证</a>
                        <a href="#nowhere">极速退款</a>
                        <a href="#nowhere">赠运费险</a>
                        <a href="#nowhere">七天无理由退换</a>
                    </span>
                </div>
                <div class="buyDiv">
                    <a href="forebuyone?pid=${p.id}" class="buyLink">
                        <button class="buyButton">
                            <span class="glyphicon glyphicon-thumbs-up">&nbsp我要支持</button>
                    </a>
                    <a class="addCartLink" href="#nowhere">
                        <button class="addCartButton">
                            <span class=" glyphicon glyphicon-heart"></span>&nbsp加入心愿单</button>
                    </a>
                </div>
            </div>
            <div style="clear:both"></div>
        </div>