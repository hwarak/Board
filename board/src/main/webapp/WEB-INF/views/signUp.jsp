<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
	function idCheckFunc() {

		var userId = $("#id").val();

		$.ajax({
			type : "get",
			url : "signUp/idCheck?userId=" + userId,
			async : true,
			success : function(data) {
				userCheckMessage(data);
			}
		});
	}

	function nickCheckFunc() {

		var userNickname = $("#nickname").val();

		$.ajax({
			type : "get",
			url : "signUp/nickCheck?userNickname=" + userNickname,
			async : true,
			success : function(data) {
				userCheckMessage(data);
			}
		});
	}

	function userCheckMessage(data) {
		if (data == 0) {
			alert("가입 가능.");
		} else if (data == 1) {
			alert("이미 존재하는 아이디.");
			$("#id").empty();
		} else {
			alert("이미 존재하는 닉네임.");
			$("#nickname").empty();
		}
	}
</script>

</head>



<body class="container" style="width: 45%;">

<div class="container" style="height: 100px;"></div>

<div class="container">
  <h2>회원가입</h2>
</div>

<div class="container" style="height: 40px;"></div>

<div class="container">
  <form action="signUp" method="post" name="userInfo">
  
    <div class="form-group">
	    <div class="row">
		  <div class="col-sm-2">
		  	<label for="uname">아이디</label>
		  </div>
		  <div class="col-sm-7">
		  	<input type="text" class="form-control" id="id" placeholder="Enter id" name="userId" required>
		  </div>
		  <div class="col-sm-3">
		  	<button type="button" class="btn btn-dark btn-block" onclick="idCheckFunc()">아이디 중복검사</button>
		  </div>
		</div>
    </div>
    
    <div class="form-group">
	 	<div class="row">
		  <div class="col-sm-2">
		  	<label for="uname">닉네임</label>
		  </div>
		  <div class="col-sm-7">
		  	<input type="text" class="form-control" id="nickname" placeholder="Enter nickname" name="userNickname" required>
		  </div>
		  <div class="col-sm-3">
		  	<button type="button" class="btn btn-dark btn-block" onclick="nickCheckFunc()">닉네임 중복검사</button>
		  </div>
		</div>
    </div>
    
    <div class="form-group">
	 	<div class="row">
		  <div class="col-sm-2">
		  	<label for="uname">비밀번호</label>
		  </div>
		  <div class="col-sm-10">
		  	<input type="password" class="form-control" id="password" placeholder="Enter password" name="userPw" required>
		  </div>
		</div>
    </div>
     
    <button type="submit" class="btn btn-dark btn-block"style="margin-top: 50px;">회원가입</button>
  </form>
</div>

</body>
</html>