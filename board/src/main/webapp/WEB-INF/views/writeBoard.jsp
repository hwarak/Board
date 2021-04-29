<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<body class="container" style="width: 40%;">

	<div class="container" style="height: 100px;"></div>

	<div class="container">
		<h2>글 쓰기</h2>
	</div>

	<div class="container" style="height: 40px;"></div>
	
	<form action="board" method="post">
	
		<div class="form-group">
			<div class="row">
				<div class="col-sm-2">
					<label for="title">말머리</label>
				</div>
				<div class="col-sm-10">
					<select class="form-control" id="boardSubject" name="boardSubject">
				        <option>기타</option>
				        <option>흥미로움</option>
				        <option>눈물</option>
				        <option>생활정보</option>
				        <option>분노</option>
				        <option>토론</option>
				        <option>분노</option>
				        <option>유머</option>
				      </select>
				</div>
			</div>
		</div>
	
	
		<div class="form-group">
			<div class="row">
				<div class="col-sm-2">
					<label for="title">제목</label>
				</div>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="boardTitle"
						placeholder="Enter title" name="boardTitle" required>
				</div>
			</div>
		</div>
		
	
	
		<div class="form-group">
		  <textarea class="form-control" rows="10" id="boardContents" name="boardContents"></textarea>
		</div>
	
		<button type="submit" class="btn btn-dark btn-block" style="margin-top: 50px;">등록</button>

	</form>

</body>
</html>