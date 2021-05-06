<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
	// 아이디 비밀번호 체크
	function checkIdPwFunc() {
	
		var data = {};
		data["userId"] = $("#id").val();
		data["userPw"] = $("#pw").val();
	
		$.ajax({
			type : "post",
			url : "signIn/checkIdPw",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
		    async : true,
			success : function(data) {
				if (data.result == 0) {
					alert("로그인 실패.");
					$("#id").empty();
					$("#pw").empty();
				}else {
					alert("로그인 성공");
					location.href="main?userIdx="+data.result;
				}
			},
			error : function(){
	               alert("통신실패");
	           }
		});
	}
  
</script>
</head>
<body class="container" style="width: 40%;">

	<div class="container" style="height: 100px;"></div>

	<div class="container">
		<h2>로그인</h2>
	</div>

	<div class="container" style="height: 40px;"></div>

	<!-- 아이디 -->
	<div class="form-group">
		<div class="row">
			<div class="col-sm-2">
				<label for="id">아이디</label>
			</div>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="id"
					placeholder="Enter id" name="id" required>
			</div>
		</div>
	</div>

	<!-- 비밀번호 -->
	<div class="form-group">
		<div class="row">
			<div class="col-sm-2">
				<label for="password">비밀번호</label>
			</div>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="pw"
					placeholder="Enter password" name="pw" required>
			</div>
		</div>
	</div>

	<button type="button" class="btn btn-dark btn-block"
		style="margin-top: 50px;" onclick="checkIdPwFunc()">로그인</button>




</body>
</html>