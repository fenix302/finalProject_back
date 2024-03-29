<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="sellListR.jsp">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>주문 정보</title>

	<link href="${context}/css/bootstrap.css" rel="stylesheet">
<%-- 	<link href="${context}/css/bootstrap-theme.css" rel="stylesheet"> --%>
	<link href="${context}/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="${context}/css/plugins/datatables.css" rel="stylesheet">

    <link href="${context}/css/sb-admin-2.css" rel="stylesheet">
        <link href="${context}/css/buy.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${context}/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<script src="${context}/js/jquery-1.9.1.js"></script>
<%-- 	<script src="${context}/js/bootstrap.min.js"></script> --%>

    <script src="${context}/js/plugins/metisMenu/metisMenu.min.js"></script>

<%--     <script src="${context}/js/plugins/dataTables/jquery.dataTables.js"></script> --%>
    <script src="${context}/js/plugins/dataTables/datatables.js"></script>

<%--     <script src="${context}/js/sb-admin-2.js"></script> --%>
    
   	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

    <script>
	var existFolder = '';
	var imageFolder = '';
	var path = '';

    $(document).ready(function() {
//         $('#dataTables-example').dataTable();

    });

    function fn_eval(self, resumePassYn, examNo){
   		$.ajax({
   			url:"${context}/work/applicant/updateEvalForResume.do?resumePassYn=" + resumePassYn + "&examNo=" + examNo,
   			success:function(result){
   				result = result.replace(/"/gi, "");
   				self.parent().next().children().html(result);
   			}
   		});
    }

    function fn_selEval(resumePassYn){
		var checked = $("input[name='chkBox']:checked");
		var checkedCnt = $("input[name='chkBox']:checked").length;

		var examNo = "";

		for(var i = 0; i < checkedCnt; i++){
			examNo = checked.eq(i).parent().parent().children("td").eq(3).html();
			$.ajax({
	   			url:"${context}/work/applicant/updateEvalForResume.do?resumePassYn=" + resumePassYn + "&examNo=" + examNo,
	   			async: false,
	   			success:function(result){
	   				result = result.replace(/"/gi, "");
	   				checked.eq(i).parent().parent().children("td").eq(10).html(result);
	   			}
	   		});
		}
    }

    function fn_resumeDetail(self){
    	var examNo = self.parent().parent().children("td").eq(3).html();

    	location.href = "${context}/work/applicant/retrieveResumeDetail.do?examNo=" + examNo;
    }

    function fn_save(){
    	var examNo = '${dsSellList[0].examNo}';

		if(confirm("서류심사를 완료하시겠습니까?")){
			location.href = "${context}/work/incruit/updateIStatusForResume.do?examNo=" + examNo;
		}
    }

    function fn_finalBuy(paramSellCode, paramSellCount, paramProductCode){
		if(confirm("결제하시겠습니까?")){
			location.href = "${context}/work/sell/updateFinalBuy2.do?sellCode=" + paramSellCode + "&sellCount=" + paramSellCount + "&productCode=" + paramProductCode;
		}
    }
    
    function fn_cd_buy(paramSellCode, paramSellCount, paramProductCode) {
        if(confirm("결제하시겠습니까?")){
    		var IMP = window.IMP;
    		IMP.init('imp28503804'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
    		// IMP.request_pay(param, callback) 결제창 호출
    	      IMP.request_pay({ // param
    	          pg: "html5_inicis",
    	          pay_method: "card",
    	          merchant_uid: 'merchant_' + new Date().getTime(),
    	          name: $(".pdName").text(),
    	          amount: 10,
    	          buyer_email: "${sessionScope.email}",
    	          buyer_name: "${sessionScope.name}",
    	          buyer_tel: "${sessionScope.phoneNum}",
    	          buyer_addr: "${sessionScope.address}",
    	          buyer_postcode: "${sessionScope.postNum}",
    	          m_redirect_url : "/paymentDone.do"
    	      }, function (rsp) { // callback
    	          if (rsp.success) {
    	             var paymentInfo = {
    	            		 imp_uid : rsp.imp_uid,
    	            		 merchant_uid : rsp.merchant_uid,
    	            		 paid_amount : rsp.paid_amount,
    	            		 per_num : rsp.apply_num,
    	            		 per_time : new Date(),
    	             		 name : rsp.name,
    	             		 buyer_name : rsp.buyer_name,
    	             		 buyer_email : rsp.buyer_email,
    	             		 buyer_tel : rsp.buyer_tel,
    	             		 buyer_addr : rsp.buyer_addr,
    	             		 buyer_postcode : rsp.buyer_postcode,
    	             		 product_category_cd : $(".pdCd").val()
    	             };
    	           
    	          $.ajax({
    	        	 url : "/paymentProcess.do",
    	        	 method : "POST",
    	        	 contentType : "application/json",
    	        	 data : JSON.stringify(paymentInfo),
    	        	 success:function(data, textStatus){
    	        		 console.log(paymentInfo);
    	        		 location.href = "/paymentDone.do";
    	        	 },
    	        	 error : function(e) {
    					console.log(e);
    				}        	  
    	          });
    	          location.href = "${context}/work/sell/updateFinalBuy2.do?sellCode=" + paramSellCode + "&sellCount=" + paramSellCount + "&productCode=" + paramProductCode;
    	          } else {
    	              alert("결제 실패 : " + rsp.error_msg);	        	  
    	          }
    	      });
    	    }
        }
    
    
    </script>
</head>
<body>
	<jsp:include page="/common/top.jsp"></jsp:include>

	<!-- 페이지 헤더 -->
	<div class="page_header">
		 <div class="sellList_header">
		       <div class="name">
		             <p class="comeText">주문정보</p>
		        </div>
		  </div>
	</div>
	
	
<!-- 		<div class="jumbotron jumbotron-info" style="background-color: lightgray;">
			<h1><font color="black"><strong>주문정보</strong>&nbsp;<i class="fa fa-credit-card fa-1x"></i></font></h1>
			<p>주문 정보를 확인해주세요</p>
		</div> -->
		
		
	<div id="jumbotron" class="container">
	
		<div class="buy-main">
<!-- 			<h1><font color="black"><strong>장바구니</strong>&nbsp;<span class="glyphicon glyphicon-shopping-cart"></span></font></h1> -->
			<h4><font color="black"><strong>${sessionScope.name}님의 주문정보입니다.</strong></font></h4>
		</div>	

		<div class="row">
			<div class="col-md-12">
			    <div class="panel panel-default">
			        <!-- /.panel-heading -->
			        <div class="panel-body">
			            <div class="table-responsive">
			                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
			                    <thead>
			                        <tr>
			                        	<th style="text-align: center; vertical-align: middle; width: 30px; display: none;">상품코드번호</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;" class="responseC">상품이미지</th>
			                            <th style="text-align: center; vertical-align: middle; width: 80px;">상품이름</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;" class="responseC">상품단가</th>
			                            <th style="text-align: center; vertical-align: middle; width: 50px;">상품수량</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;">결제금액</th>
			                            <th style="text-align: center; vertical-align: middle; width: 20px;">결제</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                    	<c:forEach items="${dsSellList}" var="dsSellList" varStatus="sellIdx">
			                         <tr>
			                         	<td style="text-align: center; vertical-align: middle; display: none;">${dsSellList.SELL_CODE}</td>
			                            <td style="text-align: center; vertical-align: middle;" class="responseC">
										<img name="image" width="110px" height="110px" src="${context}/coffeeImg/${dsSellList.PRODUCT_IMAGE}" class="img-thumbnail">
											<script type="text/javascript">
											 	var productCategoryCd = '${dsSellList.PRODUCT_CATEGORY_CD}';

											 	if(productCategoryCd == 'C'){
													imageFolder = "coffeeImg";
												}else if(productCategoryCd == 'G'){
													imageFolder = "goodsImg";
												}else if(productCategoryCd == 'P'){
													imageFolder = "presentImg";
												}else if(productCategoryCd == 'R'){
													imageFolder = "regularImg";
												}
												path = $("img[name='image']").eq('${dsProductIdx.index}').attr("src");

												existFolder = path.split("/")[1];
												$("img[name='image']").eq('${sellIdx.index}').attr("src", path.replace(existFolder, imageFolder));
											</script>
			                            </td>
			                            <td style="text-align: center; vertical-align: middle;" class="pdName">${dsSellList.PRODUCT_NAME}</td>
			                            <td style="text-align: center; vertical-align: middle;" class="responseC">${dsSellList.PRODUCT_UNIT_PRICE}원</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsSellList.SELL_COUNT}</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsSellList.SELL_PRICE}원</td>
			                            <td style="text-align: center; vertical-align: middle;">
			                            <input type="hidden" class="pdCd" value="${dsSellList.PRODUCT_CATEGORY_CD}">
<%-- 			                            	<button type="button" class="btn btn-primary" onclick="fn_finalBuy('${dsSellList.SELL_CODE}', '${dsSellList.SELL_COUNT}', '${dsSellList.PRODUCT_CODE}')">결제하기</button> --%>
			                            	<button type="button" class="btn btn-primary" onclick="fn_cd_buy('${dsSellList.SELL_CODE}', '${dsSellList.SELL_COUNT}', '${dsSellList.PRODUCT_CODE}')">결제하기</button>
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
			
			<div class="div_btn col-md-1 col-md-offset-11">
				<button type="button" class="btn btn-success btn-lg back_btn"  onclick="fn_back()">뒤로가기</button>
			</div>
		</div>
	</div>
<jsp:include page="/common/foot.jsp"></jsp:include>
</body>
</html>