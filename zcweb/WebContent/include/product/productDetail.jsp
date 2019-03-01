

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

	
<div class="productDetailDiv" >
	<div class="productDetailTopPart">
		<a href="#nowhere" class="productDetailTopPartSelectedLink selected">项目详情</a>
		<a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span class="productDetailTopReviewLinkNumber">${p.reviewCount}</span> </a>
	</div>
	
	
	<div class="productParamterPart">
		<div class="productParamter" style="font-size:20px;">项目详情</div>
		
		<div class="productParamterList" style="font-size:16px">
			<dl class="dl-horizontal">
				  <dt>项目发起人</dt>
				  <dd>${p.user.name}</dd>
				  <dt>项目简介</dt>
				  <dd>${p.detail}</dd>
				  <dt>项目回报</dt>
				  <dd>${p.reward}</dd>
			</dl>
		</div>
		<div style="clear:both"></div>
	</div>
	
	<div class="productDetailImagesPart">
		<c:forEach items="${p.productDetailImages}" var="pi">
			<img src="img/productDetail/${pi.id}.jpg">
		</c:forEach>
	</div>
</div>

