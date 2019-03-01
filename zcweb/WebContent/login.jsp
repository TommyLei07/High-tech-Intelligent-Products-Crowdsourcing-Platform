
<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@include file="include/header.jsp"%>

<%@include file="include/top.jsp"%>


<%@include file="include/myregisterPage.jsp"%>

<%@include file="include/footer.jsp"%>


 --%>



<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<html style="height:100%;width:100%">

<head>
	<script src="js/jquery/2.0.0/jquery.min.js"></script>
	<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<!-- <link href="css/fore/style.css" rel="stylesheet"> -->
	<link href="css/fore/style3.css" rel="stylesheet">
	<link href="css/fore/backstyle.css" rel="stylesheet">
<script>

function checkEmpty(id, name){
	var value = $("#"+id).val();
	if(value.length==0){
		
		$("#"+id)[0].focus();
		return false;
	}
	return true;
}


$(function(){

	
	
	
	

});

</script>	
</head>

<body style="height:100%;width:100%">


<%@include file="include/myregisterPage.jsp"%>

</body>
</html>



	
	
	