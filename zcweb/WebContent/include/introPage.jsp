<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	
	<script>
	 $(function(){
			
			<c:if test="${!empty msg}">
			alert("${msg}");
			</c:if>

		}) ;
	</script>
	
	
	
	    <div style="font-size:14px;margin-top:-20px;" class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="headingOne">
            <h4 class="panel-title">
              <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
               项目概述
              </a>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
            <div class="panel-body">
                该网站平台为学校JavaEE课设的一个选题：随着信息技术的发展，
                各种智能化产品及发明创意日益增多。很多产品或项目需要通过众筹的方式，
                筹集资金，获得研发或生产制造方面的支持，国内众筹市场规模逐年增大。
                通过访问京东众筹等众筹平台，参考实现一个针对智能高科技产品进行众筹的网站。
                该网站能及时发布智能高科技产品信息，为用户提供方便的众筹、展销途径。
            </div>
          </div>
        </div>
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="headingTwo">
            <h4 class="panel-title">
              <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                平台介绍
              </a>
            </h4>
          </div>
          <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
            <div class="panel-body">
                经过7*24小时工作，该网站总体完成，参照一般的电商网站的购物流程，该平台的整体业务流程上也基本相同。
             平台分为前台（面向用户），后台（系统管理员）两大部分组成。</br>在网站前台，提供给用户如下功能：
                <dl class="dl-horizontal">
                        <dt>注册登陆</dt>
                        <dd>一个网站最基本的功能。。不多说</dd>
                        <dt>加入众筹</dt>
                        <dd>用户可以查看每一个众筹项目的众筹进度，产品介绍，买家评价等，对心仪的产品可以进行众筹支持</dd>
                        <dt>发布众筹</dt>
                        <dd>每一个用户既可以支持众筹，也可以自己发布众筹产品。但目前在发布众筹模块中，还没有加入用户资格审核功能。</dd>
                        <dt>个人信息统计</dt>
                        <dd>基于以往的购物数据，生成个人购物数据信息（后期考虑使用百度echarts的接口，生成数据统计图）</dd>
                        
                        <dt>产品排序</dt>
                        <dd>在产品搜索页，用户可以按照评价，销量，价格等不同权重进行产品的排序</dd>
                        <dt>第三方支付</dt>
                        <dd>网站设计了第三方支付的功能，但目前还没有时间实现支付接口。在业务场景转换中用支付宝二维码代替了该模块。</dd>
						                        <dt>...</dt>
                        <dd>...</dd>                     
                      </dl>
                  </br>
                  在网站后台，提供给管理员如下功能：
                  <dl class="dl-horizontal">
                        <dt>登陆入口</dt>
                        <dd>后台管理使用不同于前台网站的路径为登陆的入口，以此做到简单的权限设置</dd>
                        <dt>分类管理</dt>
                        <dd>管理员可以给网站添加或修改众筹产品类别（原则上是不允许管理员删除某一类别的），也可以查看不同类别下所有的众筹产品</dd>
                        <dt>用户管理</dt>
                        <dd>查看网站所有注册用户</dd>
                        <dt>订单管理</dt>
                        <dd>前台网站用户生成的订单统一在这里进行管理，如详情查看，发货等。</dd>
                        <dt>审核管理</dt>
                        <dd>对于前台网站提交的众筹项目，在后台进行审核，若通过则允许发布在前台网站页面上，若不通过，则返回给发起者重新修改信息。</dd>
                       <dt>...</dt>
                        <dd>...</dd>
                      
                      </dl>
                
            </div>
          </div>
        </div>
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="headingThree">
            <h4 class="panel-title">
              <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
               技术栈
              </a>
            </h4>
          </div>
          <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
            <div class="panel-body">
             整个项目使用MVC的设计模式。后端使用经典的javaEE技术，Javabean+DAO+servlet。前端界面使用boostrap框架，jsp使用模块化的设计，简化的维护成本。
             在前后端的交互过程中，设计了Filter,采用Filter+Servlet+反射，精简了原本许多的servlet
web.xml的配置文件也大大减少，降低了开发和维护的工作量，减少了出错的几率。之后有时间学习ssm等框架之后，再将这个项目改造升级一下。
            </div>
          </div>
        </div>
        
        
        <div class="panel panel-default">
          <div class="panel-heading" role="tab" id="headingFour">
            <h4 class="panel-title">
              <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
     给我留言
              </a>
            </h4>
          </div>
          <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
            <div class="panel-body">
 <form method="post" action="forewebreview">
  <div class="form-group">
    <label for="exampleInputEmail1">留言内容</label>
    <textarea class="form-control" name="content" rows="3"></textarea>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">你的名字：</label>
    <input type="text" name="name" class="form-control" id="exampleInputPassword1" placeholder="Your name">
  </div>
    <div class="form-group">
    <label for="exampleInputPassword1">你的联系方式：</label>
    <input type="text" name="contact" class="form-control" id="exampleInputPassword1" placeholder="可以不填">
  </div>

  <button type="submit" class="btn btn-default">提交</button>
</form>
            </div>
          </div>
        </div>
                