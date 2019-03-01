

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	

<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}"/>
</c:if>
	
<div class="categoryProducts">
	<c:forEach items="${c.products}" var="p" varStatus="stc">
		<c:if test="${stc.count<=categorycount}">
		<div class="productUnit" price="${p.price}">
			<div class="productUnitFrame">
				<a href="foreproduct?pid=${p.id}">
					<img class="productImage" src="img/productSingle_middle/${p.firstProductImage.id}.jpg">
				</a>
				<span class="productPrice">¥<fmt:formatNumber type="number" value="${p.price}" minFractionDigits="2"/></span>
				<a class="productLink" href="foreproduct?pid=${p.id}">
				 ${fn:substring(p.name, 0, 50)}
				</a>
				
				
	
				<div class="show1 productInfo">
				<span class="monthDeal "><strong style="font-size:14px">已筹 <span class="productDealNumber">￥${p.saleCount*p.price}</span></strong></span>
				
			</div>
			</div>
		</div>
		</c:if>
	</c:forEach>
		<div style="clear:both"></div>
</div>