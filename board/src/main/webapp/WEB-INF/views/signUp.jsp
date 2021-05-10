<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>회원가입</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>

	// 아이디 중복 체크
	function idCheckFunc() {

		var data = {};
		data["userId"] = $("#id").val();

		$.ajax({
			type : "post",
			url : "signUp/idCheck",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
		    async : true,
			success : function(data) {
				userCheckMessage(data.result);
			},
			error : function(){
                alert("통신실패");
            }
		});
	}

	// 닉네임 중복 체크
	function nickCheckFunc() {

		var data = {};
		data["userNickname"] = $("#nickname").val();

		$.ajax({
			type : "post",
			url : "signUp/nickCheck",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
		    async : true,
			success : function(data) {
				userCheckMessage(data.result);
			},
			error : function(){
                alert("통신실패");
            }
		});
	}

	// 중복 결과
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

	// 회원 가입
	function signUp() {

		var data = {};
		data["userId"] = $("#id").val();
		data["userNickname"] = $("#nickname").val();
		data["userPw"] = $("#password").val();

		$.ajax({
			type : "post",
			url : "signUp",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
		    async : true,
			success : function(data) {
				if (data.result == "ok") {
					alert("회원가입 완료.");
					location.href="signIn";
				}
			},
			error : function(){
                alert("통신실패");
            }
		});
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
  <form action="signUp" method="post">
  
  	<!-- 아이디, 중복검사 버튼 -->
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
    
    <!-- 닉네임, 닉네임 중복검사 -->
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
    
    <!-- 비밀번호 -->
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
     
    <button type="button" class="btn btn-dark btn-block"style="margin-top: 50px;" onclick="signUp()">회원가입</button>
  </form>
</div>

</body>
</html>