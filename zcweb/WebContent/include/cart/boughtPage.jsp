<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>


	<script>
		var deleteProject=false;
		var deleteProjectid=0;
		var deleteOrder = false;
		var deleteOrderid = 0;
		function selectOnchang(obj){  
			 var value = obj.options[obj.selectedIndex].value;
			 alert(value);
			}

		$(function () {
			
			$("a[role]").click(function () {
				var role = $(this).attr("role");


				$("div[role]").hide();
				$("div[role=" + role + "]").show();


				$("ul#myinfo li").removeClass("active");
				$(this).parent("li").addClass("active");
			});

			$("a[orderStatus]").click(function () {
				var orderStatus = $(this).attr("orderStatus");
				if ('all' == orderStatus) {
					$("table[orderStatus]").show();
				}
				else {
					/*这里只显示包含待付款待收货等状态的订单，所有状态为删除的就不显示了，在视图上实现删除*/
					$("table[orderStatus]").hide();
					$("table[orderStatus=" + orderStatus + "]").show();
				}
				/*修改当前的div为selected*/
				$("div.orderType div").removeClass("selectedOrderType");
				$(this).parent("div").addClass("selectedOrderType");
			});

			$("a.deleteOrderLink").click(function () {
				deleteOrderid = $(this).attr("oid");
				deleteOrder = false;
				$("#deleteConfirmModal").modal("show");
			});

			 $("button.deleteConfirmButton").click(function () {
				deleteOrder = true;
				$("#deleteConfirmModal").modal('hide');
			}); 

			$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
				if (deleteOrder) {
					var page = "foredeleteOrder";
					$.post(
						page,
						{ "oid": deleteOrderid },
						function (result) {
							if ("success" == result) {
								$("table.orderListItemTable[oid=" + deleteOrderid + "]").hide();
							}
							else {
								location.href = "login.jsp";
							}
						}
					);

				}
			}) 
			
			
			
			
			
			
			$("a.deleteProjectLink").click(function () {
				
				deleteProject = false;
				$("#deletePConfirmModal").modal("show");
			});

			$("button.deletePConfirmButton").click(function () {
				deleteProject = true;
				if (deleteProject) {
					
					var page = "foredeleteProject";
					
					$.post(
						page,
						{ "pid": deleteProjectid },
						function (result) {
							if ("success" == result) {
								$("table.orderListItemTable[pid=" + deleteProjectid + "]").hide();
							}
							else {
								location.href = "login.jsp";
							}
						}
					);

				}
				
				$("#deleteConfirmModal").modal('hide');
			});

/* 			$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
				
				if (deleteProject) {
					alert("test");
					var page = "foredeleteProject";
					alert(page);
					$.post(
						page,
						{ "pid": deleteProjectid },
						function (result) {
							if ("success" == result) {
								$("table.orderListItemTable[pid=" + deleteProjectid + "]").hide();
							}
							else {
								location.href = "login.jsp";
							}
						}
					);

				}
			}) */
			
			
			

			$(".ask2delivery").click(function () {
				var link = $(this).attr("link");
				$(this).hide();
				page = link;
				$.ajax({
					url: page,
					success: function (result) {
						alert("卖家已秒发，刷新当前页面，即可进行确认收货")
					}
				});

			});
		});

	</script>

	<div class="container">
		<div class="row">


			<div class="col-xs-2">
				<ul class="nav nav-pills nav-stacked" id="myinfo">
					<li id="myorder" class="active">
						<a role="myorderdiv" href="#">我支持的项目</a>
					</li>
					<li id="myproject">
						<a role="myprojectdiv" href="#">我发布的项目</a>
					</li>
					<li>
						<a role="myinfodiv" href="#">我的信息</a>
					</li>
					<li>
						<a  href="publish.jsp">发布众筹</a>
					</li>
				</ul>

			</div>

			<div class="col-xs-10 boughtDiv">
				<div role="myorderdiv" style="display:block">
					<div class="orderType">
						<div class="selectedOrderType">
							<a orderStatus="all" href="#nowhere">所有订单</a>
						</div>
						<div>
							<a orderStatus="waitPay" href="#nowhere">待付款</a>
						</div>
						<div>
							<a orderStatus="waitDelivery" href="#nowhere">待发货</a>
						</div>
						<div>
							<a orderStatus="waitConfirm" href="#nowhere">待收货</a>
						</div>
						<div>
							<a orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a>
						</div>
						<div class="orderTypeLastOne">
							<a class="noRightborder">&nbsp;</a>
						</div>
					</div>
					<div style="clear:both"></div>
					<div class="orderListTitle">
						<table class="orderListTitleTable">
							<tr>
								<td>宝贝</td>
								<td width="100px">单价</td>
								<td width="100px">数量</td>
								<td width="120px">实付款</td>
								<td width="100px">交易操作</td>
							</tr>
						</table>

					</div>

					<div class="orderListItem">
						<c:forEach items="${os}" var="o">
							<table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
								<tr class="orderListItemFirstTR">
									<td colspan="2">
										<b>
											<fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
										</b>
										<span>订单号: ${o.orderCode}
										</span>
									</td>
									<td colspan="2"></td>
									<td colspan="1">
										

									</td>
									<td class="orderItemDeleteTD">
									
									<c:if test="${o.status=='finish'||o.status=='waitReview' }">
										<a class="deleteOrderLink" oid="${o.id}" href="#nowhere">
											<span class="orderListItemDelete glyphicon glyphicon-trash"></span>
										</a>
									</c:if>
									</td>
								</tr>
								<c:forEach items="${o.orderItems}" var="oi" varStatus="st">
									<tr class="orderItemProductInfoPartTR">
										<td class="orderItemProductInfoPartTD">
											<img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg">
										</td>
										<td class="orderItemProductInfoPartTD">
											
												<a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
												
										</td>
										<td class="orderItemProductInfoPartTD" width="100px">

										
											<div class="orderListItemProductPrice">￥
												<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2" />
											</div>


										</td>
										<c:if test="${st.count==1}">

											<td  rowspan="${fn:length(o.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
												<span class="orderListItemNumber">${o.totalNumber}</span>
											</td>
											<td rowspan="${fn:length(o.orderItems)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
												<div class="orderListItemProductRealPrice">￥
													<fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" type="number" value="${o.total}" />
												</div>
												<div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
											</td>
											<td  rowspan="${fn:length(o.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
												<c:if test="${o.status=='waitConfirm' }">
													<a href="foreconfirmPay?oid=${o.id}">
														<button class="orderListItemConfirm">确认收货</button>
													</a>
												</c:if>
												<c:if test="${o.status=='waitPay' }">
													<a href="forealipay?oid=${o.id}&total=${o.total}">
														<button class="orderListItemConfirm">付款</button>
													</a>
												</c:if>

												<c:if test="${o.status=='waitDelivery' }">
													<span>待发货</span>
													<%-- 									<button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">催卖家发货</button> --%>

												</c:if>

												<c:if test="${o.status=='waitReview' }">
													<a href="forereview?oid=${o.id}">
														<button class="orderListItemReview">评价</button>
													</a>
												</c:if>
												<c:if test="${o.status=='finish' }">
													<span>交易已完成</span>
												</c:if>
											</td>
										</c:if>
									</tr>
								</c:forEach>

							</table>
						</c:forEach>

					</div>
				</div><!-- myorderdiv -->
				
				<div role="myprojectdiv" style="display:none;">
					<div class="orderType">
						<div class="selectedOrderType">
							<a orderStatus="all" href="#nowhere">所有众筹</a>
						</div>
						<div>
							<a orderStatus="waitCheck" href="#nowhere">待审核</a>
						</div>
						<div>
							<a orderStatus="waitAlter" href="#nowhere">待修改</a>
						</div>
						<div>
							<a orderStatus="Checked" href="#nowhere">已通过</a>
						</div>
						<div>
							<a orderStatus="Finished" href="#nowhere" class="noRightborder">众筹已完成</a>
						</div>
						<div class="orderTypeLastOne">
							<a class="noRightborder">&nbsp;</a>
						</div>
					</div>
					<div style="clear:both"></div>
										<div class="orderListTitle">
						<table class="orderListTitleTable">
							<tr>
								<td>众筹项目</td>
								<td width="100px">单价</td>
								<td width="100px">众筹数量</td>
								<td width="100px">已售出</td>
								<td width="120px">当前项目状态</td>
								<td width="100px">交易操作</td>
							</tr>
						</table>

					</div>

					<div class="orderListItem">
						<c:forEach items="${ps}" var="p">
						<c:if test="${p.status!='deleted' }">
							<table class="orderListItemTable" orderStatus="${p.status}" pid="${p.id}">
								<tr class="orderListItemFirstTR">
									<td colspan="2">
										<b>
											<fmt:formatDate value="${p.publishDate}" pattern="yyyy-MM-dd HH:mm:ss" />
										</b>
										<span>审核单号: ${p.projectCode}
										</span>
									</td>
									<td colspan="3"></td>
									<td colspan="1">
										

									</td>
									<td class="orderItemDeleteTD">
										<a class="deleteProjectLink" pid="${p.id}" href="#nowhere">
											<span class="orderListItemDelete glyphicon glyphicon-trash"></span>
										</a>

									</td>
								</tr>
								
									<tr class="orderItemProductInfoPartTR">
										<td class="orderItemProductInfoPartTD">
											<img width="80" height="80" src="img/productSingle_middle/${p.firstProductImage.id}.jpg" alt="暂无图片">
										</td>
										<td class="orderItemProductInfoPartTD">
										<a href="foreproduct?pid=${p.id}">${p.name}</a>
											
										</td>
										<td class="orderItemProductInfoPartTD" width="100px">

											<div class="">￥
												<fmt:formatNumber type="number" value="${p.price}" minFractionDigits="2" />
											</div>
											


										</td>
								

											<td  class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
												<span class="orderListItemNumber">${p.stock}</span>
											</td>
											<td  class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
												<span class="orderListItemNumber">${p.saleCount}</span>
											</td>
											<td  width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
												<div class="orderListItemProductRealPrice">
													<span>${p.statusDesc}</span>
												</div>
												
											</td>
											<td  class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
												<c:if test="${p.status=='waitCheck' }">
													<a href="foreAlter?pid=${p.id}">
														<button type="button" class="btn btn-default btn-sm" >修改信息</button>
													</a>
												</c:if>
												<c:if test="${p.status=='waitAlter' }">
													<a href="foreAlter?pid=${p.id}">
														<button type="button" class="btn btn-default btn-sm" >修改信息</button>
													</a>
												</c:if>

												<c:if test="${p.status=='Checked' }">
													<a href="foreAlter?pid=${p.id}">
														<button type="button" class="btn btn-default btn-sm" >修改信息</button>
													</a>
												</c:if>
												<c:if test="${p.status=='Finished' }">
													<a href="foreAlter?pid=${p.id}">
														<button type="button" class="btn btn-default btn-sm" disabled="disabled" >修改信息</button>
													</a>
												</c:if>

												
											</td>
									
									</tr>
								

							</table>
							</c:if>
						</c:forEach>

					</div>
					
				
				</div>
				
			<!-- myprojectdiv -->
				
								<div style="display:none;" role="myinfodiv">
					<div class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>用户名：</th>
									<th>${user.name}</th>
								</tr>

							</thead>
							<tbody>
								<tr>
									<th>已购买众筹：</th>
									<th>${user.userBuyNumber}</th>
								</tr>
								<tr>
									<th>总花费金额：</th>
									<th>${user.userBuyTotal}</th>
								</tr>
								<tr>
									<th>已获得众筹单数：</th>
									<th>${user.publishNumber}</th>
								</tr>
								<tr>
									<th>目前总众筹金额：</th>
									<th>${user.publishTotal}</th>
								</tr>


							</tbody>
						</table>
					</div>
				</div>
				<!-- myinfodiv -->




			</div><!-- col-xs-10 -->

		</div>
		<!-- row -->

	</div>