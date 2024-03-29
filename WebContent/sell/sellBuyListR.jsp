<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="sellBuyListR.jsp">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>구매내역</title>
	
	<link href="${context}/css/bootstrap.css" rel="stylesheet">
<%-- 	<link href="${context}/css/bootstrap-theme.css" rel="stylesheet"> --%>
	<link href="${context}/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="${context}/css/plugins/datatables.css" rel="stylesheet">

    <link href="${context}/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${context}/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <link href="${context}/css/buy.css" rel="stylesheet">
    
	<script src="${context}/js/jquery-1.9.1.js"></script>
<%-- 	<script src="${context}/js/bootstrap.min.js"></script> --%>

    <script src="${context}/js/plugins/metisMenu/metisMenu.min.js"></script>

<%--     <script src="${context}/js/plugins/dataTables/jquery.dataTables.js"></script> --%>
    <script src="${context}/js/plugins/dataTables/datatables.js"></script>

    <script src="${context}/js/sb-admin-2.js"></script>

    <script>
	var existFolder = '';
	var imageFolder = '';
	var path = '';

    $(document).ready(function() {
        $('#dataTables-example').dataTable();

    });

    function fn_review(paramProductCode){
    	location.href = "${context}/work/product/retrieveProduct.do?productCode=" + paramProductCode;
    }
    function fn_review2(paramProductCode){
    	location.href = "${context}/work/product/retrieveProduct2.do?productCode=" + paramProductCode;
    }

    </script>
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/common/top.jsp"></jsp:include>


<!-- 페이지 헤더 -->
<div class="page_header">
	 <div class="buyList_header">
	       <div class="name">
	             <p class="comeText">구매내역</p>
	        </div>
	  </div>
</div>


<%-- 		<div class="buy-main">
			<h1><font color="black"><strong>구매내역</strong>&nbsp;<i class="fa fa-credit-card fa-1x"></i></font></h1>
			<p>${sessionScope.id}님의 구매내역입니다.</p>
		</div> --%>


<!-- 본문 -->
	<div id="jumbotron" class="container">
	
		<div class="buy-main">
<!-- 			<h1><font color="black"><strong>장바구니</strong>&nbsp;<span class="glyphicon glyphicon-shopping-cart"></span></font></h1> -->
			<h4><font color="black"><strong>${sessionScope.name}님의 구매내역입니다.</strong></font></h4>
		</div>
		<div class="row" style="margin-bottom: 10%;">
			<div class="col-md-12" style="margin-bottom: 10px;">
			    <div class="panel panel-default">
			        <!-- /.panel-heading -->
			        <div class="panel-body">
			            <div class="table-responsive">
			                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
			                    <thead>
			                        <tr>
			                        	<th style="text-align: center; vertical-align: middle; width: 10px;" class="responseC">No</th>
			                            <th style="text-align: center; vertical-align: middle; width: 20px;" class="responseC">상품이미지</th>
			                            <th style="text-align: center; vertical-align: middle; width: 50px;">상품이름</th>
			                            <th style="text-align: center; vertical-align: middle; width: 20px;" class="responseC">상품단가</th>
			                            <th style="text-align: center; vertical-align: middle; width: 40px;">상품수량</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;">결제금액</th>
			                            <th style="text-align: center; vertical-align: middle; width: 10px;">상품평</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                    	<c:forEach items="${dsBuyList}" var="dsBuyList" varStatus="buyIdx">
			                         <tr>
			                         	<td style="text-align: center; vertical-align: middle;" class="responseC">${buyIdx.count}</td>
			                            <td style="text-align: center; vertical-align: middle;" class="responseC">
										<img name="image" width="110px" height="110px" src="${context}/coffeeImg/${dsBuyList.PRODUCT_IMAGE}" class="img-thumbnail">
											<script type="text/javascript">
											 	var productCategoryCd = '${dsBuyList.PRODUCT_CATEGORY_CD}';

											 	if(productCategoryCd == 'C'){
													imageFolder = "coffeeImg";
												}else if(productCategoryCd == 'G'){
													imageFolder = "goodsImg";
												}else if(productCategoryCd == 'P'){
													imageFolder = "presentImg";
												}else if(productCategoryCd == 'R'){
													imageFolder = "regularImg";
												}
												path = $("img[name='image']").eq('${buyIdx.index}').attr("src");

												existFolder = path.split("/")[1];
												$("img[name='image']").eq('${buyIdx.index}').attr("src", path.replace(existFolder, imageFolder));
											</script>
			                            </td>
			                            <td style="text-align: center; vertical-align: middle;">${dsBuyList.PRODUCT_NAME}</td>
			                            <td style="text-align: center; vertical-align: middle;" class="responseC">${dsBuyList.PRODUCT_UNIT_PRICE}원</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsBuyList.SELL_COUNT}</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsBuyList.SELL_PRICE}원</td>
			                            <td style="text-align: center; vertical-align: middle;">
			                            <c:if test="${dsBuyList.PRODUCT_CATEGORY_CD == 'C' || dsBuyList.PRODUCT_CATEGORY_CD == 'G' || dsBuyList.PRODUCT_CATEGORY_CD == 'P'}">
			                            	<button type="button" class="btn btn-warning" onclick="fn_review('${dsBuyList.PRODUCT_CODE}')">상품평 쓰러가기</button>
			                            </c:if>
			                            <c:if test="${dsBuyList.PRODUCT_CATEGORY_CD == 'R'}">
			                            	<button type="button" class="btn btn-warning" onclick="fn_review2('${dsBuyList.PRODUCT_CODE}')">상품평 쓰러가기</button>
			                            </c:if>
			                            </td>
			                         </tr>
			                        </c:forEach>
			                    </tbody>
			                </table>
			            </div>
			            <!-- /.table-responsive -->
			        </div>
			        <!-- /.panel-body -->
			    </div>
			    <!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
			<div class="col-md-1 offset-md-11">
				<button type="button" class="btn buy-back-btn"  style="float:right;" onclick="fn_back()">뒤로가기</button>
			</div>
		</div>
	</div>
<jsp:include page="/common/foot.jsp"></jsp:include>
</body>
</html>