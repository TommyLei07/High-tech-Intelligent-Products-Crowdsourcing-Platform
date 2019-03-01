
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

<title>网站留言</title>


<div class="workingArea">
<h3><span class="label label-info">网站留言</span></h3>
	<br>
	<br>
	
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover1  table-condensed">
			<thead>
				<tr class="success">
					<th>ID</th>
					<th>name</th>
					<th>username</th>
					
					
					<th width="120px">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${rs}" var="r">
					<tr>
						<td>${r.id}</td>
						<td>${r.name}</td>
						<td>${r.username}</td>
						

						<td>
							<button class="btn btn-primary btn-xs" type="button" data-toggle="collapse" data-target="#detail${r.id}" aria-expanded="false" aria-controls="collapseExample">
  查看详情
</button>
	

						
							
						</td>
					</tr>
					<tr>
					<td colspan="11">
					<div class="collapse" id="detail${r.id}">
								<div class="well">
								 <table>
								 <tr>
								 	<td align="left">留言内容：${r.content}</td>
								 </tr>
								 <tr>
								 	
										<td align="left">联系方式：${r.contact}</td>							 	
								 
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
