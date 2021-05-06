<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>신고 리스트</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
<script type="text/javascript">

	//홈으로 돌아가기
	function goMainFunc(){
		location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
	}

	// 로그아웃
	$(document).ready(function(e){
	   $('#logout').click(function() {
		   alert("로그아웃되었습니다");
	   });
	});

	// 신고 종류 바뀌면 리스트 뿌려주기
	$(document).ready(function(){
		 var formData = new FormData();
	    $('#reportSubject').on('change', function() {
		    var reportSubject = $("#reportSubject option:selected").val();
			$.ajax({
				type : "get",
				url : "reportList?reportSubject="+reportSubject,
				dataType : "text",
				data : formData, 
				contentType: false, 
				processData: false, 
				cache : false,
				success : function(data) {
					var html = jQuery('<div>').html(data);
					var contents = html.find("div#reportListAjax").html();
					$("#reportList").html(contents);
				},
				error : function(){
			              alert("통신실패");
			          }
				});
	    });
	});

</script>
</head>
<body>

<div class="container" >

	<div class="container" style="height: 80px;"></div>

	<div class="container" style="height: 50px;">
		<!-- 홈 / 신고관리 / 로그아웃 버튼 -->
		<ul class="nav justify-content-end">
			<li class="nav-item"><a class="nav-link" href="javascript:goMainFunc();"
				style="color: black;">홈</a></li>
			<li class="nav-item"><a class="nav-link" href="report"
				style="color: black;">신고 관리</a></li>
			<li id="logout" class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
				style="color: black;">로그아웃</a></li>
		</ul>
	</div>
	
	<div class="container" style="height: 40px;"></div>
	
	<div class="container" style="height: 40px;">
		<select class="form-control" id="reportSubject" name="reportSubject">
	        <option>폭력적 또는 혐오스러운 콘텐츠</option>
	        <option>성적인 콘텐츠</option>
	        <option>증오 또는 악의적인 콘텐츠</option>
	        <option>유해하거나 위험한 콘텐츠</option>
	        <option>테러 조장</option>
	        <option>스팸 또는 오해의 소지가 있는 콘텐츠</option>
	        <option>권리 침해</option>
      	</select>
	</div>
  
  	<div class="container" style="height: 20px;"></div>
  
  	<!-- 표 -->
  	<div class="container" id="reportList">
		<table class="table table-hover">
			 <thead>
				<tr>
					<th style="width: 10%;">no. </th>
					<th style="width: 90%;">접수된 신고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}">
				  	<tr onclick="location.href='${pageContext.request.contextPath}/board?boardIdx=${item.boardIdx}&userIdx=${item.userIdx}'" style="cursor:pointer;">
						<td>${item.reportIdx }</td>
						<td>
							<a style="font-size: 15px;"><b>${item.reportTitle }</b></a><br>
							<a style="font-size: 15px;">${item.reportContents }</a><br>
							<a style="font-size: 13px;"><b>[${item.boardSubject}] ${item.boardTitle }</b></a>
					  	</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
  	</div>
  	
</div>


</body>
</html>