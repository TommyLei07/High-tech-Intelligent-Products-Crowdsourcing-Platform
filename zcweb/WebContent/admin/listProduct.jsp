

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
/* 	$(function() {
		$("#addForm").submit(function() {
			if (!checkEmpty("name", "产品名称"))
				return false;
			if (!checkEmpty("subTitle", "小标题"))
				return false;
			if (!checkNumber("orignalPrice", "原价格"))
				return false;
			if (!checkNumber("promotePrice", "优惠价格"))
				return false;
			if (!checkInt("stock", "库存"))
				return false;
			return true;
		});
	}); */
</script>

<title>产品管理</title>


<div class="workingArea">

	<ol class="breadcrumb">
	  <li><a href="admin_category_list">所有分类</a></li>
	  <li><a href="admin_product_list?cid=${c.id}">${c.name}</a></li>
	  <li class="active">产品管理</li>
	</ol>



	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th>ID</th>
					
					<th>图片</th>
					<th>项目单号</th>
					<th>项目名称</th>
					<th>发起人名称</th>
					
					<th width="80px">众筹单价</th>
					<th width="80px">众筹份额</th>
					<th width="80px">已售出</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ps}" var="p">
					<tr>
						<td>${p.id}</td>
						<td>
						
						<c:if test="${!empty p.firstProductImage}">
							<img width="40px" src="img/productSingle/${p.firstProductImage.id}.jpg">
						</c:if>
						
						</td>
						<td>${p.projectCode}</td>
						<td>${p.name}</td>
						<td>${p.user.name}</td>
						<td>${p.price}</td>
						<td>${p.stock}</td>
						<td>${p.saleCount}</td>
						

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp"%>
	</div>


</div>

<%@include file="../include/admin/adminFooter.jsp"%>
