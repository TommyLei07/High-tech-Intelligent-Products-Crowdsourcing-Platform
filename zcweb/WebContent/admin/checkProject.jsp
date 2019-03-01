
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
/* $(function(){
	$("button.orderPageCheckOrderItems").click(function(){
		var oid = $(this).attr("oid");
		$("tr.orderPageOrderItemTR[oid="+oid+"]").toggle();
	});
}); */

</script>

<title>订单管理</title>


<div class="workingArea">
<h3><span class="label label-info">审核管理</span></h3>
	<br>
	<br>
	
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover1  table-condensed">
			<thead>
				<tr class="success">
					<th>ID</th>
					<th>状态</th>
					<th>项目名称</th>
					<th>项目单号</th>
					<th>项目类型</th>
					<th>众筹单价</th>
					<th width="100px">众筹份额</th>
					<th width="100px">发布人名称</th>
					<th>联系电话</th>
					<th>发布时间</th>
					
					<th width="220px">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ps}" var="p">
					<tr>
						<td>${p.id}</td>
						<td>${p.statusDesc}</td>
						<td align="center">${p.name}</td>
						<td align="center">${p.projectCode}</td>
						<td align="center">${p.category.name}</td>
						<td>￥<fmt:formatNumber type="number" value="${p.price}" minFractionDigits="2"/></td>
						<td align="center">${p.stock}</td>
						<td align="center">${p.user.name}</td>
						<td align="center">${p.mobile}</td>
						<td><fmt:formatDate value="${p.publishDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						

						<td>
							<button class="btn btn-primary btn-xs" type="button" data-toggle="collapse" data-target="#detail${p.id}" aria-expanded="false" aria-controls="collapseExample">
  查看详情
</button>
	
							<c:if test="${p.status!='Checked'}">
								<div class="btn-group ">
									<button type="button" class="btn btn-primary btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    项目操作 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a href="admin_project_alter?id=${p.id}">重新修改信息</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="admin_project_check?id=${p.id}">确认通过</a>	</li>
									</ul>
								</div>
							</c:if>
						
							
						</td>
					</tr>
					<tr>
					<td colspan="11">
					<div class="collapse" id="detail${p.id}">
								<div class="well">
								 <table>
								 <tr>
								 	<td align="left">项目简介：${p.detail}</td>
								 </tr>
								 <tr>
								 	
										<td align="left">项目回报：${p.reward}</td>							 	
								 
								 </tr>
								 </table>
								</div>
	  				</div>
					</td>
					
	  				</tr>
				</c:forEach>
				
				
			</tbody>
		</table>
	</div>
	
	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>
	

	
</div>

<%@include file="../include/admin/adminFooter.jsp"%>
