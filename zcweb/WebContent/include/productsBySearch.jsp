

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	
<div class="searchProducts">
	
	<c:forEach items="${ps}" var="p">
		<div class="productUnit" price="${p.price}">
			<a href="foreproduct?pid=${p.id}">
				<img class="productImage" src="img/productSingle/${p.firstProductImage.id}.jpg">
			</a>
			<span class="productPrice">¥<fmt:formatNumber type="number" value="${p.price}" minFractionDigits="2"/></span>
			<a class="productLink" href="foreproduct?pid=${p.id}" style="font-size:14px">
			 ${fn:substring(p.name, 0, 50)}
			</a>
			
		

			<div class="show1 productInfo">
				<span class="monthDeal "><strong style="font-size:14px">已筹 <span class="productDealNumber">￥${p.saleCount*p.price}</span></strong></span>
				
			</div>
			
		</div>
	</c:forEach>
	<c:if test="${empty ps}">
		<div class="noMatch">没有满足条件的项目<div>
	</c:if>
	
		<div style="clear:both"></div>
</div>