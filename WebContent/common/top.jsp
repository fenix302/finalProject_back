<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ESHOP 쇼핑몰 프로그램</title>
<link href="${context}/css/bootstrap.min.css" rel="stylesheet">
<link href="${context}/css/bootstrap-theme.css" rel="stylesheet">
<link href="${context}/css/common.css" rel="stylesheet">
<script src="${context}/js/common.js"></script>
<script src="${context}/js/bootstrap.min.js"></script>
<style type="text/css">
li{
	cursor: pointer;
}
a{
	text-decoration:none !important;
}
</style>
</head>


<c:set var="homeUrl">${context}/work/product/goMain.do</c:set>
<c:set var="loginUrl">${context}/user/login.jsp</c:set>

<c:set var="neckUrl">${context}/work/product/retrieveProductList.do?category=N</c:set>
<c:set var="ringUrl">${context}/work/product/retrieveProductList.do?category=R</c:set>
<c:set var="braceletUrl">${context}/work/product/retrieveProductList.do?category=B</c:set>
<c:set var="earUrl">${context}/work/product/retrieveProductList.do?category=E</c:set>
<body>
	<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
		<div class="container" style="background-color: black;">
			<ul class="nav navbar-nav">
				<li><a href="${homeUrl}"><font color="white"><strong>HS STATIONERY</strong></font></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li>
					<c:if test="${sessionScope.id != null && sessionScope.grade != 'A'}">
						<a href="${context}/work/cart/retrieveCartList.do"><font color="white"><strong>장바구니</strong></font></a>
					</c:if>
					<c:if test="${sessionScope.id != null && sessionScope.grade == 'A'}">
						<a href="${context}/work/product/retrieveProductListForManage.do"><font color="white"><strong>재고관리</strong></font></a>
					</c:if>
				</li>
				<li>
					<c:if test="${sessionScope.id != null && sessionScope.grade != 'A'}">
						<a href="${context}/work/sell/retrieveBuyList.do"><font color="white"><strong>구매내역</strong></font></a>
					</c:if>
					<c:if test="${sessionScope.id != null && sessionScope.grade == 'A'}">
						<a href="${context}/work/sell/retrieveStatisticsForProduct.do"><font color="white"><strong>매출통계</strong></font></a>
					</c:if>
				</li>
				<li>
					<c:if test="${sessionScope.id == null}">
						<a href="${context}/work/user/createUser.do"><font color="white"><strong>회원가입</strong></font></a>
					</c:if>
					<c:if test="${sessionScope.id != null && sessionScope.grade != 'A'}">
						<a href="${context}/work/user/updateUser.do"><font color="white"><strong>정보수정</strong></font></a>
					</c:if>
					<c:if test="${sessionScope.id != null && sessionScope.grade == 'A'}">
						<a href="${context}/work/product/retrieveStatisticsForStock.do?productCategoryCd=P"><font color="white"><strong>재고현황</strong></font></a>
					</c:if>
				</li>
				<li>
					<c:if test="${sessionScope.id == null}">
						<a href="${context}/user/login.jsp"><font color="white"><strong>LOGIN</strong></font></a>
					</c:if>
					<c:if test="${sessionScope.id != null}">
						<a href="${context}/work/user/logout.do"><font color="white"><strong>LOGOUT</strong></font></a>
					</c:if>
				</li>
			</ul>
		</div>
	</nav>
		<div class="container" style="background-color: white; margin-bottom: 2%;">
		<c:if test="${sessionScope.grade != 'A'}">
		  	<p style="font-size: 70px;"><a href="${context}/work/product/goMain.do" style="color: black;"><b>HS STATIONERY</b></a></p>
		  <ul class="list-inline">
		    <li><a onclick="javascript:fn_isLogin('${sessionScope.userCode}','${loginUrl}','${ringUrl}')" style="color: black; font-size: 25px;">반지&nbsp;&nbsp;|</a></li>
		    <li><a onclick="javascript:fn_isLogin('${sessionScope.userCode}','${loginUrl}','${neckUrl}')" style="color: black; font-size: 25px;">목걸이&nbsp;&nbsp;|</a></li>
		    <li><a onclick="javascript:fn_isLogin('${sessionScope.userCode}','${loginUrl}','${earUrl}')" style="color: black; font-size: 25px;">귀걸이&nbsp;&nbsp;|</a></li>
		    <li><a onclick="javascript:fn_isLogin('${sessionScope.userCode}','${loginUrl}','${braceletUrl}')" style="color: black; font-size: 25px;">팔찌&nbsp;&nbsp;|</a></li>
		  </ul>
	  	</c:if>
	  	<c:if test="${sessionScope.id != null && sessionScope.grade == 'A'}">
	  		<p style="font-size: 70px;"><a href="${context}/work/product/goMain.do" style="color: black;"><b>HS STATIONERY</b></a></p>
	  		<h1>관리자 모드입니다.</h1>
	  	</c:if>
	</div>
</body>
</html>