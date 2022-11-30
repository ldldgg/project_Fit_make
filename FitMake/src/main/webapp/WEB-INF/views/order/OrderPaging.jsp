<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<style type="text/css">
nav > ul{
	list-style-type: none;
	padding: 0px;
	overflow: hidden;
	background-color: #333333;
/*  	width: 700px;  */
	display: table;
	margin-left: auto;
	margin-right: auto;
}

nav > ul > li{
	float: left;
}

nav > ul > li > a{
	display: block;
	color: white;
	text-align: center;
	padding: 16px;
	text-decoration: none;
}

nav > ul > li > a:hover {
	color: #FFD9EC;
	background-color: #5D5D5D;
	font-weight: bold;
}

.active {
	color: #FFD9EC;
    background-color: #5D5D5D;
    font-weight: bold;
}

</style>

<script type="text/javascript" 
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
	window.onload = function(){
		var curPageDoc = $('#curPage');
		var pageButtonId = '#pageButton' + curPageDoc.val();
		
		$(pageButtonId).addClass('active');
		
	}
	
	function goPageFnc(pageNumber){
		var curPageObj = $("#curPage");
		curPageObj.val(pageNumber);
		
		$("#pagingForm").submit();
	}
</script>

<nav>
		<ul>
		<c:if test="${oPagingMap.orderPaging.prevBlock ne 1}">
			<li>
				<a href="#" 
					onclick="goPageFnc(${oPagingMap.orderPaging.prevBlock});">
					<span>«</span>
				</a>
			</li>
		</c:if>
		
		<c:forEach var="num" 
			begin="${oPagingMap.orderPaging.blockBegin}" 
			end="${oPagingMap.orderPaging.blockEnd}">
			<li id='pageButton${num}'>
				<a href="#" onclick="goPageFnc(${num});">
					<c:out value="${num}"/>
				</a>
			</li>
		</c:forEach>
		
		<c:if test="${oPagingMap.orderPaging.curBlock 
			< oPagingMap.orderPaging.totBlock}">
			<li>
				<a href="#" 
					onclick="goPageFnc(${oPagingMap.orderPaging.nextBlock});">
					<span>»</span>
				</a>
			</li>			
		</c:if>			
	
			
		</ul>
	</nav>