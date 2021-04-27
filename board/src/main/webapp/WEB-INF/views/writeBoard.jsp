<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="container" style="width: 40%;">

	<div class="container" style="height: 100px;"></div>

	<div class="container">
		<h2>로그인</h2>
	</div>

	<div class="container" style="height: 40px;"></div>


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