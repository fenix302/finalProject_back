<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="sellConfirmR.jsp">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>결제 완료 페이지</title>

	<link href="${context}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${context}/css/bootstrap-theme.css" rel="stylesheet">
	<link href="${context}/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="${context}/css/plugins/dataTables.bootstrap.css" rel="stylesheet">

    <link href="${context}/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${context}/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
        <link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Noto+Serif+KR:wght@200&display=swap"
    rel="stylesheet"
 />
    
    <link href="${context}/css/buy.css" rel="stylesheet">
    
	<script src="${context}/js/jquery-1.9.1.js"></script>
	<script src="${context}/js/bootstrap.min.js"></script>

    <script src="${context}/js/plugins/metisMenu/metisMenu.min.js"></script>

    <script src="${context}/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="${context}/js/plugins/dataTables/dataTables.bootstrap.js"></script>

    <script src="${context}/js/sb-admin-2.js"></script>

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
			location.href = "${context}/work/sell/updateFinalBuy.do?sellCode=" + paramSellCode + "&sellCount=" + paramSellCount + "&productCode=" + paramProductCode;
		}
    }

    function fn_buyList(){
    	location.href = "${context}/work/sell/retrieveBuyList.do";
    }


    function fn_review(paramProductCode){
    	location.href = "${context}/work/product/retrieveProduct.do?productCode=" + paramProductCode;
    }


    </script>
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/common/top.jsp"></jsp:include>



<!-- 페이지 헤더 -->
<div class="page_header">
	 <div class="confirmR_header">
	       <div class="name">
	             <p class="comeText">결제 완료</p>
	        </div>
	  </div>
</div>


<!-- 본문 -->
 <div class="container">
        <div class="row" style="margin-bottom: 150px;">
            <div class="col-md-12">
                <div class="offer offer-succes" >

					<div class="offer-content">
						<div class="offer-content check_img_box">
						<img class="check_img" src="${context}/css/images/check.png" alt="check">
						</div>
						
						<div class="offer-content end_span_box">
						<span class="end_span"> &nbsp; &nbsp; 결제가 완료되었습니다! &nbsp; &nbsp;</span>
						</div>
						<br>
						<h5 align="center" style="font-family: Noto Sans KR;">
							구매내역에서 결제 및 구매 정보를 확인하실 수 있습니다.
							<br>감사합니다.
						</h5>
					</div>
					
					
					<!-- 버튼 -->
	                <div class="q1">
	                	<label class="col-md-2"></label>           
	                	<div class="btn_box">
							<button type="button" class="btn user-back-btn" onclick="fn_buyList()"> <p class="btn_text"> 구매내역 </p> </button>
			                <button class="btn user-submit-btn " type="button" name="btnSubmit" id="btnSubmit" onclick="fn_review('${productCode}')"> <p class="btn_text"> 후기 작성 </p> </button>
	                	</div>       
	                </div>	
	                					
                </div>
            </div>
        </div>
    </div>


<!-- 본문(구버전) -->
<%-- 	<div id="jumbotron" class="container">
		<div class="row" style="margin-bottom: 10%;">
			<div class="col-md-12">
				<div class="offer offer-success">
					<div class="offer-content">
					<br><br><br>
						<h1 align="center" style="font-family: inherit;">
							결제가 완료되었습니다.
						</h1>
						<br><br><br>
						<h2 align="center" style="font-family: cursive;">
							구매내역에서 정보를 확인하실 수 있습니다.
							<br><br> 감사합니다.
						</h2>
					</div>
					<br><br><br><br>
					
					<div class="col-md-1 col-md-offset-4">
						<button type="button" class="btn btn-info btn-lg"  style="float:right;" onclick="fn_buyList()"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;구매내역 보러가기</button>
					</div>
					<div class="col-md-5">
						<button type="button" class="btn btn-warning btn-lg"  style="float:right;" onclick="fn_review('${productCode}')"><span class="glyphicon glyphicon-pencil"></span>&nbsp;상품평   쓰러가기</button>
					</div>
					<br><br><br><br><br>
				</div>

			</div>
			<!-- /.col-lg-12 -->

		</div>

	</div> --%>
<jsp:include page="/common/foot.jsp"></jsp:include>
</body>
</html>