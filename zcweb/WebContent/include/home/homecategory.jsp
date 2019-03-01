
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}"/>
</c:if>

<div class="homepageCategoryProducts">
	<c:forEach items="${cs}" var="c" varStatus="stc">
		<c:if test="${stc.count<=categorycount}">
			<div class="eachHomepageCategoryProducts">
				<div class="left-mark"></div>
				<a href="forecategory?cid=${c.id}"><span class="categoryTitle">${c.name}</span></a>
				<br>
				<c:forEach items="${c.products}" var="p" varStatus="st">
					<c:if test="${st.count<=3}">
					<c:if test="${p.status=='Checked'}">
						<div class="productItem" >
							<a href="foreproduct?pid=${p.id}"><img width="100px" src="img/productSingle_middle/${p.firstProductImage.id}.jpg"></a>
							<a class="productItemDescLink" href="foreproduct?pid=${p.id}">
								<span class="productItemDesc">[热销]
								${fn:substring(p.name, 0, 20)}
								</span>
						    </a>
							<span class="productPrice">
								<fmt:formatNumber type="number" value="${p.price}" minFractionDigits="2"/>
							</span>
						</div>
					</c:if>		
					</c:if>			
				</c:forEach>
				<div style="clear:both"></div>
			</div>
		</c:if>
	</c:forEach>
	


</div>