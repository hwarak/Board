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
<script type="text/javascript">


function insertBoardFunc(){

	var data = {};
	data["boardSubject"] = $("#boardSubject").val();
	data["boardTitle"] = $("#boardTitle").val();
	data["boardContents"] = $("#boardContents").val();
	data["userIdx"] = <%=session.getAttribute("userIdx")%>;
	
	$.ajax({
		type : "post",
		url : "board",
		data : JSON.stringify(data),
	    dataType: "json",
	    contentType:"application/json;charset=UTF-8",
	    async : true,
		success : function(data) {
			if (data.result == "ok") {
				alert("등록이 완료되었습니다.");
				location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
			} 
		},
		error : function(){
            alert("통신실패");
        }
	});
}

function updateBoardFunc(){
	var data = {};
	data["boardSubject"] = $("#boardSubject").val();
	data["boardTitle"] = $("#boardTitle").val();
	data["boardContents"] = $("#boardContents").val();
	data["boardIdx"] = <%=session.getAttribute("boardIdx")%>;
	
	$.ajax({
		type : "put",
		url : "board",
		data : JSON.stringify(data),
	    dataType: "json",
	    contentType:"application/json;charset=UTF-8",
	    async : true,
		success : function(data) {
			if (data.result == "ok") {
				alert("수정 완료.");
				location.href="board?boardIdx="+<%=session.getAttribute("boardIdx")%>+"&userIdx=${boardInfo.userIdx}";
			}
		},
		error : function(){
            alert("통신실패");
        }
	});
}

function goMainFunc(){
	location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
}

$(document).ready(function(e){
	   $('#logout').click(function() {
		   alert("로그아웃되었습니다");
	   });
	});
</script>
</head>
<body class="container" style="width: 40%;">

	<div class="container" style="height: 80px;"></div>

	<!-- 로그인/회원가입/내정보/로그아웃 -->
	<div class="container" style="height: 50px;">
			<%	if (session.getAttribute("userIdx") == null) { %>
			<!-- 로그인/회원가입 버튼 -->
				<ul class="nav justify-content-end">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="signIn"
						style="color: black;">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="signUp"
						style="color: black;">회원가입</a></li>
				</ul>
			<% } else { %>
			<!-- 내 정보 /로그아웃 버튼-->
				<ul class="nav justify-content-end">
					<li class="nav-item"><a class="nav-link" href="javascript:goMainFunc();" 
						style="color: black;">홈</a></li>
					<li id="logout" class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">로그아웃</a></li>
				</ul>
			<% } %>
	</div>
	
	<div class="container" style="height: 40px;"></div>

	<div class="container">
		<h2>글 쓰기</h2>
	</div>

	<div class="container" style="height: 40px;"></div>

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
			<%	if (session.getAttribute("boardIdx") == null) { %>
				<input type="text" class="form-control" id="boardTitle"
					placeholder="Enter title" name="boardTitle" required>
			<% } else { %>
				<input type="text" class="form-control" id="boardTitle"
					value="${boardInfo.boardTitle}" name="boardTitle"  required>
			<% } %>
				
			</div>
		</div>
	</div>
	


	<div class="form-group">
		<%	if (session.getAttribute("boardIdx") == null) { %>
		<textarea class="form-control" rows="10" id="boardContents" name="boardContents"></textarea>
		<% } else { %>
		<textarea class="form-control" rows="10" id="boardContents" name="boardContents">${boardInfo.boardContents}</textarea>
		<% } %>
	</div>
	
	<%	if (session.getAttribute("boardIdx") == null) { %>
	<button type="button" class="btn btn-dark btn-block" style="margin-top: 50px;" onclick="insertBoardFunc();">등록</button>
	<% } else { %>
	<button type="button" class="btn btn-dark btn-block" style="margin-top: 50px;" onclick="updateBoardFunc();">등록</button>
	<% } %>
	


</body>
</html>