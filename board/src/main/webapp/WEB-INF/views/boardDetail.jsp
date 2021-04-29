<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script type="text/javascript">
	function deleteBoardFunc(){

		var data = {};
		data["boardIdx"] = ${boardInfo.boardIdx};

		$.ajax({
			type : "delete",
			url : "board",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
			async : false,
			success : function(data) {
				
				if (data.result == "ok") {
					alert("삭제 완료.");
					location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
				}

			},
			error : function(){
                alert("통신실패");
            }
		});
	}
	
		
	
</script>
</head>
<body class="container" style="width: 50%;" >

	<div class="container" style="height: 100px;"></div>
	
	<div class="container" style="height: 60px;">
		<h2>[${boardInfo.boardSubject}] ${boardInfo.boardTitle}</h2>
	</div>

	<div class="container" style="height: 50px;">
		<div class="row">
			<!-- 닉네임/날짜 -->
			<div class="col-sm-6">
				<p>${boardInfo.userNickname} &nbsp|&nbsp ${boardInfo.boardDate} &nbsp|&nbsp조회수 : ${boardInfo.boardViews} 회</p>
			</div>
			
			<!-- 글 수정/삭제/신고 -->
			<div class="col-sm-6">
				<%	if (session.getAttribute("userIdx") == session.getAttribute("writerIdx")) { %>
				<!-- 수정/ 삭제 -->
					<div style="float: right;">
						<button type="button" class="btn btn-dark" onclick="location.href='writeBoard?boardIdx=${boardInfo.boardIdx}'">수정</button>
						<button type="button" class="btn btn-dark" onclick="deleteBoardFunc();">삭제</button>
					</div>
				<% } else { %>
				<!-- 신고하기-->
					<div style="float: right;">
						<button type="button" class="btn btn-dark">신고하기</button>
					</div>
				<% } %>
			
				
			</div>
		</div>
	</div>
	
	<div class="container" style="height: 10px;">
		<hr color="grey" size="10px">
	</div>
	
	<div class="container" style="height: 10px;"></div>
	
	<div class="container" style="height: 400px;">
		<p>${boardInfo.boardContents}</p>
	</div>
	
	<div class="container" style="height: 10px;">
		<hr color="grey" size="10px">
	</div>
	
	<div class="container" style="height: 10px;"></div>
	
	<div class="container" style="height: 20px;">
		<p style="font-size: 18px;"><b>댓글  ${boardInfo.boardComments}개 </b></p>
	</div>
	
	<div class="container" style="height: 20px;"></div>
	
	<div class="container" style="height: 150px;">
		<form action="/action_page.php">
			<div class="form-group">
				<textarea class="form-control" rows="2" id="comment" name="text"></textarea>
			</div>
			<button type="button" class="btn btn-dark btn-block">리뷰 등록</button>
		</form>
	</div>
	
	<div class="container" >
	  <ul class="list-group">
	    <li class="list-group-item">
	    	<p>닉네임</p>
	    	<p>댓글내용입니다.댓글내용입니다.댓글내용입니다.댓글내용입니다.</p>
	    </li>
	    <li class="list-group-item">
	    	<p>닉네임</p>
	    	<p>댓글내용입니다.댓글내용입니다.댓글내용입니다.댓글내용입니다.</p>
	    </li>
	    <li class="list-group-item">
	    	<p>닉네임</p>
	    	<p>댓글내용입니다.댓글내용입니다.댓글내용입니다.댓글내용입니다.</p>
	    </li>
	  </ul>
	</div>
	
	<div class="container" style="height: 100px;"></div>


</body>
</html>