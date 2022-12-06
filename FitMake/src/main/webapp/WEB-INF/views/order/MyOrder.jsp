<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('#searchBtn').on('click', function(){
			var searchOptionVal = $('#searchOption').val();
			var searchTextVal = $('#searchText').val();
			
			location.href = './list.do?searchOption=' + searchOptionVal + '&searchText=' + searchTextVal;
		});
		
	});
	
	function orderUpdateFnc(oNo){
		var checkOrderCancel = confirm("주문을 취소하시겠습니까?");
		
		if(checkOrderCancel == true){
			$('#orderListForm' + oNo).attr('action', './update.do');
			$('#orderListForm' + oNo).attr('method', 'post');
			$('#orderListForm' + oNo).submit();
		} else {
			return false;
		}
	}
</script>
<style type="text/css">
	#orderRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-between;
	}
	#pagingDiv{
		display: flex;
		flex-direction: column;
	}
	#myOrderDiv{
		width : 1000px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#orderViewTitle{
		font-size: 26px;
		font-weight: 600;
	}
	.orderListDiv{
		border: 1px solid black;
		border-radius: 10px;
		padding: 10px;
		margin: 30px;
 		display: flex; 
		flex-direction: column;
	}
	#orderSummaryDiv{
		margin: 5px;
		display:flex;
		justify-content: space-between
	}
	#orderContainer{
		border: 1px solid black;
		border-radius: 10px;
		padding: 10px;
		margin: 10px;
	}
	#orderUpdateDiv{
		margin: 5px;
		display:flex;
		justify-content: space-between
	}
	#orderTable{
		position: relative;
		width: 100%;
	}
	.orderTableDetail{
		text-align: right;
	}
	#pagingNav {
		display: flex;
	}
	#orderViewTitleEmpty{
		font-size: 20px;
		font-weight: 600;
		text-align: center;
	}
	.myOrderImg, .myOrderImg > img{
		width : 300px;
		height: 200px;
	}
	.myOrderUpdateBtn {
		margin-left: 10px;
		width: auto;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
	#writeReviewBtn{
		margin-left: 10px;
		width: auto;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
</style>
<title>FitMake</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="orderRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="pagingDiv">
			<div id="myOrderDiv">
				<jsp:include page="../MyPageNav.jsp" />
				<div id="titleDiv">
					<p id="orderViewTitle">주문/배송 조회</p>
				</div>
				
				<c:forEach var="orderMap" items="${orderMapList}">
					<c:if test="${orderMap.oRownum eq '1'}">
						<form id="orderListForm${orderMap.FM_ORDER_NO}">
							<div class="orderListDiv">
								<input type="hidden" name="oNoArr" value="${orderMap.FM_ORDER_NO}">
								<input type="hidden" name="oStatusArr"  value="cancel">
								
								<div id="orderSummaryDiv">
									${orderMap.FM_ORDER_DATE} 주문
									<span id="orderDetailViewSpan">
										<a href="./detail.do?oNo=${orderMap.FM_ORDER_NO}">
											<span class="viewOrderDetail">주문상세보기</span>
										</a>
									</span>
								</div>
								<div id="orderContainer">
									<div id="orderUpdateDiv">
										<c:choose>
											<c:when test="${orderMap.FM_ORDER_STATUS eq 'pending'}">
												주문대기
													<span>
														<input class="myOrderUpdateBtn" type="button" value="주문취소" onclick="orderUpdateFnc(${orderMap.FM_ORDER_NO});">
													</span>
											</c:when>
											<c:when test="${orderMap.FM_ORDER_STATUS eq 'confirm'}">
												주문승인
													<span>
														<input class="myOrderUpdateBtn" type="button" value="주문취소" onclick="orderUpdateFnc(${orderMap.FM_ORDER_NO});">>
													</span>
											</c:when>
											<c:when test="${orderMap.FM_ORDER_STATUS eq 'cancel'}">
												주문취소
											</c:when>
											<c:otherwise>
												구매확정
													<span>
														<input id="writeReviewBtn" type="button" value="리뷰쓰기">
													</span>
											</c:otherwise>
										</c:choose>
									</div>
									<table id="orderTable">
										<tr>
											<td class="myOrderImg" colspan="2" rowspan="3">
												<img alt="image not founed" src="<c:url value='/image/${orderMap.FM_ITEM_STORED_IMG_NAME}'/>">
											</td>
											<td class="orderTableDetail" colspan="2">
												<c:choose>
														<c:when test="${orderMap.oCount == 1}">
																${orderMap.FM_ITEM_NAME}
														</c:when>
														<c:otherwise>
															${orderMap.FM_ITEM_NAME} 외 ${orderMap.oCount-1}개
														</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td>
											</td>
											<td>
											</td>
										</tr>
										<tr>
											<td>
											</td>
											<td class="orderTableDetail">
											<fmt:formatNumber value="${orderMap.totalPrice}" />원
											</td>
										</tr>
									</table>
								</div>
							</div>
						</form>
					</c:if>
				</c:forEach>
				<c:if test="${orderMapList.size() < 1}">
					<p id="orderViewTitleEmpty">주문 내역이 없습니다</p>
				</c:if>
			</div>
		<jsp:include page="/WEB-INF/views/order/OrderPaging.jsp" />
		</div>
	</div>
	
	<div id="pagingSection">
		<form id="pagingForm" action="./list.do" method="get">
			<input type="hidden" id="curPage" name="curPage" value="${oPagingMap.orderPaging.curPage}">
		</form>
	</div>
	
</body>
</html>