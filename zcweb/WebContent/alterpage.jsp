<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<script>
	$(function() {
		$("#addForm").submit(function() {
			if (!checkEmpty("name", "产品名称"))
				return false;
// 			if (!checkEmpty("subTitle", "小标题"))
// 				return false;
			if (!checkNumber("orignalPrice", "原价格"))
				return false;
			if (!checkNumber("promotePrice", "优惠价格"))
				return false;
			if (!checkInt("stock", "库存"))
				return false;
			return true;
		});
	});
</script>	
	
	
	

	
	
	
	
	
	
	
					<div class="panel panel-primary addDiv">
						<div class="panel-heading">修改项目信息</div>
						<div class="panel-body">
<form method="post" id="addForm" action="foredoAlter?pid=${p.id}">
				<table class="addTable">
					<tr>
						<td>众筹项目名称</td>
						<td><input id="name" name="name" type="text" value="${p.name}"
							class="form-control"></td>
					</tr>
						<tr>
						<td>
						设置分类
						</td>
						
<td>
	<select class="form-control" onchange="selectOnchang(this)" name="selectcid">

		<c:forEach items="${cs}" var="c">

			<option value="${c.id }" >${c.name}</option>
		</c:forEach>


	</select>
</td>
					</tr>
					<tr>
						<td>项目简介</td>
						<td>
							<textarea  id="detail" name="detail" 
							class="form-control">${p.detail}</textarea>
						</td>
					</tr>
					<tr>
						<td>众筹单价</td>
						<td><input id="price" value="${p.price}" name="price" type="text" 
							class="form-control"></td>
					</tr>
					<tr>
						<td>众筹份额</td>
						<td><input id="stock"  value="${p.stock}" name="stock" type="text"
							class="form-control"></td>
					</tr>
					<tr>
						<td>回报奖励</td>
						<td><input id="reward" name="reward" type="text" value="${p.reward}"
							class="form-control"></td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td><input id="mobile" name="mobile" type="text" value="${p.mobile}"
							class="form-control"></td>
					</tr>
					

					<tr class="submitTR">
						<td colspan="2" align="center">
						<!-- 这里就实现了获取当前cid然后一起提交 -->
							<input type="hidden" name="uid" value="${user.id}">
							<button type="submit" class="btn btn-primary">下一步</button>
						</td>
					</tr>
				</table>
			</form>
						</div>
					</div>